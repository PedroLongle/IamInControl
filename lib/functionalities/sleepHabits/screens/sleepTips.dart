import 'package:card_slider/card_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class sleepTipsScreen extends StatefulWidget {
  const sleepTipsScreen({super.key});

  @override
  State<sleepTipsScreen> createState() => _sleepTipsScreenState();
}

class _sleepTipsScreenState extends State<sleepTipsScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    List<Color> valuesDataColors = [
      Colors.white,
      Colors.grey,
      Colors.white,
      Colors.grey,
      Colors.white,
      Colors.grey,
    ];

    List<String> sleepTips = [
      'Provavelmente, acorda todas as manhãs à mesma hora, seja por causa do trabalho ou porque tem de despachar os filhos para a escola. Por isso, não será muito difícil criar o hábito de ter também uma hora fixa para se deitar todos os dias, incluindo fins de semana! O nosso corpo precisa de uma rotina.',
      'A prática regular de exercício físico provoca a libertação de neurotransmissores que favorecem a sensação de bem-estar, atenuando o stress e a ansiedade. No entanto, evite fazer exercício físico a partir do final da tarde ou terá, provavelmente, dificuldade em adormecer.',
      'As sestas são de evitar, especialmente para quem sofre de insónias. Se não conseguir resistir a uma sesta, tente que seja curta - não mais do que 30 minutos e de preferência logo após o almoço, para que não interfira com o sono da noite.',
      'Organize a sua semana, defina prioridades e delegue tarefas sempre que possível. Reserve algum tempo para fazer algo que lhe dê prazer, seja relaxante e o faça esquecer as preocupações. Estas refletem-se na qualidade/ quantidade do sono.',
      'A cafeína é uma substância estimulante e, como tal, inibe o sono. Por isso, evite o café e as bebidas com cafeína (como refrigerantes ou chá preto) a partir da tarde.',
      'O jantar deve ser ligeiro, pois as refeições pesadas tornam mais difícil adormecer e resultam num sono mais agitado e superficial. Se estiver com fome perto da hora de se ir deitar, opte por algo leve. O consumo de bebidas alcoólicas deve ser evitado nas duas horas que precedem a altura de ir dormir.',
    ];

    List<Widget> valuesWidget = [];
    for (int i = 0; i < valuesDataColors.length; i++) {
      valuesWidget.add(
        Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: valuesDataColors[i],
            ),
            
            child: Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, left: 20),
                        child: Text(
                          'Dica ',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 1, top: 15),
                        child: Text(
                          '${i+1}/${valuesDataColors.length}',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, top: 20, right: 15),
                    child: Row(children: [
                      Flexible(
                        child: Text(
                          sleepTips[i],
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            )),
      ));
    }
    return AlertDialog(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Container(
          width: 320,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: CardSlider(
                  cards: valuesWidget,
                  bottomOffset: .0005,
                  cardHeight: 1,
                  itemDotOffset: 0.55,
                  itemDotWidth: 20,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
