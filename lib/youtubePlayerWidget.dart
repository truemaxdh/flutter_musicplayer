import 'package:flutter/material.dart';
import 'package:flutter_music_player/main.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

Widget youtubePlayerWidget() {
  return Expanded(
    child : YoutubePlayerIFrame(
      controller: youtubePlayerController,
      aspectRatio: 16 / 9,
    ),
  );  
}
