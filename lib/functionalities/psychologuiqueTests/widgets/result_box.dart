// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:project_i_am_in_control/functionalities/psychologuiqueTests/screens/psychologuiqueTests.dart';

class ResultBox extends StatelessWidget {
  const ResultBox(
      {Key? key,
      required this.testTitle,
      required this.FinalScore,
      required this.TextScore,
      required this.onPressed})
      : super(key: key);

  final String? testTitle;
  final String FinalScore;
  final String TextScore;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      content: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 330,
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0, top: 8),
                          child: Center(
                            child: Text('O resultado do seu teste\nestá pronto!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0, top: 30),
                          child: Row(
                            children: [
                              Text('Título do Teste:',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 15,
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: Text('$testTitle',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0, top: 16),
                          child: Text('Resultado Final:',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0, top: 16),
                          child: Text('$TextScore',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, top: 30),
                      child: Row(
                        children: [
                          Flexible(
                            child: Text('$FinalScore',
                            textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 15,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        GestureDetector(
          onTap: onPressed,
          child: Center(
              child: Text('Recomeçar',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'antipastobold',
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ))),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Container(
             color: Colors.white,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return PsychologuiqueTestsScreen();
                    },
                  ),
                );
              },
              child: Container(
                color: Colors.white,
                child: Center(
                  child: Text('Sair',
                  textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.red,
                        fontFamily: 'antipastobold',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      )),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SmallerResultBox extends StatelessWidget {
  const SmallerResultBox(
      {Key? key,
      required this.testTitle,
      required this.FinalScore,
      required this.TextScore,
      required this.onPressed})
      : super(key: key);

  final String? testTitle;
  final String FinalScore;
  final String TextScore;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,      content: Container(
        height: 280,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, top: 8),
                    child: Center(
                      child: Text('O resultado do seu teste\nestá pronto!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0, top: 30),
                    child: Row(
                      children: [
                        Text('Título do Teste:',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 15,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text('$testTitle',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0, top: 16),
                    child: Text('Resultado Final:',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 15,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0, top: 16),
                    child: Text('$TextScore',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0, top: 30),
                child: Row(
                  children: [
                    Flexible(
                      child: Text('$FinalScore',
                      textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 15,
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        GestureDetector(
          onTap: onPressed,
          child: Center(
              child: Text('Recomeçar',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'antipastobold',
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ))),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Container(
             color: Colors.white,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return PsychologuiqueTestsScreen();
                    },
                  ),
                );
              },
              child: Container(
                color: Colors.white,
                child: Center(
                  child: Text('Sair',
                  textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.red,
                        fontFamily: 'antipastobold',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      )),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}