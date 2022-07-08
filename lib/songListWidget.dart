import 'package:flutter/material.dart';
import 'package:flutter_music_player/widget.dart';
import 'package:flutter_music_player/main.dart';
import 'package:flutter_music_player/songWidget.dart';

Expanded getSongListContainer() {
  return Expanded(
    flex: 1,
    child: SongWidget(),
  );
}
