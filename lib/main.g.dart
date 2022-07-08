part of 'main.dart';

var title = "Music Player";
var duration = 10;
bool showVol = false;
bool isPlaying = false;
double _volume = 1;
var sliderValue = 0;
var screenMode = 'list'; // 'mixed', 'player', 'list'
var videoId = "";
var iframeInitialized = false;

MyAppState myAppState;
AudioPlayer audioPlayer = AudioPlayer();

//List<SongInfo2> songList = new List.empty(growable: true);
Map songList;

var curSongIdx = -1;
var playNextSong = (idxIncrease) {
  curSongIdx += idxIncrease;
  if (curSongIdx < 0) {
    curSongIdx += songList.length;
  } else if (curSongIdx >= songList.length) {
    curSongIdx -= songList.length;
  }

  sliderValue = 0;
  duration = 0;
  isPlaying = false;

  SongInfo2 song = songList[curSongIdx];
  print('isYoutube: ${song.isYoutube}');
  if (!song.isYoutube) {
    if (song.filePath.startsWith('http:') ||
        song.filePath.startsWith('https:')) {
      audioPlayer.play(UrlSource(song.filePath));
    } else {
      audioPlayer.play(DeviceFileSource(song.filePath));
    }

    iframeInitialized = false;
  } else {
    audioPlayer.stop();
    var keyPattern = "watch?v=";
    var startPos = song.filePath.indexOf(keyPattern);
    videoId = song.filePath.substring(startPos + keyPattern.length);

    myAppState.setState(() {
      if (screenMode == "list") screenMode = "mixed";
    });
  }
};
