import 'dart:math';

import 'package:flutter/material.dart';
//import 'package:flutter_music_player/main.dart';
//import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:webviewx/webviewx.dart';

WebViewXController webviewController;

Widget youtubePlayerWidget(Size _size) {
  return Expanded(
    child: WebViewX(
      initialContent:
          "<iframe id='ytplayer' type='text'html' width='640' height='360' " +
              "src='https://www.youtube.com/embed/M7lc1UVf-VE?autoplay=1&origin=https://truemaxdh.github.io/flutter_musicplayer/#/' " +
              "frameborder='0'></iframe>",
      initialSourceType: SourceType.html,
      onWebViewCreated: (controller) => webviewController = controller,
      width: _size.width,
      height: min(_size.height, _size.width * 3 / 4),
    ),
  );
}
