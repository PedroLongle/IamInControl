import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:project_i_am_in_control/functionalities/homePage/screens/homeScreen.dart';

List<String> items = ["Hoje", "Data exemplo", "Data exemplo (1)", "Data exemplo (2)"];
String currentItem = "";
List<String> dateList = [];
String dateLists = "";

// citylist.addAll(["Moscow", "London", "Sydney"]);

class UserPersonalDiaryScreen extends StatefulWidget {
  const UserPersonalDiaryScreen({super.key});

  @override
  State<UserPersonalDiaryScreen> createState() => _UserPersonalDiaryScreenState();
}

class _UserPersonalDiaryScreenState extends State<UserPersonalDiaryScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  bool isRegisted = true;
  bool _isLoading = true;

  String diarytitle = '';

  final _diaryTitleController = TextEditingController();

  bool nullFieldChecker = false;

  String? userName = '';

  Future checkDiaryState() {
    return FirebaseFirestore.instance
        .collection('userDiary')
        .doc('users')
        .collection(user.uid)
        .doc('myDiary')
        .get()
        .then(
      (snapshot) async {
        if (mounted)
          setState(() {
            if (snapshot.exists) {
              FirebaseFirestore.instance
                  .collection('userDiary')
                  .doc('users')
                  .collection(user.uid)
                  .doc('myDiary')
                  .get()
                  .then(
                (snapshot) async {
                  if (mounted)
                    setState(() {
                      if (snapshot.exists) {
                        setState(() {
                          diarytitle = snapshot.data()!["title"];
                          _isLoading = false;
                        });
                      }
                    });
                },
              );
            } else {
              setState(() {
                setState(() {
                  final user = FirebaseAuth.instance.currentUser!;

                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .get()
                      .then(
                    (snapshot) async {
                      if (mounted)
                        setState(() {
                          if (snapshot.exists) {
                            setState(() {
                              userName = snapshot.data()!["first name"];
                            });
                          }
                        });
                    },
                  ).then((value) {
                    FirebaseFirestore.instance
                        .collection('userDiary')
                        .doc('users')
                        .collection(user.uid)
                        .doc('myDiary')
                        .set({
                      'title': 'Diário de ${userName}',
                    }).then((value) {
                      FirebaseFirestore.instance
                          .collection("users")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .get()
                          .then(
                        (snapshot) async {
                          if (mounted)
                            setState(() {
                              if (snapshot.exists) {
                                setState(() {
                                  diarytitle = snapshot.data()!["title"];
                                  _isLoading == false;
                                  isRegisted == false;
                                });
                              }
                            });
                        },
                      );
                    });
                  });
                });
              });
            }
          });
      },
    );
  }

  Future getExistingLogs() async {
    await FirebaseFirestore.instance
        .collection('userDiary')
        .doc('users')
        .collection(user.uid)
        .doc('myDiary')
        .get()
        .then((snapshot) async {
      if (mounted)
        setState(() {
          dateLists = snapshot.data()!['title'];
        });
    });
  }

  Future emptyFieldChecker(
    TextEditingController diaryTitleFieldContent,
  ) async {
    if (diaryTitleFieldContent.text.isNotEmpty) {
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
            content: Text(
                'O campo "Título do Diário" é de prenchimento obrigatório!'),
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

  @override
  Widget build(BuildContext context) {
    checkDiaryState().then(
      (value) {
        getExistingLogs();
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        surfaceTintColor: Colors.white,
                        backgroundColor: Colors.white,
                        content: Text(
                            "Tem a certeza que pretende sair do diário?\nSerá necessária outra verificação de identidade."),
                        actions: <Widget>[
                          TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.white),
                            child: Text('Cancelar',
                                style: TextStyle(color: Colors.black)),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.white),
                            child: Text('Sair',
                                style: TextStyle(color: Colors.red)),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()));
                            },
                          ),
                        ],
                      );
                    });
          },
        ),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 0),
            child: Text(
              diarytitle,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
        actions: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (builder) {
                          return AlertDialog(
                            surfaceTintColor: Colors.white,
                            backgroundColor: Colors.white,
                            content: Padding(
                              padding: const EdgeInsets.all(0),
                              child: Container(
                                height: 150,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Introduza um título para o seu diário!",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Row(
                                        children: [
                                          Flexible(
                                            child: TextField(
                                              controller: _diaryTitleController,
                                              maxLength: 20,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              decoration: InputDecoration(
                                                hintText:
                                                    "(máximo 20 caracteres)",
                                                labelText: "Título do Diário*",
                                                labelStyle: new TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16),
                                                hintStyle: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.normal),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black),
                                                ),
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
                            actions: <Widget>[
                              TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.white),
                                child: Text('Cancelar',
                                    style: TextStyle(color: Colors.red)),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.white),
                                child: Text('Confirmar',
                                    style: TextStyle(color: Colors.black)),
                                onPressed: () {
                                  emptyFieldChecker(_diaryTitleController);
                                  if (nullFieldChecker == true) {
                                    FirebaseFirestore.instance
                                        .collection('userDiary')
                                        .doc('users')
                                        .collection(user.uid)
                                        .doc('myDiary')
                                        .set({
                                      'title':
                                          _diaryTitleController.text.toString(),
                                    });
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text('Título editado com sucesso!'),
                                        behavior: SnackBarBehavior.floating,
                                        margin: EdgeInsets.symmetric(
                                            vertical: 20.0),
                                        duration: Duration(milliseconds: 2000),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          );
                        });
                  },
                  child: Icon(
                    PhosphorIcons.pencil,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: _isLoading
          ? SafeArea(
              child: Column(
                children: [
                  Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 250.0),
                        child: Text(
                            'Estamos a preparar ', style: TextStyle(fontSize: 18, fontFamily: 'lato', fontWeight: FontWeight.bold),),
                      )),
                      Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                            'a melhor experiência para ti!', style: TextStyle(fontSize: 18, fontFamily: 'lato', fontWeight: FontWeight.bold),),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.black,
                      strokeWidth: 4,
                      color: Colors.green,
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  ),
                ],
              ))
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0, top: 30),
                        child: Row(
                          children: [
                            Text(diarytitle,
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text('Como se sente hoje?',
                                    style: TextStyle(
                                      fontSize: 14.5,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 190.0, top: 20),
                            child: DropdownDates(),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 20.0, left: 40),
                              child: SizedBox(
                                width: 295,
                                height: 450,
                                child: Container(
                                  color: Colors.grey[200],
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 12.0, left: 16),
                                              child: Text(
                                                currentItem,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16.0, top: 15, right: 16),
                                          child: Row(children: [
                                            Flexible(
                                              child: Text(
                                                'Corpo do Registo',
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 220.0),
        child: Row(
          children: [
            if (isRegisted == false) ...[
              Padding(
                padding: const EdgeInsets.only(bottom: 7),
                child: Container(
                  width: 160,
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
                                'Adicionar Registo',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'lato'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Icon(
                                PhosphorIcons.penBold,
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
              )
            ] else ...[
              Text('')
            ],
          ],
        ),
      ),
    );
  }
}

class DropdownDates extends StatefulWidget {
  const DropdownDates({Key? key}) : super(key: key);

  @override
  _DropdownDatesState createState() => _DropdownDatesState();
}

class _DropdownDatesState extends State<DropdownDates> {
  @override
  void initState() {
    currentItem = items[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: DropdownButton(
        alignment: Alignment.topCenter,
        borderRadius: BorderRadius.circular(8),
        dropdownColor: Colors.white,
        value: currentItem,
        items: items
            .map<DropdownMenuItem<String>>(
              (e) => DropdownMenuItem(
                value: e,
                child: Text(e),
                alignment: Alignment.center,
              ),
            )
            .toList(),
        onChanged: (String? value) => setState(
          () {
            if (value != null) currentItem = value;
          },
        ),
      ),
    );
  }
}
