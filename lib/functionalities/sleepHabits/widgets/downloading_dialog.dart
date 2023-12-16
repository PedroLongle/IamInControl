import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DownloadigDialog extends StatefulWidget {
  const DownloadigDialog({
    Key? key,
    required this.fileUrl,
    required this.fileName,
  }) : super(key: key);

  final String fileUrl;
  final String fileName;

  @override
  State<DownloadigDialog> createState() => _DownloadigDialogState();
}

class _DownloadigDialogState extends State<DownloadigDialog> {
  Dio dio = Dio();
  double progress = 0.0;

  void startDownloading() async {
    final url = widget.fileUrl;
    String filename = widget.fileName;

    String path = await _getFilePath(filename);

    await dio.download(
      url,
      path,
      onReceiveProgress: (receivedBytes, totalBytes) {
        setState(() {
          progress = receivedBytes / totalBytes;
        });

        print(progress);
      },
      deleteOnError: true,
    ).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Downloaded ${filename}'),
        duration: Duration(milliseconds: 2000),
      ));
      Navigator.pop(context);
    });
  }

  Future<String> _getFilePath(String filename) async {
    final dir = Directory('/storage/emulated/0/Download');
    ;
    return "${dir.path}/$filename";
  }

  @override
  void initState() {
    super.initState();
    startDownloading();
  }

  Widget build(BuildContext context) {
    String downloadingprogress = (progress * 100).toInt().toString();
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator.adaptive(
              backgroundColor: Colors.black,
              strokeWidth: 8,
              valueColor: AlwaysStoppedAnimation(Colors.white)),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Downloading: $downloadingprogress%',
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
