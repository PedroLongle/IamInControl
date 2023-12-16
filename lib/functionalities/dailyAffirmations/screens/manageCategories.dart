import 'package:flutter/material.dart';
import 'package:image_card/image_card.dart';
import 'package:project_i_am_in_control/functionalities/sleepHabits/screens/sleepHabits.dart';

class setCategoriesScreen extends StatefulWidget {
  const setCategoriesScreen({super.key});

  @override
  State<setCategoriesScreen> createState() => _setCategoriesScreenState();
}

class _setCategoriesScreenState extends State<setCategoriesScreen> {
  @override
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
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Row(children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0, left: 25),
                          child: Text(
                            'Selecionar Categorias',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 19),
                          ),
                        ),
                      ],
                    ),
                  ]),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 45.0, left: 25),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: InkWell(
                                      onTap: () {},
                                      child: TransparentImageCard(
                                        width: 130,
                                        height: 145,
                                        imageProvider: AssetImage(
                                            'assets/images/affirmationsCategories/geral.png'),
                                        title: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 0, left: 0, right: 0),
                                          child: Row(
                                            children: [
                                              Text("Geral",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 12)),
                                                      

                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: InkWell(
                                      onTap: () {},
                                      child: TransparentImageCard(
                                        width: 130,
                                        height: 145,
                                        imageProvider: AssetImage(
                                            'assets/images/affirmationsCategories/angerAnxiety.png'),
                                        title: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 0, left: 0, right: 0),
                                          child: Text("Ansiedade e Raiva",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 35.0),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20.0),
                                      child: InkWell(
                                        onTap: () {},
                                        child: TransparentImageCard(
                                          width: 130,
                                          height: 145,
                                          imageProvider: AssetImage(
                                              'assets/images/affirmationsCategories/positiveThink.png'),
                                          title: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0, left: 0, right: 0),
                                            child: Text("Pensamento Positivo",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 11)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20.0),
                                      child: InkWell(
                                        onTap: () {},
                                        child: TransparentImageCard(
                                          width: 130,
                                          height: 145,
                                          imageProvider: AssetImage(
                                              'assets/images/affirmationsCategories/selfLove.png'),
                                          title: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0, left: 0, right: 0),
                                            child: Text("Amor Próprio",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 35.0),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20.0),
                                      child: InkWell(
                                        onTap: () {},
                                        child: TransparentImageCard(
                                          width: 130,
                                          height: 145,
                                          imageProvider: AssetImage(
                                              'assets/images/affirmationsCategories/personalGrowing.png'),
                                          title: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0, left: 0, right: 0),
                                            child: Text("Crescimento Pessoal",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 11)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20.0),
                                      child: InkWell(
                                        onTap: () {},
                                        child: TransparentImageCard(
                                          width: 130,
                                          height: 145,
                                          imageProvider: AssetImage(
                                              'assets/images/affirmationsCategories/jobGrowing.png'),
                                          title: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0, left: 0, right: 0),
                                            child: Text("Evolução Profissional",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 11)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    
                                  ],
                                  
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 35.0, bottom: 30),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20.0),
                                      child: InkWell(
                                        onTap: () {},
                                        child: TransparentImageCard(
                                          width: 130,
                                          height: 145,
                                          imageProvider: AssetImage(
                                              'assets/images/affirmationsCategories/hardTimes.png'),
                                          title: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0, left: 0, right: 0),
                                            child: Text("Tempos Difíceis",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 11)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20.0),
                                      child: InkWell(
                                        onTap: () {},
                                        child: TransparentImageCard(
                                          width: 130,
                                          height: 145,
                                          imageProvider: AssetImage(
                                              'assets/images/affirmationsCategories/customAdded.png'),
                                          title: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0, left: 0, right: 0),
                                            child: Text("Personalizadas",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  
                ]))),
      ),
       /*floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 210.0),
        child: Row(
          children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 7),
                child: Container(
                  width: 170,
                  child: FloatingActionButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Wrap(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 12.0, bottom: 2),
                              child: Text(
                                'Guardar Alterações',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'lato'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Icon(
                                PhosphorIcons.calendarCheck,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    backgroundColor: Colors.black,
                  ),
                ),
        )],
    )
    )*/
    );
  }
}
