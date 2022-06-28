import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_music_player/main.dart';
import 'package:webviewx/webviewx.dart';

WebViewXController webviewController;

Widget youtubePlayerWidget(Size _size) {
  var w = _size.width;
  var h = (_size.height - 72) / 2;
  var ytb_h = min(h, w * 9 / 16);
  var html1 =
      "<iframe id='ytplayer' type='text'html' width='$w' height='$ytb_h' " +
          "src='https://www.youtube.com/embed/$videoId?autoplay=1&" +
          "origin=https://truemaxdh.github.io/flutter_musicplayer/#/' " +
          "frameborder='0'></iframe>";
  var html = 
      "<html>\n" +
      "  <body>\n" +
      "    <!-- 1. The <iframe> (and video player) will replace this <div> tag. -->\n" +
      "    <div id='player'></div>\n" +
      "\n" +
      "    <script>\n" +
      "      // 2. This code loads the IFrame Player API code asynchronously.\n" +
      "      var tag = document.createElement('script');\n" +
      "\n" +
      "      tag.src = 'https://www.youtube.com/iframe_api';\n" +
      "      var firstScriptTag = document.getElementsByTagName('script')[0];\n" +
      "      firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);\n" +
      "\n" +
      "      // 3. This function creates an <iframe> (and YouTube player)\n" +
      "      //    after the API code downloads.\n" +
      "      var player;\n" +
      "      function onYouTubeIframeAPIReady() {\n" +
      "        player = new YT.Player('player', {\n" +
      "          height: '$ytb_h',\n" +
      "          width: '$w',\n" +
      "          videoId: '$videoId',\n" +
      "          host: window.location.host, \n" +
      "          events: {\n" +
      "            'onReady': onPlayerReady,\n" +
      "            'onStateChange': onPlayerStateChange\n" +
      "          }\n" +
      "        });\n" +
      "      }\n" +
      "\n" +
      "      // 4. The API will call this function when the video player is ready.\n" +
      "      function onPlayerReady(event) {\n" +
      "        event.target.playVideo();\n" +
      "      }\n" +
      "\n" +
      "      // 5. The API calls this function when the player's state changes.\n" +
      "      //    The function indicates that when playing a video (state=1),\n" +
      "      //    the player should play for six seconds and then stop.\n" +
      "      function onPlayerStateChange(event) {\n" +
      "        console.log(event)\n" + 
      "        if (event.data == YT.PlayerState.ENDED) {\n" +
      "          //callBack('playEnded');\n" +
      "        }\n" +
      "      }\n" +
      "\n" +
      "    </script>\n" +
      "  </body>\n" +
      "</html>\n";
  var html2 = "<html><body>ASASAS<script>alert(1243);</script></body></html>";
  if (iframeInitialized) {
    webviewController
        .callJsMethod("player.loadVideoById", [videoId, 0, 'large']);
  }
  return Expanded(
    child: WebViewX(
      initialContent: html,
      initialSourceType: SourceType.html,
      dartCallBacks: {
        DartCallback(
          name: 'callBack',
          callBack: (msg) {
            if (msg == "playEnded") playNextSong(1);
          },
        )
      },
      onWebViewCreated: (controller) {
        webviewController = controller;
        iframeInitialized = true;
      },
      width: w,
      height: h,
    ),
  );
}
