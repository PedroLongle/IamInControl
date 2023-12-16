import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:project_i_am_in_control/functionalities/sleepHabits/screens/sleepHabits.dart';
import 'package:project_i_am_in_control/functionalities/sleepHabits/widgets/playing_dialog.dart';

import '../widgets/downloading_dialog.dart';

class SleepSoundsScreen extends StatefulWidget {
  const SleepSoundsScreen({super.key});

  @override
  State<SleepSoundsScreen> createState() => _SleepSoundsScreenState();
}

class _SleepSoundsScreenState extends State<SleepSoundsScreen> {
  late Future<ListResult> futureFiles;
  late String fileLink = '';

  Future downloadFile(Reference ref, String fileName) async {
    final url = await ref.getDownloadURL();

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((context) => DownloadigDialog(
              fileUrl: url,
              fileName: fileName,
            )));
  }

  Future playFile(Reference ref, String fileName) async {
    final url = await ref.getDownloadURL();

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((context) => PlayingDialog(
              fileUrl: url,
              fileName: fileName,
            )));
  }

  @override
  void initState() {
    super.initState();
    futureFiles = FirebaseStorage.instance.ref('/sleepSounds').listAll();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SleepHabitsScreen();
                  },
                ),
              );
            }),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 40),
            child: Text(
              '',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 35.0, left: 25),
                      child: Text(
                        'Áudios Disponíveis',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 19),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: SizedBox(
                    height: 600,
                    child: FutureBuilder<ListResult>(
                        future: futureFiles,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final files = snapshot.data!.items;
                            print(files);

                            return ListView.builder(
                                itemCount: files.length,
                                itemBuilder: ((context, index) {
                                  final file = files[index];

                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 13.0, left: 25, right: 25),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.grey[200],
                                      ),
                                      child: ListTile(
                                        title: Text(
                                          file.name,
                                          style: TextStyle(fontSize: 13),
                                        ),
                                        trailing: Wrap(
                                          spacing: 20,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                playFile(file, file.name);
                                              },
                                              child: Icon(
                                                PhosphorIcons.playBold,
                                                color: Colors.black,
                                                size: 18,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                downloadFile(file, file.name);
                                              },
                                              child: Icon(
                                                PhosphorIcons.downloadBold,
                                                color: Colors.black,
                                                size: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }));
                          } else if (snapshot.hasError) {
                            return const Text('Erro');
                          } else {
                            return Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.black,
                                  strokeWidth: 8,
                                  color: Colors.green,
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white),
                                ),
                              ),
                            );
                          }
                        }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
