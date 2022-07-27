import 'package:flutter/material.dart';

import 'main.dart';

late SongWidgetState songWidgetState;

class SongWidget extends StatefulWidget {
  const SongWidget({Key? key}) : super(key: key);
    
  @override
  SongWidgetState createState() => SongWidgetState();
}

class SongWidgetState extends State<SongWidget> {
  @override
  void initState() {
    super.initState();
    
    songWidgetState = this;
  }
  
  void redraw() {
    setState(() {});
  }
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image(
                        height: 70,
                        width: 100,
                        fit: BoxFit.cover,
                        image: getIcon(song),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
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
                            onTap: () {
                              curSongIdx = songIndex;
                              screenMode = "mixed";
                              playNextSong(0);
                            },
                            child: const Icon(
                              Icons.play_circle_outline,
                              size: 50,
                              //iconColor: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return const SizedBox(
            height: 0,
          );
        });
  }
}
