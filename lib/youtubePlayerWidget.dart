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
                screenMode = (screenMode == "player") ? "mixed" : "player";
              });
            }),
      ),
    ),
  ]);
}
