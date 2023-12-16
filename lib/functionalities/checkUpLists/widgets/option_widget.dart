import 'package:flutter/material.dart';

class OptionWidget extends StatelessWidget {
  const OptionWidget(
      {Key? key,
      required this.option,
      required this.indexAction,
      required this.totalOptions})
      : super(key: key);

  final String option;
  final int indexAction;
  final int totalOptions;

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.8;
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30.0, bottom: 12),
              child: Text('Pergunta ${indexAction + 1}/$totalOptions',
                  style: TextStyle(
                    fontSize: 20,
                  )),
            ),
          ],
        ),
        SizedBox(height: 20),
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
                        Text('$option', style: TextStyle(fontSize: 18)),
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
