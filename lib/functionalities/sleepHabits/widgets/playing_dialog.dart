import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PlayingDialog extends StatefulWidget {
  const PlayingDialog({
    Key? key,
    required this.fileUrl,
    required this.fileName,
  }) : super(key: key);

  final String fileUrl;
  final String fileName;

  @override
  State<PlayingDialog> createState() => _PlayingDialogState();
}

class _PlayingDialogState extends State<PlayingDialog> {
  Widget build(BuildContext context) {
    AudioPlayer myAudioPlayer = AudioPlayer();
    late Source audioUrl;

    audioUrl = UrlSource(widget.fileUrl);

    myAudioPlayer.play(audioUrl);

    return AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Center(
                child: Text(
                  '${widget.fileName}',
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Row(
              children: [
                TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.white),
                  child: Icon(
                    PhosphorIcons.play,
                    color: Colors.black,
                    size: 14,
                  ),
                  onPressed: () {
                    myAudioPlayer.resume();
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.white),
                  child: Icon(
                    PhosphorIcons.pause,
                    color: Colors.red,
                    size: 14,
                  ),
                  onPressed: () {
                    myAudioPlayer.pause();
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.white),
                  child: Icon(
                    PhosphorIcons.stop,
                    color: Colors.red,
                    size: 14,
                  ),
                  onPressed: () {
                    myAudioPlayer.stop();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ]);
  }
}
