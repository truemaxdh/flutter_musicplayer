import 'package:flutter/material.dart';
import 'package:flutter_music_player/main.dart';
//import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:webviewx/webviewx.dart';

late WebViewXController webviewController;

Widget youtubePlayerWidget() {
  return Expanded(
    child : WebViewX(
        initialContent: "<iframe id='ytplayer' type='text'html' width='640' height='360' " +
                        "src='https://www.youtube.com/embed/M7lc1UVf-VE?autoplay=1&origin=https://truemaxdh.github.io/flutter_musicplayer/#/' " +
                        "frameborder='0'></iframe>",
        initialSourceType: SourceType.HTML,
        onWebViewCreated: (controller) => webviewController = controller,
    ),
  );  
}
