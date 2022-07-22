import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:in_app_update/in_app_update.dart';

import 'package:flutter_music_player/hiveBase.dart';
import 'package:flutter_music_player/songWidget.dart';
import 'package:flutter_music_player/playerWidget.dart';
import 'package:flutter_music_player/youtubePlayerWidget.dart';
import 'package:flutter_music_player/editSonginfo.dart';
import 'package:flutter_music_player/editSongList.dart';

part 'main.g.dart';
part 'drawerMenu.dart';

Future<void> main() async {
  await checkForUpdate();
  await Hive.initFlutter();
  await initSonglist();
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  ); // To turn off landscape mode
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Music Player',
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    //setupAudio();

    myAppState = this;
  }

  /*void setupAudio() {
    audioPlayer.onPositionChanged.listen((Duration p) {
      if (curSong['mp3Url'].length == 0) return;

      if (isPlaying) {
        sliderValue = p.inSeconds;

        playerWidgetState.setState(() {});

        if (duration != 0 && sliderValue == duration) {
          playNextSong(1);
        }
      }
    });
    audioPlayer.onPlayerStateChanged.listen((PlayerState s) {
      if (curSong['mp3Url'].length == 0) return;

      if (kDebugMode) {
        print('Song PlayerState: $s');
      }
      isPlaying = (s == PlayerState.playing);
      playerWidgetState.setState(() {});
    });
    audioPlayer.onDurationChanged.listen((Duration p) {
      if (curSong['mp3Url'].length == 0) return;

      duration = p.inSeconds;
      playerWidgetState.setState(() {});
    });
  }*/

  void redraw() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getDrawerMenu(context),
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
              child: const Icon(Icons.volume_down, size: 35),
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
                    if (curSong['ytbVideoId'].length > 0) {
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
    );
  }

  List<Widget> getBodyChildren() {
    List<Widget> ret = [];
    if (screenMode == "list" || screenMode == "mixed") {
      ret.add(
        //getSongListContainer()
        const Expanded(
          flex: 1,
          child: SongWidget(),
        ),
      );
    }
    if (screenMode == "player" || screenMode == "mixed") {
      if (curSong['ytbVideoId'].length > 0) {
        var size = MediaQuery.of(context).size;
        ret.add(youtubePlayerWidget(size));
      }
      ret.add(const PlayerWidget());
    }
    return ret;
  }
}
