import 'package:flutter/material.dart';
import 'package:flutter_music_player/main.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

Widget youtubePlayerWidget() {
  youtubePlayerController = YoutubePlayerController(
    initialVideoId: 'Il-an3K9pjg',
    params: YoutubePlayerParams(
      playlist: ['Il-an3K9pjg'], // Defining custom playlist
      //startAt: Duration(seconds: 30),
      showControls: true,
      showFullscreenButton: true,
    ),
  );
  return Column(children: <Widget>[
    YoutubePlayerIFrame(
      controller: youtubePlayerController,
      aspectRatio: 16 / 9,
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.start, 
      children: <Widget>[
        Image(
          height: 72,
          width: 120,
          fit: BoxFit.cover,
          image: NetworkImage(
              "https://avatars.githubusercontent.com/u/12081386?s=120&v=4")),
        Expanded(
          child: Container(
            height: 72,
            //width: 620,
            padding: EdgeInsets.symmetric(horizontal: 3),
            child: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Slider(),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5),
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
                            onPressed: () {
                              playNextSong(-1);
                            }),
                      ),
                      backgroundColor: Colors.cyan.withOpacity(0.3),
                    ),
                    CircleAvatar(
                      radius: 23,
                      child: Center(
                        child: IconButton(
                          onPressed: () async {
                            isPlaying ? youtubePlayerController.pause() : youtubePlayerController.resume();
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
                            onPressed: () {
                              playNextSong(1);
                            }),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.cyan.withOpacity(0.3),
                      child: Center(
                        child: IconButton(
                            icon: Icon(
                              (screenMode == "player")
                                  ? Icons.expand_more
                                  : Icons.expand_less, //icons.expand_more,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              myAppState.setState(() {
                                screenMode =
                                    (screenMode == "player") ? "mixed" : "player";
                              });
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ]),
  ]);
}
