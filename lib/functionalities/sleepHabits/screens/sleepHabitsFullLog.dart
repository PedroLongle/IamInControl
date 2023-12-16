import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_i_am_in_control/functionalities/sleepHabits/screens/sleepHabits.dart';

class SleepFullLogScreen extends StatefulWidget {
  const SleepFullLogScreen({super.key});

  @override
  State<SleepFullLogScreen> createState() => _SleepFullLogScreenState();
}

class _SleepFullLogScreenState extends State<SleepFullLogScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

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
                Row(children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0, left: 25),
                        child: Text(
                          'Registo Completo',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 19),
                        ),
                      ),
                    ],
                  ),
                  
                ]),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: SizedBox(
                        height: 600,
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('sleepHabits')
                                .doc('userLogs')
                                .collection(user.uid)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 170.0),
                                  child: Center(
                                    child: Text(
                                      'A carregar...',
                                      style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 15),
                                    ),
                                  ),
                                );
                              } else if (snapshot.data!.docs.length < 1) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 170.0),
                                  child: Center(
                                    child: Text(
                                      'Sem registos adicionados até ao momento.',
                                      style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 15),
                                    ),
                                  ),
                                );
                              } else {
                                return GridView.count(
                                  primary: false,
                                  crossAxisCount: 1,
                                  childAspectRatio: 5 / 1.5,
                                  children: List.generate(
                                      snapshot.data!.docs.length, (index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, left: 30, right: 30),
                                      child: Container(
                                          height: 20,
                                          width: 30,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.grey[200],
                                          ),
                                          child: Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 12.0,
                                                                top: 12),
                                                        child: Wrap(
                                                          children: [
                                                            Text('Dia: '),
                                                            Text(
                                                              snapshot
                                                                      .data!
                                                                      .docs[
                                                                          index]
                                                                      .get(
                                                                          'date') +
                                                                  '',
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 12.0,
                                                                left: 10),
                                                        child: Text(
                                                          snapshot.data!
                                                                  .docs[index]
                                                                  .get(
                                                                      'duration') +
                                                              'h',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 22),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 33.0, left: 35),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                            'Hora de Início: '),
                                                        Text(
                                                          snapshot
                                                              .data!.docs[index]
                                                              .get('bedTime'),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text('Hora de Fim: '),
                                                        Text(
                                                          snapshot
                                                              .data!.docs[index]
                                                              .get(
                                                                  'wakeUpTime'),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )),
                                    );
                                  }),
                                );
                              }
                            }),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
