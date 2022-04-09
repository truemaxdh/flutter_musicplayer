import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class IconText extends StatelessWidget {
  final IconData iconData;
  final String string;
  final Color iconColor;
  final Color textColor;
  final double iconSize;

  IconText({
    @required this.textColor,
    @required this.iconColor,
    @required this.string,
    @required this.iconSize,
    @required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Icon(
          iconData,
          size: iconSize,
          color: iconColor,
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          string,
          style: TextStyle(
              color: Colors.red, fontSize: 10, fontWeight: FontWeight.w900),
        ),
      ],
    );
  }
}

class SongInfo2 {
  Map<dynamic, dynamic> _data = new Map();
  SongInfo2(SongInfo songInfo) {
    _data['album_id'] = songInfo.albumId;
    _data['artist_id'] = songInfo.artistId;
    _data['artist'] = songInfo.artist;
    _data['album'] = songInfo.album;
    _data['title'] = songInfo.title;
    _data['_display_name'] = songInfo.displayName;
    _data['composer'] = songInfo.composer;
    _data['year'] = songInfo.year;
    _data['track'] = songInfo.track;
    _data['duration'] = songInfo.duration;
    _data['bookmark'] = songInfo.bookmark;
    _data['_data'] = songInfo.filePath;
    _data['_size'] = songInfo.fileSize;
    _data['album_artwork'] = songInfo.albumArtwork;
    _data['is_music'] = songInfo.isMusic;
    _data['is_podcast'] = songInfo.isPodcast;
    _data['is_ringtone'] = songInfo.isRingtone;
    _data['is_alarm'] = songInfo.isAlarm;
    _data['is_notification'] = songInfo.isNotification;
  }
  SongInfo2.fromURL(String url) {
    _data['album_id'] = "1234.mp3"; //albumId;
    _data['artist_id'] = "1234.mp3"; //artistId;
    _data['artist'] = "1234.mp3"; //artist;
    _data['album'] = "1234.mp3"; //album;
    _data['title'] = "1234.mp3"; //title;
    _data['_display_name'] = "1234.mp3"; //displayName;
    _data['composer'] = "1234.mp3"; //composer;
    _data['year'] = "1234.mp3"; //year;
    _data['track'] = "1234.mp3"; //track;
    _data['duration'] = "123"; //duration;
    _data['bookmark'] = "1234.mp3"; //bookmark;
    _data['_data'] = url; //filePath;
    _data['_size'] = "1234.mp3"; //fileSize;
    _data['album_artwork'] =
        "https://avatars.githubusercontent.com/u/12081386?s=120&v=4"; //albumArtwork;
    _data['is_music'] = "1234.mp3"; //isMusic;
    _data['is_podcast'] = "1234.mp3"; //isPodcast;
    _data['is_ringtone'] = "1234.mp3"; //isRingtone;
    _data['is_alarm'] = "1234.mp3"; //isAlarm;
    _data['is_notification'] = "1234.mp3"; //isNotification;
  }

  /// Returns the album id which this song appears.
  String get albumId => _data['album_id'];

  /// Returns the artist id who create this audio file.
  String get artistId => _data['artist_id'];

  /// Returns the artist name who create this audio file.
  String get artist => _data['artist'];

  /// Returns the album title which this song appears.
  String get album => _data['album'];

  // Returns the genre name which this song belongs.
  //String get genre => _data['genre_name'];

  /// Returns the song title.
  String get title => _data['title'];

  /// Returns the song display name. Display name string
  /// is a combination of [Track number] + [Song title] [File extension]
  /// Something like 1 My pretty song.mp3
  String get displayName => _data['_display_name'];

  /// Returns the composer name of this song.
  String get composer => _data['composer'];

  /// Returns the year of this song was created.
  String get year => _data['year'];

  /// Returns the album track number if this song has one.
  String get track => _data['track'];

  /// Returns a String with a number in milliseconds (ms) that is the duration of this audio file.
  String get duration => _data['duration'];

  /// Returns in ms, playback position when this song was stopped.
  /// from the last time.
  String get bookmark => _data['bookmark'];

  /// Returns a String with a file path to audio data file
  String get filePath => _data['_data'];

  /// Returns a String with the size, in bytes, of this audio file.
  String get fileSize => _data['_size'];

  ///Returns album artwork path which current song appears.
  String get albumArtwork => _data['album_artwork'];

  bool get isMusic => _data['is_music'];

  bool get isPodcast => _data['is_podcast'];

  bool get isRingtone => _data['is_ringtone'];

  bool get isAlarm => _data['is_alarm'];

  bool get isNotification => _data['is_notification'];
}
