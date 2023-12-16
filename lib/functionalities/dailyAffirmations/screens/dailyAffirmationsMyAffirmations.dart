import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:project_i_am_in_control/functionalities/dailyAffirmations/screens/dailyAffirmations.dart';

class MyAffirmationsScreen extends StatefulWidget {
  const MyAffirmationsScreen({super.key});

  @override
  State<MyAffirmationsScreen> createState() => _MyAffirmationsScreenState();
}

class _MyAffirmationsScreenState extends State<MyAffirmationsScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  late Future<ListResult> futureFiles;
  bool nullFieldChecker = false;

  final _newAffirmationController = TextEditingController();

  Future addCurrentUserAffirmation(
    String affirmation,
  ) async {
    final user = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection('dailyAffirmations')
        .doc('users')
        .collection(user.uid)
        .doc(affirmation)
        .set({
      'title': affirmation,
    });
  }

  Future emptyFieldChecker(
    TextEditingController _newAffirmationController,
  ) async {
    if (_newAffirmationController.text.isNotEmpty) {
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
                'Deve preencher o campo apresentado com a sua nova afirmação!'),
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
                      return DailyAffirmationsScreen();
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
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 35.0, left: 25),
                        child: Text(
                          'As suas Afirmações!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 23),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, top: 20),
                    child: SizedBox(
                      height: 575,
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('dailyAffirmations')
                              .doc('users')
                              .collection(user.uid)
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
                                    'Sem afirmações adicionadas até ao momento.',
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
                                childAspectRatio: (21 / 3.7),
                                children: List.generate(
                                    snapshot.data!.docs.length, (index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Container(
                                        child: ListTile(
                                          title: Padding(
                                            padding: const EdgeInsets.all(0),
                                            child: Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Container(
                                                                alignment: Alignment.topLeft,
                                                                width: 215,
                                                                child: Column(
                                                                  children: [
                                                                    Text(
                                                                        '${snapshot.data!.docs[index].get('title')}',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .bold,
                                                                        )),
                                                                  ],
                                                                ),
                                                              ),
                                                              Column(
                                                                children: [
                                                                  MaterialButton(
                                                                  minWidth: 1,
                                                                  height: 25,
                                                                  color: Colors.red,
                                                                  onPressed: () {
                                                                    showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) {
                                                                          return AlertDialog(
                                                                            surfaceTintColor: Colors.white,
                                                                            backgroundColor: Colors.white,
                                                                            content: Text("Tem a certeza que pretende eliminar esta afirmação?"),
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
                                                                                  FirebaseFirestore.instance.collection('dailyAffirmations').doc('users').collection(user.uid).doc(snapshot.data!.docs[index].get('title')).delete();
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                              ),
                                                                            ],
                                                                          );
                                                                        });
                                                                  },
                                                                  child: Row(
                                                                    mainAxisSize: MainAxisSize.min,
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
                                                                ],
                                                              )
                                                              
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        margin: EdgeInsets.only(
                                            left: 35, right: 35),
                                        color: Colors.grey[100]
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
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 25, right: 20),
          child: FloatingActionButton(
            onPressed: (() {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      surfaceTintColor: Colors.white,
                      content: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SingleChildScrollView(
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 2.0, top: 10, right: 15),
                                        child: TextField(
                                          controller: _newAffirmationController,
                                          maxLength: 30,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                          decoration: InputDecoration(
                                            hintText: "(máximo 30 caracteres)",
                                            labelText: "Nova Afirmação*",
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
                            ],
                          );
                        },
                      ),
                      actions: <Widget>[
                        TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.white),
                          child: Text('Adicionar',
                              style: TextStyle(
                                color: Colors.black,
                              )),
                          onPressed: () {
                            emptyFieldChecker(_newAffirmationController);
                            if (nullFieldChecker == true) {
                              addCurrentUserAffirmation(
                                  _newAffirmationController.text);

                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content:
                                    Text('Afirmação adicionada com sucesso!'),
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.symmetric(vertical: 20.0),
                                duration: Duration(milliseconds: 2000),
                              ));
                              ;

                              _newAffirmationController.text = '';

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
        ));
  }
}
