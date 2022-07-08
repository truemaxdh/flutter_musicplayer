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
Map curSong;

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

  curSong = songList[curSongIdx];
  if (curSong['mp3Url'].length > 0) {
    if (song.filePath.startsWith('http:') ||
        song.filePath.startsWith('https:')) {
      audioPlayer.play(UrlSource(song.filePath));
    } else {
      audioPlayer.play(DeviceFileSource(song.filePath));
    }

    iframeInitialized = false;
  } else if (curSong['ytbVideoId'].length > 0) {
    audioPlayer.stop();
    videoId = curSong['ytbVideoId'];

    myAppState.setState(() {
      if (screenMode == "list") screenMode = "mixed";
    });
  }
};
