// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:project_i_am_in_control/functionalities/checkUpLists/screens/listAdultos.dart';
import 'package:project_i_am_in_control/functionalities/checkUpLists/screens/listAutoCuidado.dart';
import '../../homePage/screens/homeScreen.dart';
import 'listJovens.dart';
import 'listResiliencia.dart';

class CheckUpListsScreen extends StatefulWidget {
  const CheckUpListsScreen({super.key});

  @override
  State<CheckUpListsScreen> createState() => _CheckUpListsScreenState();
}

class _CheckUpListsScreenState extends State<CheckUpListsScreen> {
  final List<String> categorias = [
    'Todos',
    'Depressão',
    'Ansiedade',
    'Auto-estima',
    'Comportamento Alimentar',
  ];

  final currentUser = FirebaseAuth.instance.currentUser;

  String? listjovensTitleABV = "";
  String? listjovensTitle = "";
  String? listjovensDesc = "";
  String? listjovensCategory = "";

  String? listadultosTitleABV = "";
  String? listadultosTitle = "";
  String? listadultosDesc = "";
  String? listadultosCategory = "";

  String? listautocuidadoTitleABV = "";
  String? listautocuidadoTitle = "";
  String? listautocuidadoDesc = "";
  String? listautocuidadoCategory = "";

  String? listresilienciaTitleABV = "";
  String? listresilienciaTitle = "";
  String? listresilienciaDesc = "";
  String? listresilienciaCategory = "";

  Future getcheckUpList_JovensData() async {
    await FirebaseFirestore.instance
        .collection("checkUpLists")
        .doc("checkUpList_Jovens")
        .get()
        .then(
      (snapshot) async {
        if (mounted)
          setState(() {
            if (snapshot.exists) {
              setState(() {
                listjovensTitleABV = snapshot.data()!["titleABV"];
                listjovensTitle = snapshot.data()!["title"];
                listjovensDesc = snapshot.data()!["description"];
                listjovensCategory = snapshot.data()!["category"];
              });
            } else {}
          });
      },
    );
  }

  Future getcheckUpList_AdultosData() async {
    await FirebaseFirestore.instance
        .collection("checkUpLists")
        .doc("checkUpList_Adultos")
        .get()
        .then(
      (snapshot) async {
        if (mounted)
          setState(() {
            if (snapshot.exists) {
              setState(() {
                listadultosTitleABV = snapshot.data()!["titleABV"];
                listadultosTitle = snapshot.data()!["title"];
                listadultosDesc = snapshot.data()!["description"];
                listadultosCategory = snapshot.data()!["category"];
              });
            } else {}
          });
      },
    );
  }

  Future getcheckUpList_AutoCuidadoData() async {
    await FirebaseFirestore.instance
        .collection("checkUpLists")
        .doc("checkUpList_AutoCuidado")
        .get()
        .then(
      (snapshot) async {
        if (mounted)
          setState(() {
            if (snapshot.exists) {
              setState(() {
                listautocuidadoTitleABV = snapshot.data()!["titleABV"];
                listautocuidadoTitle = snapshot.data()!["title"];
                listautocuidadoDesc = snapshot.data()!["description"];
                listautocuidadoCategory = snapshot.data()!["category"];
              });
            } else {}
          });
      },
    );
  }

  Future getcheckUpList_ResilienciaData() async {
    await FirebaseFirestore.instance
        .collection("checkUpLists")
        .doc("checkUpList_Resiliencia")
        .get()
        .then(
      (snapshot) async {
        if (mounted)
          setState(() {
            if (snapshot.exists) {
              setState(() {
                listresilienciaTitleABV = snapshot.data()!["titleABV"];
                listresilienciaTitle = snapshot.data()!["title"];
                listresilienciaDesc = snapshot.data()!["description"];
                listresilienciaCategory = snapshot.data()!["category"];
              });
            } else {}
          });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    getcheckUpList_JovensData();
    getcheckUpList_AdultosData();
    getcheckUpList_AutoCuidadoData();
    getcheckUpList_ResilienciaData();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) =>  const  HomeScreen()));
          },
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: Row(
                  children: [
                    Text('Bem vindo(a) às,',
                        style: TextStyle(
                          fontSize: 14.5,
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
                        Text('Listas de Check-up  \nComo me Sinto?',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 55),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CheckUpListJovensScreen(
                                  listjovenstitle: listjovensTitle!,
                                  listjovenstitleABV: listjovensTitleABV!,
                                  listjovensdescription: listjovensDesc!,
                                )));
                      },
                      child: Card(
                        color: Colors.white,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const ListTile(
                          leading: Icon(PhosphorIcons.clipboardText,
                              size: 40, color: Colors.black),
                          title: Text(
                            "Jovens",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 17),
                          ),
                          subtitle: Text(
                            "Lista Check-up | Como me Sinto?",
                          ),
                          tileColor: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CheckUpListAdultosScreen(
                                  listadultostitle: listadultosTitle!,
                                  listadultostitleABV: listadultosTitleABV!,
                                  listadultosdescription: listadultosDesc!,
                                )));
                      },
                      child: Card(
                        color: Colors.white,
                        shadowColor: Colors.black,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const ListTile(
                          leading: Icon(PhosphorIcons.clipboardText,
                              size: 40, color: Colors.black),
                          title: Text(
                            "Adultos",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 17),
                          ),
                          subtitle: Text(
                            "Lista Check-up | Como me Sinto?",
                          ),
                          tileColor: Colors.white,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CheckUpListAutoCuidadoScreen(
                                      listautocuidadotitle:
                                          listautocuidadoTitle!,
                                      listautocuidadotitleABV:
                                          listautocuidadoTitleABV!,
                                      listautocuidadodescription:
                                          listautocuidadoDesc!,
                                    )));
                          },
                          child: Card(
                            color: Colors.white,
                            shadowColor: Colors.black,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const ListTile(
                              leading: Icon(PhosphorIcons.clipboardText,
                                  size: 40, color: Colors.black),
                              title: Text(
                                "Auto-Cuidado",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 17),
                              ),
                              subtitle: Text(
                                "Lista Check-up | Como me Sinto?",
                              ),
                              tileColor: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CheckUpListResilienciaScreen(
                                      listresilienciatitle:
                                          listresilienciaTitle!,
                                      listresilienciatitleABV:
                                          listresilienciaTitleABV!,
                                      listresilienciadescription:
                                          listresilienciaDesc!,
                                    )));
                          },
                          child: Card(
                            color: Colors.white,
                            shadowColor: Colors.black,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const ListTile(
                              leading: Icon(PhosphorIcons.clipboardText,
                                  size: 40, color: Colors.black),
                              title: Text(
                                "Resiliência",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 17),
                              ),
                              subtitle: Text(
                                "Lista Check-up | Como me Sinto?",
                              ),
                              tileColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: new Container(
        height: 45.0,
        color: Colors.white,
        child: Text(
          'I am in Control - © Todos os direitos reservados.',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 13.0, color: Colors.black),
        ),
      ),
    );
  }
}
