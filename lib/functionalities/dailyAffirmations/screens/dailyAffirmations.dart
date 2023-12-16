import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_i_am_in_control/functionalities/dailyAffirmations/widgets/configure_affirmations_button.dart';
import 'package:project_i_am_in_control/functionalities/dailyAffirmations/widgets/configure_myaffirmations_button.dart';
import 'package:project_i_am_in_control/functionalities/dailyAffirmations/widgets/myaffirmations_showcase.dart';
import 'package:project_i_am_in_control/functionalities/dailyAffirmations/widgets/reload_affirmations_button.dart';

import '../../homePage/screens/homeScreen.dart';

class DailyAffirmationsScreen extends StatefulWidget {
  const DailyAffirmationsScreen({super.key});

  @override
  State<DailyAffirmationsScreen> createState() =>
      _DailyAffirmationsScreenState();
}

class _DailyAffirmationsScreenState extends State<DailyAffirmationsScreen> {

  Widget getReloadButton(int pageCount) {
    if (pageCount >= 5) {
      return Padding(
        padding: const EdgeInsets.only(left: 125, top: 0),
        child: ReloadAffirmationsButton(),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(0),
      );
    }
  }


  final FirebaseAuth _auth = FirebaseAuth.instance;
  String getCurrentUserUid() {
    final user = _auth.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return 'sem id';
    }
  }

  int pageCount = 0;

  late List<String> texts = [
    'Sou muito amado.',
    'Sou Capaz',
    'Vou conseguir',
    'oi',
    'aaa',
  ];

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
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 40.0),
          child: Text(
            '',
            style: TextStyle(fontSize: 20, color: Colors.white),
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
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40.0, top: 35),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Wrap(children: [
                          Text(
                              'Bom dia, pedro!', //funcao para definir se é bom dia, boa tarde ou boa noite | receber nome do user
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              )),
                        ]),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Column(children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 10.0),
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
                                onPageChanged: (index) {
                                  pageCount = index + 1;
                                  if (pageCount >= 5) {
                                    Text('data', style: TextStyle(fontSize: 66, color: Colors.red),);
                                  } else {
                                    return;
                                  }
                                  ;
                                },
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
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 230, top: 10),
                    child: configureAffirmationsButton(),
                  ),
                ],
              ),
              SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.only(left: 40.0, top: 20),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text('As minhas Afirmações',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: myAffirmationsShowcase(),
              ),
              
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 200),
                child: Row(
                  children: [
                    configureMyAffirmationsButton(),
                  ],
                ),
              ),              
            ],
          ),
        )),
      ),
    );
  }
}
