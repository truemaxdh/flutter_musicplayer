import 'package:audioplayers/audioplayers.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_player/widget.dart';
import 'package:flutter_music_player/songListWidget.dart';
import 'package:flutter_music_player/playerWidget.dart';
import 'package:flutter_music_player/youtubePlayerWidget.dart';
import 'package:flutter_music_player/hiveBase.dart';

Future<void> main() async {
  await Hive.initFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player',
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    setupAudio();
    putDBTestData();
    myAppState = this;
  }

  void setupAudio() {
    audioPlayer.onPositionChanged.listen((Duration p) {
      if (songList[curSongIdx].isYoutube) return;

      if (isPlaying) {
        sliderValue = p.inSeconds;

        setState(() {});

        if (duration != 0 && sliderValue == duration) {
          playNextSong(1);
        }
      }
    });
    audioPlayer.onPlayerStateChanged.listen((PlayerState s) {
      if (songList[curSongIdx].isYoutube) return;

      print('Song PlayerState: $s');
      isPlaying = (s == PlayerState.playing);
      setState(() {});
    });
    audioPlayer.onDurationChanged.listen((Duration p) {
      if (songList[curSongIdx].isYoutube) return;

      duration = p.inSeconds;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    showVol = !showVol;
                  });
                },
                child: IconText(
                    textColor: Colors.white,
                    iconColor: Colors.white,
                    string: "volume",
                    iconSize: 20,
                    iconData: Icons.volume_down),
              ),
            )
          ],
          elevation: 0,
          backgroundColor: Colors.black,
          title: showVol
              ? Slider(
                  min: 0,
                  max: 1,
                  value: _volume,
                  onChanged: (value) {
                    setState(() {
                      _volume = value;
                      if (songList[curSongIdx].isYoutube) {
                        //youtubePlayerController.setVolume((value * 100).toInt());
                      } else {
                        audioPlayer.setVolume(value);
                      }
                    });
                  },
                )
              : Text(title),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: getBodyChildren()),
      ),
    );
  }

  List<Widget> getBodyChildren() {
    List<Widget> ret = [];
    if (screenMode == "list" || screenMode == "mixed") {
      ret.add(getSongListContainer());
    }
    if (screenMode == "player" || screenMode == "mixed") {
      if (songList[curSongIdx].isYoutube) {
        var _size = MediaQuery.of(context).size;
        ret.add(youtubePlayerWidget(_size));
      }
      ret.add(PlayerWidget());
    }
    return ret;
  }
}

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

List<SongInfo2> songList = new List.empty(growable: true);
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
