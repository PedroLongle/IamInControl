import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AffirmationShowcase extends StatefulWidget {
  const AffirmationShowcase({
    Key? key,
  }) : super(key: key);

  @override
  State<AffirmationShowcase> createState() => _AffirmationShowcaseState();
}

class _AffirmationShowcaseState extends State<AffirmationShowcase> {
  List<String> stopAddictionsQuotes = [
    'Estou a fazer o melhor que posso!',
    'A cada dia fica mais fácil!',
    'Quero me libertar dos meus vícios!',
    'Sou mais forte que os meus vícios!',
    'Estou a descobrir novas coisas sobre mim!',
    'Compensa superar-me todos os dias!',
    'Vou superar esta fase!',
    'Não preciso disto na minha vida!',
    'Sou uma melhor versão de mim, sem este vício!'
  ];

  @override
  Widget build(BuildContext context) {
    String quoteValue = (stopAddictionsQuotes.toList()..shuffle()).first;
    return Row(
      children: [
        Container(
          color: Colors.white,
          width: 280,
          height: 80,
          child: Card(
              color: Colors.white,
              surfaceTintColor: Colors.white,
              shadowColor: Colors.black,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    quoteValue,
                    textAlign: TextAlign.center,
                  ),
                ),
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: GestureDetector(
            onTap: (() {
              setState(() {
                quoteValue = (stopAddictionsQuotes.toList()..shuffle()).first;
              });
            }),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                PhosphorIcons.arrowCounterClockwise,
                color: Colors.white,
                size: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
