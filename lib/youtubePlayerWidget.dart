import 'package:flutter/material.dart';
import 'package:flutter_music_player/main.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

Widget youtubePlayerWidget() {
  return Expanded(
    child : YoutubePlayerControllerProvider( // Provides controller to all the widget below it.
      controller: youtubePlayerController,
      child: YoutubePlayerIFrame(
        aspectRatio: 16 / 9,
      ),
    ),
  );  
}
