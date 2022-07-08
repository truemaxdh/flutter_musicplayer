import 'dart:io';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_player/widget.dart';

import 'main.dart';

class SongWidget extends StatelessWidget {
  SongWidget();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: songList.length,
        itemBuilder: (context, songIndex) {
          var song = songList.values.elementAt(songIndex);
          if (song['title'].length > 0)
            return Card(
              color: (curSongIdx == songIndex)
                  ? Colors.green.shade100
                  : Colors.white,
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    ClipRRect(
                      child: Image(
                        height: 90,
                        width: 150,
                        fit: BoxFit.cover,
                        image: getIcon(song),
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Text(song['title'],
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700)),
                              ),
                              Text("Artist: ${song['artist']}",
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              curSongIdx = songIndex;
                              screenMode = "mixed";
                              playNextSong(0);
                            },
                            child: IconText(
                              iconData: Icons.play_circle_outline,
                              iconColor: Colors.red,
                              string: "Play",
                              textColor: Colors.black,
                              iconSize: 25,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );

          return SizedBox(
            height: 0,
          );
        });
  }

  static String parseToMinutesSeconds(int ms) {
    String data;
    Duration duration = Duration(milliseconds: ms);

    int minutes = duration.inMinutes;
    int seconds = (duration.inSeconds) - (minutes * 60);

    data = minutes.toString() + ":";
    if (seconds <= 9) data += "0";

    data += seconds.toString();
    return data;
  }
}
