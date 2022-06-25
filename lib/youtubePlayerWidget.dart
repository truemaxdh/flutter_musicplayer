import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_music_player/main.dart';
//import 'package:flutter_music_player/main.dart';
//import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:webviewx/webviewx.dart';

WebViewXController webviewController;

Widget youtubePlayerWidget(Size _size) {
  var w = _size.width;
  var h = (_size.height - 72) / 2;
  var ytb_h = min(h, w * 9 / 16);
  var html =
      "<iframe id='ytplayer' type='text'html' width='$w' height='$ytb_h' " +
          "src='https://www.youtube.com/embed/$videoId?autoplay=1&" +
          "origin=https://truemaxdh.github.io/flutter_musicplayer/#/' " +
          "frameborder='0'></iframe>";
  return Expanded(
    child: WebViewX(
      initialContent: html,
      initialSourceType: SourceType.html,
      onWebViewCreated: (controller) => webviewController = controller,
      width: w,
      height: h,
    ),
  );
}
