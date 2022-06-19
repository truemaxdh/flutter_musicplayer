import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_music_player/widget.dart';
import 'package:flutter_music_player/main.dart';
import 'package:flutter_music_player/songWidget.dart';

Expanded getSongListContainer() {
  var httpClient = http.Client();
  var musicDomain = "https://truemaxdh.github.io";
  var musicListPath = "/MusicTreasureHouse/README.md";

  return Expanded(
    flex: 1,
    child: Container(
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
                var url = musicDomain +
                    lines[i].substring(
                        lines[i].indexOf(".mp3") + 6, lines[i].length - 1);
                songList.add(
                    SongInfo2.abbreviated(title, "", "Danny Choi", url, false));
              } else if (lines[i].indexOf(".ytb") > 0) {
                var title = lines[i].substring(1, lines[i].indexOf(".ytb"));
                var url = lines[i].substring(
                    lines[i].indexOf(".ytb") + 6, lines[i].length - 1);
                songList.add(
                    SongInfo2.abbreviated(title, "", "Danny Choi", url, true));
              }
            }
            return SongWidget();
          } else {
            return Container(
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
  );
}
