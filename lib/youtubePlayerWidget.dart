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
  var html = "<!DOCTYPE html>" +
      "<html>" +
      "  <body>" +
      "    <!-- 1. The <iframe> (and video player) will replace this <div> tag. -->" +
      "    <div id='player'></div>" +
      "" +
      "    <script>" +
      "      // 2. This code loads the IFrame Player API code asynchronously." +
      "      var tag = document.createElement('script');" +
      "" +
      "      tag.src = 'https://www.youtube.com/iframe_api';" +
      "      var firstScriptTag = document.getElementsByTagName('script')[0];" +
      "      firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);" +
      "" +
      "      // 3. This function creates an <iframe> (and YouTube player)" +
      "      //    after the API code downloads." +
      "      var player;" +
      "      function onYouTubeIframeAPIReady() {" +
      "        player = new YT.Player('player', {" +
      "          height: '$ytb_h'," +
      "          width: '$w'," +
      "          videoId: '$videoId'," +
      "          events: {" +
      "            'onReady': onPlayerReady," +
      "            'onStateChange': onPlayerStateChange" +
      "          }" +
      "        });" +
      "      }" +
      "" +
      "      // 4. The API will call this function when the video player is ready." +
      "      function onPlayerReady(event) {" +
      "        event.target.playVideo();" +
      "      }" +
      "" +
      "      // 5. The API calls this function when the player's state changes." +
      "      //    The function indicates that when playing a video (state=1)," +
      "      //    the player should play for six seconds and then stop." +
      "      function onPlayerStateChange(event) {" +
      "        if (event.data == YT.PlayerState.ENDED) {" +
      "          callBack('playEnded');" +
      "        }" +
      "      }" +
      "" +
      "    </script>" +
      "  </body>" +
      "</html>";

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
