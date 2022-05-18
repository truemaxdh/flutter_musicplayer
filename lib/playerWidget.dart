import 'package:flutter/material.dart';
import 'package:flutter_music_player/main.dart';

Widget playerWidget(BuildContext context, _MyAppState _myAppState) {
  print(_myAppState);
  return Column(children: <Widget>[
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: songProgress(context),
    ),
    Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          CircleAvatar(
            child: Center(
              child: IconButton(
                  icon: Icon(
                    Icons.skip_previous,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    playNextSong(-1);
                  }),
            ),
            backgroundColor: Colors.cyan.withOpacity(0.3),
          ),
          CircleAvatar(
            radius: 30,
            child: Center(
              child: IconButton(
                onPressed: () async {
                  isPlaying ? audioPlayer.pause() : audioPlayer.resume();
                },
                padding: const EdgeInsets.all(0.0),
                icon: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.cyan.withOpacity(0.3),
            child: Center(
              child: IconButton(
                  icon: Icon(
                    Icons.skip_next,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    playNextSong(1);
                  }),
            ),
          ),
          CircleAvatar(
            child: Center(
              child: IconButton(
                  icon: Icon(
                  	 Icons.expand_less,  //icons.expand_more,
                  	 color: Colors.white,
                  ),
                  onPressed: () {
                 
                  }),
          	),
          ),
        ],
      ),
    ),
  ]);
}

String _formatDuration(Duration d) {
  if (d == null) return "--:--";
  int minute = d.inMinutes;
  int second = (d.inSeconds > 60) ? (d.inSeconds % 60) : d.inSeconds;
  String format = ((minute < 10) ? "0$minute" : "$minute") +
      ":" +
      ((second < 10) ? "0$second" : "$second");
  return format;
}

Widget songProgress(BuildContext context) {
  var style = TextStyle(color: Colors.black);
  return Row(
    children: <Widget>[
      Text(
        _formatDuration(Duration(seconds: sliderValue)),
        style: style,
      ),
      Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 2,
                thumbColor: Colors.blueAccent,
                overlayColor: Colors.blue,
                thumbShape: RoundSliderThumbShape(
                  disabledThumbRadius: 5,
                  enabledThumbRadius: 5,
                ),
                overlayShape: RoundSliderOverlayShape(
                  overlayRadius: 10,
                ),
                activeTrackColor: Colors.blueAccent,
                inactiveTrackColor: Colors.grey,
              ),
              child: Slider(
                min: 0,
                max: duration.toDouble(),
                value: sliderValue.toDouble(),
                onChangeEnd: (value) {
                  audioPlayer.seek(Duration(seconds: value.toInt()));
                },
                onChanged: (double value) {},
              )),
        ),
      ),
      Text(
        _formatDuration(Duration(seconds: duration)),
        style: style,
      ),
    ],
  );
}
