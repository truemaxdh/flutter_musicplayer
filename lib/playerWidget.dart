import 'package:flutter/material.dart';
import 'package:flutter_music_player/main.dart';
import 'package:flutter_music_player/youtubePlayerWidget.dart';

_PlayerWidget playerWidgetState;

class PlayerWidget extends StatefulWidget {
  @override
  _PlayerWidget createState() => _PlayerWidget();
}

class _PlayerWidget extends State<PlayerWidget> {
  @override
  void initState() {
    super.initState();
    playerWidgetState = this;
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Image(
            height: 72,
            width: 120,
            fit: BoxFit.cover,
            image: getIcon(curSong),          
        ),
        Expanded(
          child: Container(
            height: 72,
            padding: EdgeInsets.symmetric(horizontal: 3),
            child: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: songProgress(context),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5),
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
                      radius: 23,
                      child: Center(
                        child: IconButton(
                          onPressed: () async {
                            if (curSong['ytbVideoId'].length > 0) {
                              webviewController.callJsMethod(
                                  (isPlaying
                                      ? "pauseVideo"
                                      : "playVideo"),
                                  []);
                            } else {
                              isPlaying
                                  ? audioPlayer.pause()
                                  : audioPlayer.resume();
                            }
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
                      backgroundColor: Colors.cyan.withOpacity(0.3),
                      child: Center(
                        child: IconButton(
                            icon: Icon(
                              (screenMode == "player")
                                  ? Icons.expand_more
                                  : Icons.expand_less, //icons.expand_more,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              myAppState.setState(() {
                                screenMode =
                                    (screenMode == "player") ? "mixed" : "player";
                              });
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ]),
    );
  }
  
  String _formatDuration(Duration d) {
    if (d == null) return "--:--";
    int minute = d.inMinutes;
    int second = d.inSeconds % 60;
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
                    if (curSong['ytbVideoId'].length > 0) {
                      webviewController.callJsMethod("seekTo", [value, true]);
                    } else {
                      audioPlayer.seek(Duration(seconds: value.toInt()));
                    }
                  },
                  onChanged: (value) {
                    if (curSong['ytbVideoId'].length > 0) {
                      webviewController.callJsMethod("seekTo", [value, false]);
                      setState(() {sliderValue = value.toInt();});
                    }
                  },
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
}
