import 'package:flutter/material.dart';
import 'package:flutter_music_player/main.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

Widget youtubePlayerWidget() {
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'K18cpp_-gP8',
    params: YoutubePlayerParams(
        playlist: ['nPt8bK2gbaU', 'gQDByCdjUXw'], // Defining custom playlist
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
