import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_music_player/songWidget.dart';
import 'package:flutter_music_player/widget.dart';

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
    audioPlayer.onDurationChanged.listen((Duration d) {
      duration = d.inSeconds;
    });
    audioPlayer.onAudioPositionChanged.listen((Duration p) {
      _slider = p.inSeconds / duration;
      setState(() {});
    });
    audioPlayer.onPlayerStateChanged.listen((PlayerState s) {
      isPlaying = (s == PlayerState.PLAYING);
      setState(() {});
    });
    audioPlayer.onPlayerCompletion.listen((event) {});
  }
  /*audioPlayer.onEvents((events, args) {
      switch (events) {
        case AudioManagerEvents.start:
          _slider = 0;
          break;
        case AudioManagerEvents.seekComplete:
          _slider = audioPlayer.position.inMilliseconds /
              audioPlayer.duration.inMilliseconds;
          setState(() {});
          break;
        case AudioManagerEvents.playstatus:
          isPlaying = audioPlayer.isPlaying;
          setState(() {});
          break;
        case AudioManagerEvents.timeupdate:
          _slider = audioPlayer.position.inMilliseconds /
              audioPlayer.duration.inMilliseconds;
          audioPlayer.updateLrc(args["position"].toString());
          setState(() {});
          break;
        case AudioManagerEvents.ended:
          audioPlayer.next();
          setState(() {});
          break;
        default:
          break;
      }
    }*/

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
                  value: 0.5,
                  onChanged: (value) {
                    setState(() {
                      audioPlayer.setVolume(value);
                    });
                  },
                )
              : Text("Music app demo"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 500,
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
            bottomPanel(),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration d) {
    if (d == null) return "--:--";
    int minute = d.inMinutes;
    int second = (d.inSeconds > 60) ? (d.inSeconds % 60) : d.inSeconds;
    String format = ((minute < 10) ? "0$minute" : "$minute") +
        ":" +
        ((second < 10) ? "0$second" : "$second");
    return format;
  }

  Widget songProgress(BuildContext context) {
    var style = TextStyle(color: Colors.black);
    return Row(
      children: <Widget>[
        Text(
          _formatDuration(Duration(seconds: duration)),
          style: style,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 2,
                  thumbColor: Colors.blueAccent,
                  overlayColor: Colors.blue,
                  thumbShape: RoundSliderThumbShape(
                    disabledThumbRadius: 5,
                    enabledThumbRadius: 5,
                  ),
                  overlayShape: RoundSliderOverlayShape(
                    overlayRadius: 10,
                  ),
                  activeTrackColor: Colors.blueAccent,
                  inactiveTrackColor: Colors.grey,
                ),
                child: Slider(
                  value: _slider ?? 0,
                  onChanged: (value) {
                    setState(() {
                      _slider = value;
                    });
                  },
                  onChangeEnd: (value) {
                    audioPlayer
                        .seek(Duration(seconds: (duration * value).floor()));
                  },
                )),
          ),
        ),
        Text(
          _formatDuration(Duration(seconds: duration)),
          style: style,
        ),
      ],
    );
  }

  Widget bottomPanel() {
    return Column(children: <Widget>[
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: songProgress(context),
      ),
      Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CircleAvatar(
              child: Center(
                child: IconButton(
                    icon: Icon(
                      Icons.skip_previous,
                      color: Colors.white,
                    ),
                    onPressed: () {}),
              ),
              backgroundColor: Colors.cyan.withOpacity(0.3),
            ),
            CircleAvatar(
              radius: 30,
              child: Center(
                child: IconButton(
                  onPressed: () async {
                    audioPlayer.resume();
                  },
                  padding: const EdgeInsets.all(0.0),
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            CircleAvatar(
              backgroundColor: Colors.cyan.withOpacity(0.3),
              child: Center(
                child: IconButton(
                    icon: Icon(
                      Icons.skip_next,
                      color: Colors.white,
                    ),
                    onPressed: () {}),
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}

//var audioPlayer = AudioManager.instance;
AudioPlayer audioPlayer = AudioPlayer();
var duration = 0;
bool showVol = false;
bool isPlaying = false;
double _slider;
