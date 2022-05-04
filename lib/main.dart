import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_player/songWidget.dart';
import 'package:flutter_music_player/widget.dart';
import 'package:flutter_music_player/playerWidget.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var musicDomain = "https://truemaxdh.github.io";
  var musicListPath = "/MusicTreasureHouse/README.md";
  var httpClient = http.Client();

  @override
  void initState() {
    super.initState();
    setupAudio();
  }

  void setupAudio() {
    audioPlayer.onAudioPositionChanged.listen((Duration p) {
      //print('Position: ${p.inSeconds}');
      if (isPlaying) {
        sliderValue = p.inSeconds;
        if (duration <= sliderValue) duration = sliderValue + 10;
        setState(() {});
      }
    });
    audioPlayer.onPlayerStateChanged.listen((PlayerState s) {
      //print('PlayerState: ${s}');
      isPlaying = (s == PlayerState.PLAYING);
      setState(() {});
    });
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
                future: httpClient.get(Uri.parse(musicDomain + musicListPath)),
                builder: (context, snapshot) {
                  
                  if (snapshot.hasData) {
                    var response = snapshot.data;
                    //print('Response status: ${response.statusCode}');
                    //print('Response body: ${response.body}');
                    
                    songList.clear();
                    var lines = response.body.split("\n");
                    for (var i = 0; i < lines.length; i++) {
                      if (lines[i].indexOf(".mp3") > 0) {
                        var title = lines[i].substring(1, lines[i].indexOf(".mp3"));
                        var url = musicDomain +  lines[i].substring(lines[i].indexOf(".mp3") + 6, lines[i].length - 1);
                        songList.add(SongInfo2.abbreviated(title, "", "Danny Choi", url));
                      }
                    }
                    return SongWidget();
                  } else {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircularProgressIndicator(),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Loading....",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    );
                  }
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

AudioPlayer audioPlayer = AudioPlayer();
List<SongInfo2> songList = new List.empty(growable: true);
var curSongIdx = 0;
var playCurrentSong = () {
  SongInfo2 song = songList[curSongIdx];
  if (song.filePath.startsWith('http:') || song.filePath.startsWith('https:')) {
    audioPlayer.play(song.filePath);
  } else {
    audioPlayer.play(song.filePath, isLocal: true);
  }
};

var duration = 10;
bool showVol = false;
bool isPlaying = false;
double _volume = 1;
var sliderValue = 0;
