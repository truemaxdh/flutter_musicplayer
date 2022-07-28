part of 'main.dart';

String title = "Music Player";
var duration = 10;
bool showVol = false;
bool isPlaying = false;
double _volume = 1;
var sliderValue = 0;
var screenMode = 'list'; // 'mixed', 'player', 'list'
var videoId = "";
var iframeInitialized = false;

late MyAppState myAppState;
late SongWidgetState songWidgetState;

late Map songList;
late Map curSong;

AudioPlayer audioPlayer = AudioPlayer();

//List<SongInfo2> songList = new List.empty(growable: true);

int curSongIdx = -1;
var playNextSong = (int idxIncrease) {
  curSongIdx += idxIncrease;
  if (curSongIdx < 0) {
    curSongIdx += songList.length;
  } else if (curSongIdx >= songList.length) {
    curSongIdx -= songList.length;
  }

  sliderValue = 0;
  duration = 0;
  isPlaying = false;

  curSong = songList.values.elementAt(curSongIdx);
  if (curSong['mp3Url'].length > 0) {
    if (curSong['mp3Url'].startsWith('http:') ||
        curSong['mp3Url'].startsWith('https:')) {
      audioPlayer.play(UrlSource(curSong['mp3Url']));
    } else {
      audioPlayer.play(DeviceFileSource(curSong['mp3Url']));
    }

    iframeInitialized = false;
  } else if (curSong['ytbVideoId'].length > 0) {
    audioPlayer.stop();
    videoId = curSong['ytbVideoId'];
  }
  
  //if (screenMode == "list") screenMode = "mixed";
  myAppState.redraw();
  if (screenMode == "list" || screenMode == "mixed") {
    songWidgetState.redraw();
  }
};

ImageProvider Function(Map song) getIcon = (Map song) {
  if (song['mp3Url'].length > 0) {
    return const AssetImage('assets/mp3.png');
  } else if (song['ytbVideoId'].length > 0) {
    return const AssetImage('assets/youtube.png');
  } else {
    return const NetworkImage(
        "https://avatars.githubusercontent.com/u/12081386?s=120&v=4");
  }
};

Future<void> checkForUpdate() async {
  if (!kIsWeb) {
    AppUpdateInfo updateInfo = await InAppUpdate.checkForUpdate();
    if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
      await InAppUpdate.performImmediateUpdate();
      //.catchError((e) => showSnack(e.toString()));
    }
  }
}
