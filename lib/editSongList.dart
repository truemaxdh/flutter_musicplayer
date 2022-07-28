import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_music_player/hiveBase.dart';

import 'main.dart';

class EditSongListWidget extends StatefulWidget {
  const EditSongListWidget({Key? key}) : super(key: key);
  
  @override
  EditSongListWidgetState createState() => EditSongListWidgetState();
}

class EditSongListWidgetState extends State<EditSongListWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Song List'),
      ),
      body: ListView.builder(
          itemCount: songList.length,
          itemBuilder: (context, songIndex) {
            var song = songList.values.elementAt(songIndex);
            if (song['title'].length > 0) {
              return Card(
                color: (curSongIdx == songIndex)
                    ? Colors.green.shade100
                    : Colors.white,
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Image(
                        height: 70,
                        width: 100,
                        fit: BoxFit.cover,
                        image: getIcon(song),
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Text(song['title'],
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700)),
                                ),
                                Text("Artist: ${song['artist']}",
                                    style: const TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                            InkWell(
                              onTap: () => showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        title: const Text('Confirm Delete'),
                                        content: const Text(
                                            'Are you sure to delete this song?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () async {
                                              await box.delete(song['title']);
                                              await initSonglist();
                                              Navigator.pop(context, 'OK');
                                              songWidgetState.redraw();
                                              setState(() {});
                                            },
                                            child: const Text('OK'),
                                          ),
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                context, 'Cancel'),
                                            child: const Text('Cancel'),
                                          ),
                                        ],
                                      )),
                              child: const Icon(
                                Icons.delete,
                                size: 30,
                                //iconColor: Colors.red,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const SizedBox(
                height: 0,
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.pop(context);
        },
        tooltip: 'Close',
        child: const Icon(Icons.exit_to_app),
      ),
    );
  }
}
