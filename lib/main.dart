import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_player/songWidget.dart';
import 'package:flutter_music_player/widget.dart';
import 'package:flutter_music_player/playerWidget.dart';
import 'package:http/http.dart' as http;

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
      print('PlayerState: ${s}');
      isPlaying = (s == PlayerState.PLAYING);
      if (s == PlayerState.COMPLETED) {
        print('curSongIdx: ${curSongIdx}');
        playNextSong(1);
        print('curSongIdx: ${curSongIdx}');
      }
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
                      audioPlayer.setVolume(value);
                    });
                  },
                )
              : Text("Music Player"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>() {
          	if ( screenMode == 'mixed' || screenMode == 'list') {
		  return [
			Container(
			  height: MediaQuery.of(context).size.height * 0.8,
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
						var title =
							lines[i].substring(1, lines[i].indexOf(".mp3"));
						var url = musicDomain +
							lines[i].substring(lines[i].indexOf(".mp3") + 6,
								lines[i].length - 1);
						songList.add(SongInfo2.abbreviated(
							title, "", "Danny Choi", url));
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
				playerWidget(context, this),
		  ];
          	} else {
          		return [playerWidget(context, this),];
          	}
          }
        ),
      ),
    );
  }
}

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
var screenMode = 'mixed'; // 'mixed', 'player', 'list'
