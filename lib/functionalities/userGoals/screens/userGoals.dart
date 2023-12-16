import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../homePage/screens/homeScreen.dart';

class UserGoalsScreen extends StatefulWidget {
  const UserGoalsScreen({super.key});

  @override
  State<UserGoalsScreen> createState() => _UserGoalsScreenState();
}

class _UserGoalsScreenState extends State<UserGoalsScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  DateTime _dateTime = DateTime.now();

  final _goalTitleController = TextEditingController();
  final _goalDescriptionController = TextEditingController();

  String finalDescription = '';

  bool nullFieldChecker = false;

  Future addCurrentUserGoal(
    String goalTitle,
    String goalDescription,
    String goalEndDate,
    String goalStatus,
  ) async {
    final user = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection('userGoals')
        .doc('users')
        .collection(user.uid)
        .doc(goalTitle)
        .set({
      'title': goalTitle,
      'description': goalDescription,
      'endDate': goalEndDate,
      'status': goalStatus,
      'doneDate': '',
    });
  }

  Future emptyFieldChecker(
    TextEditingController goalTitleFieldContent,
  ) async {
    if (goalTitleFieldContent.text.isNotEmpty) {
      setState(() {
        nullFieldChecker = true;
      });
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            content: Text('O campo "Título" é de prenchimento obrigatório!'),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.white),
                child: Text('Tentar Novamente',
                    style: TextStyle(color: Colors.black)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    ;
  }

  Future checkDescription(String goalDescription) async {
    if (goalDescription.trim() != '') {
      setState(() {
        finalDescription = goalDescription;
      });
    } else {
      setState(() {
        finalDescription = 'Sem descrição detalhada.';
      });
    }
    ;
  }

  @override
  void dispose() {
    _goalTitleController.dispose();
    _goalDescriptionController.dispose();
    super.dispose();
  }

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
                    return HomeScreen();
                  },
                ),
              );
            }),
        title: Padding(
          padding: const EdgeInsets.only(left: 45.0),
          child: Text(
            '',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 35.0, top: 40),
                child: Row(
                  children: [
                    Text(
                      'Os meus objetivos',
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35.0),
                child: Row(
                  children: [
                    Text('Aqui pode consultar todos os seus objetivos!',
                        style: TextStyle(
                          fontSize: 14.5,
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35.0, top: 55),
                child: Row(
                  children: [
                    Text('Objetivos a cumprir',
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0, top: 20),
                child: SizedBox(
                  height: 200,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('userGoals')
                          .doc('users')
                          .collection(user.uid)
                          .where('status', isEqualTo: 'toDo')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 50.0),
                            child: Center(
                              child: Text(
                                'A carregar...',
                                style: TextStyle(
                                    color: Colors.grey[500], fontSize: 15),
                              ),
                            ),
                          );
                        } else if (snapshot.data!.docs.length < 1) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 50.0),
                            child: Center(
                              child: Text(
                                'Sem objetivos a cumprir no momento.',
                                style: TextStyle(
                                    color: Colors.grey[500], fontSize: 15),
                              ),
                            ),
                          );
                        } else {
                          return GridView.count(
                            primary: false,
                            crossAxisCount: 1,
                            padding: const EdgeInsets.all(5),
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 10,
                            childAspectRatio: (20 / 6),
                            children: List.generate(snapshot.data!.docs.length,
                                (index) {
                              return GestureDetector(
                                onTap: () {
                                  showDialog(
                                      //AQUI
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.white,
                                          surfaceTintColor: Colors.white,
                                          content: StatefulBuilder(
                                            builder: (BuildContext context,
                                                StateSetter setState) {
                                              return Container(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 2.0,
                                                                  top: 10,
                                                                  right: 15),
                                                          child: Text(
                                                            snapshot.data!
                                                                .docs[index]
                                                                .get('title'),
                                                            style: TextStyle(
                                                                fontSize: 21,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10,
                                                              top: 30),
                                                      child: Row(children: [
                                                        Text('Descrição:',
                                                            style: TextStyle(
                                                              fontSize: 13,
                                                            )),
                                                      ]),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10,
                                                              top: 15),
                                                      child: Row(children: [
                                                        Flexible(
                                                          child: Text(
                                                            snapshot.data!
                                                                .docs[index]
                                                                .get(
                                                                    'description'),
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ),
                                                      ]),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10,
                                                                  top: 35),
                                                          child: Row(children: [
                                                            Text(
                                                                'Data de Conclusão:',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 13,
                                                                )),
                                                          ]),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15,
                                                              top: 15),
                                                      child: Row(children: [
                                                        Text(
                                                          snapshot
                                                              .data!.docs[index]
                                                              .get('endDate'),
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 50,
                                                                  top: 0),
                                                          child: Row(children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 0,
                                                                      top: 0),
                                                              child:
                                                                  MaterialButton(
                                                                      minWidth:
                                                                          2,
                                                                      height:
                                                                          25,
                                                                      color: Colors
                                                                          .green,
                                                                      onPressed:
                                                                          () {
                                                                        showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (context) {
                                                                              DateTime _doneDateTime = DateTime.now();
                                                                              DateFormat showDateFormatter = DateFormat('dd-MM-yyyy');
                                                                              String toShowFormattedDate = showDateFormatter.format(_doneDateTime);
                                                                              return AlertDialog(
                                                                                surfaceTintColor: Colors.white,
                                                                                backgroundColor: Colors.white,
                                                                                content: Text("Tem a certeza que pretende marcar este objetivo como cumprido?"),
                                                                                actions: <Widget>[
                                                                                  TextButton(
                                                                                    style: TextButton.styleFrom(backgroundColor: Colors.white),
                                                                                    child: Text('Cancelar', style: TextStyle(color: Colors.black)),
                                                                                    onPressed: () {
                                                                                      Navigator.of(context).pop();
                                                                                    },
                                                                                  ),
                                                                                  TextButton(
                                                                                    style: TextButton.styleFrom(backgroundColor: Colors.white),
                                                                                    child: Text('Confirmar', style: TextStyle(color: Colors.green)),
                                                                                    onPressed: () {
                                                                                      Navigator.of(context).pop();
                                                                                      FirebaseFirestore.instance.collection('userGoals').doc('users').collection(user.uid).doc(snapshot.data!.docs[index].get('title')).update({
                                                                                        'status': 'done',
                                                                                        'doneDate': toShowFormattedDate.toString()
                                                                                      });
                                                                                      Navigator.of(context).pop();
                                                                                    },
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            });
                                                                      },
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Icon(
                                                                            PhosphorIcons.checkCircle,
                                                                            size:
                                                                                16,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ],
                                                                      )),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 0,
                                                                      top: 0),
                                                              child:
                                                                  MaterialButton(
                                                                      minWidth:
                                                                          2,
                                                                      height:
                                                                          25,
                                                                      color: Colors
                                                                          .red,
                                                                      onPressed:
                                                                          () {
                                                                        showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (context) {
                                                                              return AlertDialog(
                                                                                surfaceTintColor: Colors.white,
                                                                                backgroundColor: Colors.white,
                                                                                content: Text("Tem a certeza que pretende eliminar este registo?"),
                                                                                actions: <Widget>[
                                                                                  TextButton(
                                                                                    style: TextButton.styleFrom(backgroundColor: Colors.white),
                                                                                    child: Text('Cancelar', style: TextStyle(color: Colors.black)),
                                                                                    onPressed: () {
                                                                                      Navigator.of(context).pop();
                                                                                    },
                                                                                  ),
                                                                                  TextButton(
                                                                                    style: TextButton.styleFrom(backgroundColor: Colors.white),
                                                                                    child: Text('Confirmar', style: TextStyle(color: Colors.red)),
                                                                                    onPressed: () {
                                                                                      Navigator.of(context).pop();
                                                                                      FirebaseFirestore.instance.collection('userGoals').doc('users').collection(user.uid).doc(snapshot.data!.docs[index].get('title')).delete();
                                                                                      Navigator.of(context).pop();
                                                                                    },
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            });
                                                                      },
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Icon(
                                                                            PhosphorIcons.trash,
                                                                            size:
                                                                                16,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ],
                                                                      )),
                                                            ),
                                                          ]),
                                                        ),
                                                      ]),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.white),
                                              child: Text('Fechar',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  )),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                  //
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Container(
                                      child: ListTile(
                                        title: Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 216,
                                                height: 32,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                            '${snapshot.data!.docs[index].get('title')}',
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            )),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: 54,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 0,
                                                                  top: 0),
                                                          child: MaterialButton(
                                                              minWidth: 2,
                                                              height: 25,
                                                              color:
                                                                  Colors.green,
                                                              onPressed: () {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      DateTime
                                                                          _doneDateTime =
                                                                          DateTime
                                                                              .now();
                                                                      DateFormat
                                                                          showDateFormatter =
                                                                          DateFormat(
                                                                              'dd-MM-yyyy');
                                                                      String
                                                                          toShowFormattedDate =
                                                                          showDateFormatter
                                                                              .format(_doneDateTime);
                                                                      return AlertDialog(
                                                                        surfaceTintColor:
                                                                            Colors.white,
                                                                        backgroundColor:
                                                                            Colors.white,
                                                                        content:
                                                                            Text("Tem a certeza que pretende marcar este objetivo como cumprido?"),
                                                                        actions: <Widget>[
                                                                          TextButton(
                                                                            style:
                                                                                TextButton.styleFrom(backgroundColor: Colors.white),
                                                                            child:
                                                                                Text('Cancelar', style: TextStyle(color: Colors.black)),
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                          ),
                                                                          TextButton(
                                                                            style:
                                                                                TextButton.styleFrom(backgroundColor: Colors.white),
                                                                            child:
                                                                                Text('Confirmar', style: TextStyle(color: Colors.green)),
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.of(context).pop();
                                                                              FirebaseFirestore.instance.collection('userGoals').doc('users').collection(user.uid).doc(snapshot.data!.docs[index].get('title')).update({
                                                                                'status': 'done',
                                                                                'doneDate': toShowFormattedDate.toString()
                                                                              });
                                                                            },
                                                                          ),
                                                                        ],
                                                                      );
                                                                    });
                                                              },
                                                              child: Row(
                                                                children: [
                                                                  Icon(
                                                                    PhosphorIcons
                                                                        .checkCircle,
                                                                    size: 16,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ],
                                                              )),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        subtitle: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 0),
                                          child: Padding(
                                            padding: const EdgeInsets.all(0),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15.0),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        child: SizedBox(
                                                          child: Text(
                                                            "Data de Conclusão: " +
                                                                snapshot.data!
                                                                    .docs[index]
                                                                    .get(
                                                                        'endDate'),
                                                            textAlign:
                                                                TextAlign.start,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      margin:
                                          EdgeInsets.only(left: 35, right: 35),
                                      color: Colors.grey[100]),
                                ),
                              );
                            }),
                          );
                        }
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35.0, top: 20),
                child: Row(
                  children: [
                    Text('Objetivos cumpridos',
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0, top: 20),
                child: SizedBox(
                  height: 200,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('userGoals')
                          .doc('users')
                          .collection(user.uid)
                          .where('status', isEqualTo: 'done')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 50.0),
                            child: Center(
                              child: Text(
                                'A carregar...',
                                style: TextStyle(
                                    color: Colors.grey[500], fontSize: 15),
                              ),
                            ),
                          );
                        } else if (snapshot.data!.docs.length < 1) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 50.0),
                            child: Center(
                              child: Text(
                                'Sem objetivos cumpridos no momento.',
                                style: TextStyle(
                                    color: Colors.grey[500], fontSize: 15),
                              ),
                            ),
                          );
                        } else {
                          return GridView.count(
                            primary: false,
                            crossAxisCount: 1,
                            padding: const EdgeInsets.all(5),
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 10,
                            childAspectRatio: (20 / 6),
                            children: List.generate(snapshot.data!.docs.length,
                                (index) {
                              return GestureDetector(
                                onTap: () {
                                  showDialog(
                                      //AQUI
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.white,
                                          surfaceTintColor: Colors.white,
                                          content: StatefulBuilder(
                                            builder: (BuildContext context,
                                                StateSetter setState) {
                                              return Container(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 2.0,
                                                                  top: 10,
                                                                  right: 15),
                                                          child: Text(
                                                            snapshot.data!
                                                                .docs[index]
                                                                .get('title'),
                                                            style: TextStyle(
                                                                fontSize: 21,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10,
                                                              top: 15),
                                                      child: Row(children: [
                                                        Flexible(
                                                          child: Text(
                                                            snapshot.data!
                                                                .docs[index]
                                                                .get(
                                                                    'description'),
                                                            style: TextStyle(
                                                                fontSize: 14),
                                                          ),
                                                        ),
                                                      ]),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10,
                                                                  top: 35),
                                                          child: Row(children: [
                                                            Text(
                                                                'Data de Conclusão:',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 13,
                                                                )),
                                                          ]),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15,
                                                              top: 15),
                                                      child: Row(children: [
                                                        Text(
                                                          snapshot
                                                              .data!.docs[index]
                                                              .get('endDate'),
                                                          style: TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 70,
                                                                  top: 0),
                                                          child: Row(children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 0,
                                                                      top: 0),
                                                              child:
                                                                  MaterialButton(
                                                                      minWidth:
                                                                          2,
                                                                      height:
                                                                          25,
                                                                      color: Colors
                                                                          .red,
                                                                      onPressed:
                                                                          () {
                                                                        showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (context) {
                                                                              return AlertDialog(
                                                                                surfaceTintColor: Colors.white,
                                                                                backgroundColor: Colors.white,
                                                                                content: Text("Tem a certeza que pretende eliminar este registo?"),
                                                                                actions: <Widget>[
                                                                                  TextButton(
                                                                                    style: TextButton.styleFrom(backgroundColor: Colors.white),
                                                                                    child: Text('Cancelar', style: TextStyle(color: Colors.black)),
                                                                                    onPressed: () {
                                                                                      Navigator.of(context).pop();
                                                                                    },
                                                                                  ),
                                                                                  TextButton(
                                                                                    style: TextButton.styleFrom(backgroundColor: Colors.white),
                                                                                    child: Text('Confirmar', style: TextStyle(color: Colors.red)),
                                                                                    onPressed: () {
                                                                                      Navigator.of(context).pop();
                                                                                      FirebaseFirestore.instance.collection('userGoals').doc('users').collection(user.uid).doc(snapshot.data!.docs[index].get('title')).delete();
                                                                                      Navigator.of(context).pop();
                                                                                    },
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            });
                                                                      },
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Icon(
                                                                            PhosphorIcons.trash,
                                                                            size:
                                                                                16,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ],
                                                                      )),
                                                            ),
                                                          ]),
                                                        ),
                                                      ]),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15,
                                                                  top: 5),
                                                          child: Row(children: [
                                                            Text(
                                                                'Concluído a: ',
                                                                style:
                                                                    TextStyle(
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                  fontSize: 11,
                                                                )),
                                                            Text(
                                                              snapshot.data!
                                                                  .docs[index]
                                                                  .get(
                                                                      'doneDate'),
                                                              style: TextStyle(
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                                fontSize: 11,
                                                              ),
                                                            ),
                                                          ]),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.white),
                                              child: Text('Fechar',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  )),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                  //
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Container(
                                      child: ListTile(
                                        title: Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 216,
                                                height: 32,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                            '${snapshot.data!.docs[index].get('title')}',
                                                            style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            )),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: 54,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 0,
                                                                  top: 0),
                                                          child: MaterialButton(
                                                              minWidth: 2,
                                                              height: 25,
                                                              color: Colors.red,
                                                              onPressed: () {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return AlertDialog(
                                                                        surfaceTintColor:
                                                                            Colors.white,
                                                                        backgroundColor:
                                                                            Colors.white,
                                                                        content:
                                                                            Text("Tem a certeza que pretende eliminar este registo?"),
                                                                        actions: <Widget>[
                                                                          TextButton(
                                                                            style:
                                                                                TextButton.styleFrom(backgroundColor: Colors.white),
                                                                            child:
                                                                                Text('Cancelar', style: TextStyle(color: Colors.black)),
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                          ),
                                                                          TextButton(
                                                                            style:
                                                                                TextButton.styleFrom(backgroundColor: Colors.white),
                                                                            child:
                                                                                Text('Confirmar', style: TextStyle(color: Colors.red)),
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.of(context).pop();
                                                                              FirebaseFirestore.instance.collection('userGoals').doc('users').collection(user.uid).doc(snapshot.data!.docs[index].get('title')).delete();
                                                                            },
                                                                          ),
                                                                        ],
                                                                      );
                                                                    });
                                                              },
                                                              child: Row(
                                                                children: [
                                                                  Icon(
                                                                    PhosphorIcons
                                                                        .trash,
                                                                    size: 16,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ],
                                                              )),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        subtitle: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 0),
                                          child: Padding(
                                            padding: const EdgeInsets.all(0),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15.0),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        child: SizedBox(
                                                          child: Text(
                                                            "Data de Conclusão: " +
                                                                snapshot.data!
                                                                    .docs[index]
                                                                    .get(
                                                                        'endDate'),
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ), //quando ele abre a app, calcular os dados: dinheiro poupado, tempo sem. Botao para eliminar que elimina isto da lista de addictions
                                        ),
                                      ),
                                      margin:
                                          EdgeInsets.only(left: 35, right: 35),
                                      color: Colors.grey[100]),
                                ),
                              );
                            }),
                          );
                        }
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 25, right: 20),
        child: FloatingActionButton(
          onPressed: (() {
            showDialog(
                context: context,
                builder: (context) {
                  DateFormat showDateFormatter = DateFormat('dd-MM-yyyy');
                  String toShowFormattedDate =
                      showDateFormatter.format(_dateTime);

                  return AlertDialog(
                    backgroundColor: Colors.white,
                    surfaceTintColor: Colors.white,
                    content: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        _showDatePicker() {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2025),
                            helpText: 'Selecionar data de Conclusão',
                            cancelText: 'Cancelar',
                            confirmText: 'Confirmar',
                            builder: (context, child) {
                              return Theme(
                                data: ThemeData.dark(),
                                child: child!,
                              );
                            },
                          ).then((value) {
                            if (value == null) {
                              return;
                            } else
                              setState(() {
                                _dateTime = value;
                                toShowFormattedDate =
                                    showDateFormatter.format(_dateTime);
                              });
                          });
                        }

                        return Container(
                          height: 410,
                          width: 500,
                          child: Column(
                            children: [
                              SingleChildScrollView(
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 2.0, top: 10, right: 15),
                                        child: TextField(
                                          controller: _goalTitleController,
                                          maxLength: 20,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                          decoration: InputDecoration(
                                            hintText: "(máximo 20 caracteres)",
                                            labelText: "Título do Objetivo*",
                                            labelStyle: new TextStyle(
                                                color: Colors.black,
                                                fontSize: 18),
                                            hintStyle: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 2.0, top: 5, right: 15),
                                      child: TextField(
                                        controller: _goalDescriptionController,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 5,
                                        maxLength: 150,
                                        decoration: InputDecoration(
                                          hintText: "(máximo 150 caracteres)",
                                          labelText: "Descrição (opcional)",
                                          labelStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
                                          hintStyle: TextStyle(fontSize: 15),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 2, top: 8),
                                    child: Row(children: [
                                      Text('Data de Conclusão:',
                                          style: TextStyle(
                                            fontSize: 13,
                                          )),
                                    ]),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 23, top: 15),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20.0),
                                        child: Text(
                                          toShowFormattedDate.toString(),
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 0),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 6, top: 16.0),
                                        child: Material(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                          elevation: 18.0,
                                          color: Colors.black,
                                          child: MaterialButton(
                                            height: 2,
                                            color: Colors.black,
                                            onPressed: _showDatePicker,
                                            child: Text(
                                              'Definir data',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
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
                        );
                      },
                    ),
                    actions: <Widget>[
                      TextButton(
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.white),
                        child: Text('Adicionar',
                            style: TextStyle(
                              color: Colors.black,
                            )),
                        onPressed: () {
                          emptyFieldChecker(_goalTitleController);
                          if (nullFieldChecker == true) {
                            checkDescription(
                                _goalDescriptionController.text.trim());
                            addCurrentUserGoal(
                                _goalTitleController.text,
                                finalDescription,
                                toShowFormattedDate.toString(),
                                'toDo');
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Objetivo adicionado com sucesso!'),
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.symmetric(vertical: 20.0),
                              duration: Duration(milliseconds: 2000),
                            ));
                            ;

                            _goalDescriptionController.text = '';
                            _goalTitleController.text = '';

                            setState(() {
                              nullFieldChecker = false;
                            });
                          } else {}
                        },
                      ),
                    ],
                  );
                });
          }),
          child: Icon(
            PhosphorIcons.plusBold,
            color: Colors.white,
          ),
          backgroundColor: Colors.black,
        ),
      ),
    );
  }
}

//Inicio: 1313 linhas de codigo