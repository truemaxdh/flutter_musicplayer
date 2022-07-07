import 'dart:io';

import 'package:hive/hive.dart';

// Create a box collection
final collection = await BoxCollection.open(
  'MySongs', // Name of your database
  {'SongList1', 'SongList2'}, // Names of your boxes
  path: './', // Path where to store your boxes (Only used in Flutter / Dart IO)
  key: HiveCipher(), // Key to encrypt your boxes (Only used in Flutter / Dart IO)
);


// Open your boxes. Optional: Give it a type.
final songList1 = collection.openBox<Map>('songList1');

async PutDBTestData() {
  // Put something in
  await songList1.put(
    '2002', 
    {
      'title': '2002', 
      'artist': 'Anne Marie', 
      'album_artwork': 'https://avatars.githubusercontent.com/u/12081386?s=120&v=4',
      'mp3_url': '',
      'ytb_video_id': 'Il-an3K9pjg'});
  await songList1.put(
    'Space Trip', 
    {
      'title': 'Space Trip',
      'artist': 'Danny Choi',
      'album_artwork': 'https://avatars.githubusercontent.com/u/12081386?s=120&v=4',
      'mp3_url': 'https://truemaxdh.github.io/MusicTreasureHouse/SpaceTrip/SpaceTrip.mp3',
      'ytb_video_id': ''});
}