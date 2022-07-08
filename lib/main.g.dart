import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

part of 'main.dart';

var title = "Music Player";
var duration = 10;
bool showVol = false;
bool isPlaying = false;
double _volume = 1;
var sliderValue = 0;
var screenMode = 'list'; // 'mixed', 'player', 'list'
var videoId = "";
var iframeInitialized = false;

MyAppState myAppState;
AudioPlayer audioPlayer = AudioPlayer();

//List<SongInfo2> songList = new List.empty(growable: true);
Map songList;
Map curSong;

var curSongIdx = -1;
var playNextSong = (idxIncrease) {
  curSongIdx += idxIncrease;
  if (curSongIdx < 0) {
    curSongIdx += songList.length;
  } else if (curSongIdx >= songList.length) {
    curSongIdx -= songList.length;
  }

  sliderValue = 0;
  duration = 0;
  isPlaying = false;

  curSong = songList.values.elementAt(curSongIdx);
  if (curSong['mp3Url'].length > 0) {
    if (curSong['mp3Url'].startsWith('http:') ||
        curSong['mp3Url'].startsWith('https:')) {
      audioPlayer.play(UrlSource(curSong['mp3Url']));
    } else {
      audioPlayer.play(DeviceFileSource(curSong['mp3Url']));
    }

    iframeInitialized = false;
  } else if (curSong['ytbVideoId'].length > 0) {
    audioPlayer.stop();
    videoId = curSong['ytbVideoId'];

    myAppState.setState(() {
      if (screenMode == "list") screenMode = "mixed";
    });
  }
};

var getIcon = (song) {
  if (song['mp3Url'].length > 0)
    return FileImage(File('images/mp3.png'));
  else if (song['ytbVideoId'].length > 0)
    return FileImage(File('images/mp3.png'));
  else
    return NetworkImage(
      "https://avatars.githubusercontent.com/u/12081386?s=120&v=4");
};
