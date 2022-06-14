import 'package:flutter/material.dart';
import 'package:flutter_music_player/main.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

Widget youtubePlayerWidget() {
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'Il-an3K9pjg',
    params: YoutubePlayerParams(
      playlist: ['Il-an3K9pjg'], // Defining custom playlist
      startAt: Duration(seconds: 30),
      showControls: true,
      showFullscreenButton: true,
    ),
  );
  return YoutubePlayerIFrame(
    controller: _controller,
    aspectRatio: 16 / 9,
  );
}
