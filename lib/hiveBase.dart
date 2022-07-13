import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_music_player/main.dart';

// Open your boxes. Optional: Give it a type.
CollectionBox box;
Future<void> putDBTestData() async {
  // Create a box collection
  final collection = await BoxCollection.open(
    'MySongs', // Name of your database
    {'SongList1', 'SongList2'}, // Names of your boxes
    path:
        './', // Path where to store your boxes (Only used in Flutter / Dart IO)
    key: HiveAesCipher([
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      18,
      19,
      20,
      21,
      22,
      23,
      24,
      25,
      26,
      27,
      28,
      29,
      30,
      31,
      32
    ]), // Key to encrypt your boxes (Only used in Flutter / Dart IO)
  );

  box = await collection.openBox<Map>('SongList1');

  // Put something in
  await box.put('2002', {
    'title': '2002',
    'artist': 'Anne Marie',
    'albumArtwork':
        'https://avatars.githubusercontent.com/u/12081386?s=120&v=4',
    'mp3Url': '',
    'ytbVideoId': 'Il-an3K9pjg'
  });
  await box.put('Space Trip', {
    'title': 'Space Trip',
    'artist': 'Danny Choi',
    'albumArtwork':
        'https://avatars.githubusercontent.com/u/12081386?s=120&v=4',
    'mp3Url':
        'https://truemaxdh.github.io/MusicTreasureHouse/SpaceTrip/SpaceTrip.mp3',
    'ytbVideoId': ''
  });
  await box.put('어땠을까', {
    'title': '어땠을까',
    'artist': '싸이 & 박정현',
    'albumArtwork': 'https://music.bugs.co.kr/track/2708278',
    'mp3Url': '',
    'ytbVideoId': 'iT267zwmFBw'
  });

  songList = await box.getAllValues();
}
