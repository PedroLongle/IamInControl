import 'package:flutter/material.dart';

class myAffirmationsShowcase extends StatelessWidget {
  final List<String> texts = [
    'Text 1',
    'Text 2',
    'Text 3',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10.0),
          child: Container(
            color: Colors.white,
            height: 150,
            child: Card(
                color: Colors.white,
                surfaceTintColor: Colors.white,
                shadowColor: Colors.black,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  height: 200.0,
                  child: PageView.builder(
                    itemCount: texts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                        child: Text(
                          texts[index],
                          style: TextStyle(fontSize: 17.0),
                        ),
                      );
                    },
                  ),
                )),
          ),
        ),
      ]),
    );
  }
}
