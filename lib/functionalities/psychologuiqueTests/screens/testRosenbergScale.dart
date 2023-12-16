
// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:project_i_am_in_control/functionalities/psychologuiqueTests/screens/psychologuiqueTests.dart';

import '../models/question_model.dart';
import '../models/tests_db_connection.dart';
import '../widgets/option_card.dart';
import '../widgets/question_widget.dart';
import '../widgets/result_box.dart';

class testRosenbergScaleScreen extends StatefulWidget {
  String rosenbergtesttitle, rosenbergtesttitleABV, rosenbergtestdescription;
  testRosenbergScaleScreen(
      {super.key,
      required this.rosenbergtesttitle,
      required this.rosenbergtesttitleABV,
      required this.rosenbergtestdescription});

  @override
  State<testRosenbergScaleScreen> createState() => _testRosenbergScaleScreenState();
}

class _testRosenbergScaleScreenState extends State<testRosenbergScaleScreen> {
  // ignore: prefer_final_fields
  String pathPDF = "";

  @override
  void initState() {
    super.initState();
    fromAsset(
            'assets/documents/psychologiqueTests/IamInControl_Rosenberg_Self-esteem_Scale_PT.pdf',
            'IamInControl_Rosenberg_Self-esteem_Scale_PT.pdf')
        .then((f) {
      setState(() {
        pathPDF = f.path;
      });
    });
  }

  Future<File> fromAsset(String asset, String filename) async {
    Completer<File> completer = Completer();
    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  Widget build(BuildContext context) {
    widget.rosenbergtesttitle;
    double c_width = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: IconButton(
          icon: Padding(
            padding: const EdgeInsets.only(left: 30, top: 10),
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 35,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return PsychologuiqueTestsScreen();
              },
            ),
          );
          } 
        ),
        backgroundColor: Colors.grey[200],
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Container(
              width: 430.0,
              height: 678,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 40.0,
                          top: 40,
                        ),
                        child: Text(widget.rosenbergtesttitleABV,
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0, top: 5),
                        child: Text(widget.rosenbergtesttitle,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      width: c_width,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 2, right: 2),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(width: 2, color: Colors.white),
                                borderRadius: BorderRadius.circular(9),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text(widget.rosenbergtestdescription,
                                        style: TextStyle(
                                            fontFamily: 'lato',
                                            fontSize: 17,
                                            color: Colors.black)),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 100, right: 1),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (pathPDF.isNotEmpty) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PDFScreen(path: pathPDF),
                                            ),
                                          );
                                        }
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 235,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              '   Consultar Documentação ',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'antipastobold',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Icon(PhosphorIcons.filePdf,
                                                size: 25, color: Colors.black),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 80),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 55),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return testRosenbergScaleQuestions();
                        }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 30, left: 30, top: 13, bottom: 13),
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Center(
                            child: Text('Iniciar',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'antipastobold',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 21,
                                )),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PDFScreen extends StatefulWidget {
  final String? path;

  const PDFScreen({Key? key, this.path}) : super(key: key);

  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Documentação Rosenberg Scale"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.path,
            onRender: (_pages) {
              setState(() {
                pages = _pages;
                isReady = true;
              });
            },
            onError: (error) {
              setState(() {
                errorMessage = error.toString();
              });
              print(error.toString());
            },
            onPageError: (page, error) {
              setState(() {
                errorMessage = '$page: ${error.toString()}';
              });
              print('$page: ${error.toString()}');
            },
            onViewCreated: (PDFViewController pdfViewController) {
              _controller.complete(pdfViewController);
            },
          ),
          errorMessage.isEmpty
              ? !isReady
                  ? const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.black,
                        strokeWidth: 8,
                        color: Colors.green,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    )
                  : Container()
              : Center(
                  child: Text(errorMessage),
                )
        ],
      ),
    );
  }
}

class testRosenbergScaleQuestions extends StatefulWidget {
  const testRosenbergScaleQuestions({super.key});

  @override
  State<testRosenbergScaleQuestions> createState() =>
      _testRosenbergScaleQuestionsState();
}

class _testRosenbergScaleQuestionsState
    extends State<testRosenbergScaleQuestions> {
  late Future _questions;

  Future<List<Question>> getData() async {
    return getQuestionsRosernbergScale();
  }

  String? rosenbergtestTitleABV = "";
  String? rosenbergtestTitle = "";
  String? rosenbergtestDesc = "";
  String? rosenbergtestCategory = "";

  Future getTestData() async {
    await FirebaseFirestore.instance
        .collection(" psychologiqueTests")
        .doc("test_Rosenberg_Self-esteem_Scale")
        .get()
        .then(
      (snapshot) async {
        if (mounted) setState((){
        if (snapshot.exists) {
          setState(() {
            rosenbergtestTitleABV = snapshot.data()!["titleABV"];
            rosenbergtestTitle = snapshot.data()!["title"];
            rosenbergtestDesc = snapshot.data()!["description"];
            rosenbergtestCategory = snapshot.data()!["category"];
          });
        } else {}
        });
      },
    );
  }

  @override
  void initState() {
    _questions = getData();
    super.initState();
  }

  int index = 0;
  int score = 0;

  String FinalTextScore = '';
  String TextScore = '';

  void checkAnswerAndUpdateScore(int value, String valueString) {
    if (value == 0) {
      score = score + 0;
    } else if (value == 1) {
      score = score + 1;
    }
  }

  void nextQuestion(int questionsLength) {
    if (index == questionsLength - 1) {
      setResult(questionsLength);

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: ((context) => SmallerResultBox(
            testTitle: rosenbergtestTitleABV,
                FinalScore: FinalTextScore,
                TextScore: TextScore,
                onPressed: startOver,
              )));
    } else {
      index++;
    }
  }

  Future setResult(int questionsLength) async {
    if (score > 0) {
      
      FinalTextScore =
          "Quanto maior o resultado apresentado, maior revela ser a sua auto-estima!";
      TextScore = '$score / 30';
    }
  }

  void startOver() {
    setState(() {
      index = 0;
      score = 0;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    getTestData();
    return FutureBuilder(
      future: _questions as Future<List<Question>>,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            var extractedData = snapshot.data as List<Question>;
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: (() {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            surfaceTintColor: Colors.white,
                            backgroundColor: Colors.white,
                            content: Text(
                                "Tem a certeza que pretende sair do teste?\nO seu progresso será perdido."),
                            actions: <Widget>[
                              TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.white),
                                child: Text('Cancelar',
                                    style: TextStyle(color: Colors.black)),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.white),
                                child: Text('Sair',
                                    style: TextStyle(color: Colors.red)),
                                onPressed: () {
                                  startOver();
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              testRosenbergScaleScreen(
                                                rosenbergtesttitle:
                                                    rosenbergtestTitle!,
                                                rosenbergtesttitleABV:
                                                    rosenbergtestTitleABV!,
                                                rosenbergtestdescription:
                                                    rosenbergtestDesc!,
                                              )));
                                },
                              ),
                            ],
                          );
                        });
                  }),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Text(
                    rosenbergtestTitle!,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                backgroundColor: Colors.black,
                elevation: 0,
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    QuestionWidget(
                        question: extractedData[index].title,
                        indexAction: index,
                        totalQuestions: extractedData.length),
                    SizedBox(height: 30),
                    for (int i = 0;
                        i < extractedData[index].options.length;
                        i++)
                      GestureDetector(
                        onTap: () {
                          checkAnswerAndUpdateScore(
                            extractedData[index].options.values.toList()[i],
                            extractedData[index].options.keys.toList()[i],
                          );
                          nextQuestion(extractedData.length);
                        },
                        child: OptionCard(
                          option: extractedData[index].options.keys.toList()[i],
                        ),
                      ),
                  ],
                ),
              ),
            );
          }
        } else {
          return const Center(child: CircularProgressIndicator(
                        backgroundColor: Colors.black,
                        strokeWidth: 8,
                        color: Colors.green,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),);
        }

        return const Center(child: Text('No data'));
      },
    );
  }
}
