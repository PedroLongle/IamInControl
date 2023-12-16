import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget(
      {Key? key,
      required this.question,
      required this.indexAction,
      required this.totalQuestions})
      : super(key: key);

  final String question;
  final int indexAction;
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.8;
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30.0, bottom: 12),
              child: Text('Pergunta ${indexAction + 1}/$totalQuestions',
                  style: TextStyle(
                    fontSize: 20,
                  )),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Container(
                alignment: Alignment.centerLeft,
                width: c_width,
                child: Column(
                  children: [
                    Column(
                      children: <Widget>[
                        Text('$question', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
