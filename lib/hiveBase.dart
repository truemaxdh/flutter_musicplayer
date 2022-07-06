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

// Put something in
await catsBox.put('2002', {'name': '2002', 'videoID': '1234'});
await catsBox.put('Arcane', {'name': 'Arcane', 'videoID': '1234'});

