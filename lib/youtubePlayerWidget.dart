import 'package:flutter/material.dart';
import 'package:flutter_music_player/main.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

Widget youtubePlayerWidget(BuildContext context, MyAppState _myAppState) {
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'iLnmTe5Q2Qw',
    flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
    ),
  );
  return YoutubePlayer(
    controller: _controller,
    showVideoProgressIndicator: true,
    videoProgressIndicatorColor: Colors.amber,
    progressColors: ProgressColors(
        playedColor: Colors.amber,
        handleColor: Colors.amberAccent,
    ),
    onReady () {
        _controller.addListener(listener);
    },
  );
}
