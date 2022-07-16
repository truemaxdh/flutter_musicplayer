import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_music_player/main.dart';
import 'package:flutter_music_player/playerWidget.dart';
import 'package:webviewx/webviewx.dart';

late WebViewXController webviewController;

Widget youtubePlayerWidget(Size size) {
  var w = size.width;
  var h = (size.height - 72) / 2;
  var ytbH = min(h, w * 9 / 16);
  var html = "<html>\n";
  html += "  <body>\n";
  html +=
      "    <!-- 1. The <iframe> (and video player) will replace this <div> tag. -->\n";
  html += "    <div id='player'></div>\n";
  html += "    <script>\n";
  html +=
      "      // 2. This code loads the IFrame Player API code asynchronously.\n";
  html += "      var tag = document.createElement('script');\n";
  html += "      tag.src = 'https://www.youtube.com/iframe_api';\n";
  html +=
      "      var firstScriptTag = document.getElementsByTagName('script')[0];\n";
  html +=
      "      firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);\n";
  html +=
      "      // 3. This function creates an <iframe> (and YouTube player)\n";
  html += "      //    after the API code downloads.\n";
  html += "      var player;\n";
  html += "      function onYouTubeIframeAPIReady() {\n";
  html += "        player = new YT.Player('player', {\n";
  html += "          height: '$ytbH',\n";
  html += "          width: '$w',\n";
  html += "          videoId: '$videoId',\n";
  html += "          startSeconds: $sliderValue,\n";
  html += "          host: window.location.host, // window.location.href\n";
  html += "          events: {\n";
  html += "            'onReady': onPlayerReady,\n";
  html += "            'onStateChange': onPlayerStateChange\n";
  html += "          }\n";
  html += "        });\n";
  html += "      }\n";
  html +=
      "      // 4. The API will call this function when the video player is ready.\n";
  html += "      function onPlayerReady(event) {\n";
  html += "        setTimeout(displayStatus, 500);\n";
  html += "        event.target.playVideo();\n";
  html += "      }\n";
  html +=
      "      // 5. The API calls this function when the player's state changes.\n";
  html +=
      "      //    The function indicates that when playing a video (state=1),\n";
  html += "      //    the player should play for six seconds and then stop.\n";
  html += "      function onPlayerStateChange(event) {\n";
  html += "        console.log(event)\n";
  html += "        callBack(['state', event.data]);\n";
  html += "      }\n";
  html +=
      "      function loadVideoById(videoId, startSeconds, suggestedQuality) {";
  html +=
      "        player.loadVideoById(videoId, startSeconds, suggestedQuality);";
  html += "      }";
  html += "      function pauseVideo() {";
  html += "        player.pauseVideo();";
  html += "      }";
  html += "      function playVideo() {";
  html += "        player.playVideo();";
  html += "      }";
  html += "      function seekTo(seconds, allowSeekAhead) {";
  html += "        player.seekTo(seconds, allowSeekAhead);";
  html += "      }";
  html += "      function displayStatus() {";
  html += "        var time = player.getCurrentTime();";
  html += "        var duration = player.getDuration();";
  html += "        callBack(['playtime', time]);";
  html += "        callBack(['duration', duration]);";
  html += "        setTimeout(displayStatus, 500);\n";
  html += "      }";
  html += "    </script>\n";
  html += "  </body>\n";
  html += "</html>\n";
  if (iframeInitialized) {
    webviewController.callJsMethod("loadVideoById", [videoId, 0, 'default']);
  }
  return Expanded(
    child: WebViewX(
      initialContent: html,
      initialSourceType: SourceType.html,
      dartCallBacks: {
        DartCallback(
          name: 'callBack',
          callBack: (msg) {
            if (msg[0] == 'state') {
              if (msg[1] == 0) playNextSong(1);
              if (isPlaying != (msg[1] == 1)) {
                playerWidgetState.setState(() {
                  isPlaying = (msg[1] == 1);
                });
              }
            } else if (msg[0] == 'playtime') {
              playerWidgetState.setState(() {
                sliderValue = msg[1];
              });
            } else if (msg[0] == 'duration') {
              playerWidgetState.setState(() {
                duration = msg[1];
              });
            }
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
