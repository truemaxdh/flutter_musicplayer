import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import 'main.dart';

class SongWidget extends StatefulWidget {
  const SongWidget({Key? key}) : super(key: key);
    
  @override
  SongWidgetState createState() => SongWidgetState();
}

class SongWidgetState extends State<SongWidget> {
  late AutoScrollController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = AutoScrollController();
    songWidgetState = this;
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  void redraw() async {
    setState(() {});
    await _controller.scrollToIndex(
      curSongIdx, 
      //duration: const Duration(milliseconds: 500),
      preferPosition: AutoScrollPosition.begin
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: songList.length,
        controller: _controller,
        itemBuilder: (context, songIndex) {
          var song = songList.values.elementAt(songIndex);
          if (song['title'].length > 0) {
            return AutoScrollTag(
              key: ValueKey(songIndex),
              controller: _controller,
              index: songIndex,
              child: Card(
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
              ),
            );
          }

          return const SizedBox(
            height: 0,
          );
        });
  }
}
