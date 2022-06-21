import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_player/widget.dart';
import 'package:flutter_music_player/songListWidget.dart';
import 'package:flutter_music_player/playerWidget.dart';
import 'package:flutter_music_player/youtubePlayerWidget.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart' as ytb;

void main() {
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
    myAppState = this;
  }

  void setupAudio() {
    audioPlayer.onPositionChanged.listen((Duration p) {
      //print('Position: ${p.inSeconds}');
      if (isPlaying) {
        sliderValue = p.inSeconds;
        setState(() {});

        if (duration != 0 && sliderValue == duration) {
          playNextSong(1);
        }
      }
    });
    audioPlayer.onPlayerStateChanged.listen((PlayerState s) {
      print('Song PlayerState: $s');
      isPlaying = (s == PlayerState.playing);
      setState(() {});
    });
    audioPlayer.onDurationChanged.listen((Duration p) {
      duration = p.inSeconds;
      setState(() {});
    });
  }
  
  void setupYoutube() {
    youtubePlayerController.listen((evt) {
      sliderValue = evt.position.inSeconds;
      duration = evt.metaData.duration.inSeconds;
      var playerState = evt.playerState;
      //print('Ytb Song PlayerState: $playerState');
      isPlaying = (playerState == ytb.PlayerState.playing);
      setState(() {});

      if (duration != 0 && sliderValue == (duration - 1)) {
        playNextSong(1);
      }
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
                      audioPlayer.setVolume(value);
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
        ret.add(youtubePlayerWidget());
      }
      ret.add(playerWidget(context));
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

MyAppState myAppState;
AudioPlayer audioPlayer = AudioPlayer();
ytb.YoutubePlayerController youtubePlayerController;

List<SongInfo2> songList = new List.empty(growable: true);
var curSongIdx = -1;
var playNextSong = (idxIncrease) {
  curSongIdx += idxIncrease;
  if (curSongIdx < 0) {
    curSongIdx += songList.length;
  } else if (curSongIdx >= songList.length) {
    curSongIdx -= songList.length;
  }

  SongInfo2 song = songList[curSongIdx];
  print('isYoutube: ${song.isYoutube}');
  if (!song.isYoutube) {
    if (song.filePath.startsWith('http:') ||
        song.filePath.startsWith('https:')) {
      audioPlayer.play(UrlSource(song.filePath));
    } else {
      audioPlayer.play(DeviceFileSource(song.filePath));
    }
    title = "Music Player";
  } else {
    audioPlayer.stop();
    var keyPattern = "watch?v=";
    var startPos = song.filePath.indexOf(keyPattern);
    var videoId =
        song.filePath.substring(startPos + keyPattern.length);
    youtubePlayerController = ytb.YoutubePlayerController(
      initialVideoId: videoId,
      params: ytb.YoutubePlayerParams(
        startAt: Duration(seconds: 1),
        showFullscreenButton: true,
      ),
    );
    myAppState.setupYoutube();
    
    myAppState.setState(() {
      if (screenMode == "list") screenMode = "mixed";
    });
  }
};
