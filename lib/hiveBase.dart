import 'dart:io';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_music_player/main.dart';

/*
// Create a box collection
final collection = BoxCollection.open(
  'MySongs', // Name of your database
  {'SongList1', 'SongList2'}, // Names of your boxes
  path: './', // Path where to store your boxes (Only used in Flutter / Dart IO)
  key: HiveCipher(), // Key to encrypt your boxes (Only used in Flutter / Dart IO)
);
*/

// Open your boxes. Optional: Give it a type.
//final songList1 = collection.openBox<Map>('songList1');

void putDBTestData() {
  print(1);  
  songList1 = Hive.box('songList1');
  print(songList1);
  
  print(2);  
  songList1.put('1', '1');
  print(songList1.get('1'));
  
  // Put something in
  print(3);  
  songList1.put(
    '2002', 
    ['2002', 'Anne Marie', 'https://avatars.githubusercontent.com/u/12081386?s=120&v=4',
     '', 'Il-an3K9pjg']);
  print(songList1);
  
  
  print(4);  
  songList1.put(
    'Space Trip', 
    ['Space Trip', 'Danny Choi', 'https://avatars.githubusercontent.com/u/12081386?s=120&v=4',
     'https://truemaxdh.github.io/MusicTreasureHouse/SpaceTrip/SpaceTrip.mp3', '']);
  print(songList1);
  
}
