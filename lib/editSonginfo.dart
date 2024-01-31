import 'package:flutter/material.dart';
import 'package:flutter_music_player/main.dart';
import 'package:flutter_music_player/hiveBase.dart';

class EditSonginfoWidget extends StatelessWidget {
  final inputs = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  EditSonginfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add / Edit Song'),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                controller: inputs[0],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Title',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: inputs[1],
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Artist',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: inputs[2],
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'MP3 URL',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: inputs[3],
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Youtube URL or Video Id',
                ),
              ),
            ),
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var videoId = inputs[3]
              .text
              .replaceAll('https://youtu.be/', '')
              .replaceAll('https://www.youtube.com/watch?v=', '');
           videoId = videoId.substring(0, videoId.indexOf('?si='));
          await box.put(inputs[0].text, {
            'title': inputs[0].text,
            'artist': inputs[1].text,
            'albumArtwork': '',
            'mp3Url': inputs[2].text,
            'ytbVideoId': videoId
          });
          await initSonglist();
          Navigator.pop(context);
          songWidgetState.redraw();
        },
        tooltip: 'Save & Close',
        child: const Icon(Icons.text_fields),
      ),
    );
  }
}
