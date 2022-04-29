import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_music_player/songWidget.dart';
import 'package:flutter_music_player/widget.dart';
import 'package:flutter_music_player/playerWidget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    setupAudio();
  }

  void setupAudio() {
    audioPlayer.onAudioPositionChanged.listen((Duration p) {
      sliderValue = p.inSeconds;
      if (duration <= sliderValue) duration = sliderValue + 10;
      setState(() {});
    });
    //audioPlayer.onPlayerStateChanged.listen((Event e) {
    //});
    audioPlayer.onSeekComplete.listen((PlayerState s) {: (value) {
                    setState(() {
                      sliderValue = value.floor();
                    });
                  },
    audioPlayer.onPlayerCompletion.listen((event) {});
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
              : Text("Music Player"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 450,
              child: FutureBuilder(
                future: FlutterAudioQuery()
                    .getSongs(sortType: SongSortType.RECENT_YEAR),
                builder: (context, snapshot) {
                  List<SongInfo2> songInfo;
                  if (snapshot.hasData) {
                    songInfo = snapshot.data;
                  } else {
                    songInfo = new List.empty(growable: true);
                  }

                  songInfo.add(SongInfo2.fromURL(
                      "https://truemaxdh.github.io/MusicTreasureHouse/ArirangTroll/ArirangTroll.mp3"));
                  songInfo.add(SongInfo2.fromURL(
                      "https://truemaxdh.github.io/MusicTreasureHouse/FirstFlight/FirstFlight.mp3"));

                  //if (snapshot.hasData) return SongWidget(songList: songInfo);
                  // return Container(
                  //     height: MediaQuery.of(context).size.height * 0.4,
                  //     child: Center(
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: <Widget>[
                  //           CircularProgressIndicator(),
                  //           SizedBox(
                  //             width: 20,
                  //           ),
                  //           Text(
                  //             "Loading....",
                  //             style: TextStyle(fontWeight: FontWeight.bold),
                  //           )
                  //         ],
                  //       ),
                  //     ),

                  // );
                  return SongWidget(songList: songInfo);
                },
              ),
            ),
            playerWidget(context),
          ],
        ),
      ),
    );
  }

  

}

//var audioPlayer = AudioManager.instance;
AudioPlayer audioPlayer = AudioPlayer();
var duration = 10;
bool showVol = false;
bool isPlaying = false;
double _volume = 1;
var sliderValue = 0;
