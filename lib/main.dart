import 'package:audioplayers/audioplayers.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_player/widget.dart';
import 'package:flutter_music_player/songListWidget.dart';
import 'package:flutter_music_player/playerWidget.dart';
import 'package:flutter_music_player/youtubePlayerWidget.dart';
import 'package:flutter_music_player/hiveBase.dart';

part 'main.g.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await putDBTestData();
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
  ); // To turn off landscape mode
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
      if (curSong['mp3Url'].length == 0) return;

      if (isPlaying) {
        sliderValue = p.inSeconds;

        setState(() {});

        if (duration != 0 && sliderValue == duration) {
          playNextSong(1);
        }
      }
    });
    audioPlayer.onPlayerStateChanged.listen((PlayerState s) {
      if (curSong['mp3Url'].length == 0) return;

      print('Song PlayerState: $s');
      isPlaying = (s == PlayerState.playing);
      setState(() {});
    });
    audioPlayer.onDurationChanged.listen((Duration p) {
      if (curSong['mp3Url'].length == 0) return;

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
      ),
    );
  }

  List<Widget> getBodyChildren() {
    List<Widget> ret = [];
    if (screenMode == "list" || screenMode == "mixed") {
      ret.add(getSongListContainer());
    }
    if (screenMode == "player" || screenMode == "mixed") {
      if (curSong['ytbVideoId'].length > 0) {
        var _size = MediaQuery.of(context).size;
        ret.add(youtubePlayerWidget(_size));
      }
      ret.add(PlayerWidget());
    }
    return ret;
  }
}
