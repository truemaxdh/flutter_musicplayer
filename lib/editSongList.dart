import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_music_player/hiveBase.dart';

import 'main.dart';

class EditSongListWidget extends StatelessWidget {
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
                        height: 70,
                        width: 100,
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
                            onTap: () async {
                              await AlertDialog(
                                title: Text('Confirm'),
                                content: Text('Are you sure to delete this song??'),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () async {
                                        await box.delete(song['title']);
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Delete')),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Cancel')),
                                ],
                              );
                            },
                            child: IconText(
                              iconData: Icons.Delete,
                              //iconColor: Colors.red,
                              string: "Delete",
                              textColor: Colors.black,
                              iconSize: 30,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          else
            return SizedBox(
              height: 0,
            );
        }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.pop(context);
        },
        tooltip: 'Close',
        child: const Icon(Icons.text_fields),
      ),

    );
   }
}
