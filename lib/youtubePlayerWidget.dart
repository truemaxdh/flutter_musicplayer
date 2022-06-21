import 'package:flutter/material.dart';
import 'package:flutter_music_player/main.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

var _youtubeWidget = null;
Widget youtubePlayerWidget() {
  if (_youtubeWidget == null) {
    title = "New Youtube Widget";
    _youtubeWidget = Expanded(
      YoutubePlayerControllerProvider( // Provides controller to all the widget below it.
        controller: youtubePlayerController,
        child: YoutubePlayerIFrame(
          aspectRatio: 16 / 9,
        ),
      ),
    );
  }
  return _youtubeWidget;
}
