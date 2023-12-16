// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unnecessary_new

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_card/image_card.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:project_i_am_in_control/components/widgets/texts/headingText.dart';
import '../../homePage/screens/homeScreen.dart';
import 'package:project_i_am_in_control/functionalities/psychologuiqueTests/screens/testGAD7.dart';
import 'package:project_i_am_in_control/functionalities/psychologuiqueTests/screens/testRosenbergScale.dart';
import 'package:project_i_am_in_control/functionalities/psychologuiqueTests/screens/testSCOFFQuestionnaire.dart';

import '../tools/one_time_alert_managment.dart';
import 'testPHQ9.dart';

class PsychologuiqueTestsScreen extends StatefulWidget {
  const PsychologuiqueTestsScreen({super.key});

  @override
  State<PsychologuiqueTestsScreen> createState() =>
      _PsychologuiqueTestsScreen();
}

class _PsychologuiqueTestsScreen extends State<PsychologuiqueTestsScreen> {

  final currentUser = FirebaseAuth.instance.currentUser;

  final _searchController = TextEditingController();

  String? phq9testTitleABV = "";
  String? phq9testTitle = "";
  String? phq9testDesc = "";
  String? phq9testCategory = "";

  String? gad7testTitleABV = "";
  String? gad7testTitle = "";
  String? gad7testDesc = "";
  String? gad7testCategory = "";

  String? rosenbergtestTitleABV = "";
  String? rosenbergtestTitle = "";
  String? rosenbergtestDesc = "";
  String? rosenbergtestCategory = "";

  String? scofftestTitleABV = "";
  String? scofftestTitle = "";
  String? scofftestDesc = "";
  String? scofftestCategory = "";

  Future getPHQ9TestData() async {
    await FirebaseFirestore.instance
        .collection(" psychologiqueTests")
        .doc("test_PHQ_9")
        .get()
        .then(
      (snapshot) async {
        if (mounted)
          setState(() {
            if (snapshot.exists) {
              setState(() {
                phq9testTitleABV = snapshot.data()!["titleABV"];
                phq9testTitle = snapshot.data()!["title"];
                phq9testDesc = snapshot.data()!["description"];
                phq9testCategory = snapshot.data()!["category"];
              });
            } else {}
          });
      },
    );
  }

  Future getGAD7TestData() async {
    await FirebaseFirestore.instance
        .collection(" psychologiqueTests")
        .doc("test_GAD_7")
        .get()
        .then(
      (snapshot) async {
        if (mounted)
          setState(() {
            if (snapshot.exists) {
              setState(() {
                gad7testTitleABV = snapshot.data()!["titleABV"];
                gad7testTitle = snapshot.data()!["title"];
                gad7testDesc = snapshot.data()!["description"];
                gad7testCategory = snapshot.data()!["category"];
              });
            } else {}
          });
      },
    );
  }

  Future getRosenbergTestData() async {
    await FirebaseFirestore.instance
        .collection(" psychologiqueTests")
        .doc("test_Rosenberg_Self-esteem_Scale")
        .get()
        .then(
      (snapshot) async {
        if (mounted)
          setState(() {
            if (snapshot.exists) {
              setState(() {
                rosenbergtestTitleABV = snapshot.data()!["titleABV"];
                rosenbergtestTitle = snapshot.data()!["title"];
                rosenbergtestDesc = snapshot.data()!["description"];
                rosenbergtestCategory = snapshot.data()!["category"];
              });
            } else {}
          });
      },
    );
  }

  Future getSCOFFTestData() async {
    await FirebaseFirestore.instance
        .collection(" psychologiqueTests")
        .doc("test_SCOFF_Questionnaire")
        .get()
        .then(
      (snapshot) async {
        if (mounted)
          setState(() {
            if (snapshot.exists) {
              setState(() {
                scofftestTitleABV = snapshot.data()!["titleABV"];
                scofftestTitle = snapshot.data()!["title"];
                scofftestDesc = snapshot.data()!["description"];
                scofftestCategory = snapshot.data()!["category"];
              });
            } else {}
          });
      },
    );
  }

  String? selectedCat;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      this.openDialog();
    });

    super.initState();
  }

  void openDialog() {
    if (oneTimeAlertManagement.dialogAppeared == false) {
      showDialog(
        context: context,
        builder: (context) => Padding(
          padding:
              const EdgeInsets.only(left: 30, right: 30, top: 205, bottom: 205),
          child: AlertDialog(
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                      'Os testes aqui presentes não apresentam resultados comprovados científica ou clinicamente.\n\nEstes não realizam um diagnóstico médico, sendo aconselhável consultar um profissional.',
                      style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
                child: TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.white),
                  child: Text('Fechar', style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ).then((value) => oneTimeAlertManagement.dialogAppeared = true);
    }
  }

  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    getPHQ9TestData();
    getGAD7TestData();
    getRosenbergTestData();
    getSCOFFTestData();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return HomeScreen();
              },
            ),
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 45),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 35.0),
                child: HeadingText(title: 'Bem vindo(a) aos,', subtitle: 'Testes Psicológicos', color: Colors.black, isTitleBold: false),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    decoration: new InputDecoration(
                      prefixIcon: Icon(
                        PhosphorIcons.magnifyingGlass,
                        color: Colors.grey,
                      ),
                      labelText: "Pesquisar por cateogrias ou testes... ",
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 15),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: const BorderSide(
                          color: Colors.white24,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.only(left: 35.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => testPHQ_9Screen(
                                      phq9testtitle: phq9testTitle!,
                                      phq9testtitleABV: phq9testTitleABV!,
                                      phq9testdescription: phq9testDesc!,
                                    )));
                          },
                          child: TransparentImageCard(
                            width: 150,
                            height: 170,
                            imageProvider:
                                AssetImage('assets/images/psychologuiqueTests/depression.jpg'),
                            title: Padding(
                              padding: const EdgeInsets.only(
                                  top: 0, left: 0, right: 20),
                              child: Text("PHQ-9",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                            ),
                            description: Container(
                              child: Text("Depressão",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      backgroundColor: Colors.black,
                                      fontSize: 12)),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => testGAD_7Screen(
                                      gad7testtitle: gad7testTitle!,
                                      gad7testtitleABV: gad7testTitleABV!,
                                      gad7testdescription: gad7testDesc!,
                                    )));
                          },
                          child: TransparentImageCard(
                            width: 150,
                            height: 170,
                            imageProvider:
                                AssetImage('assets/images/psychologuiqueTests/anxiety.jpg'),
                            title: Padding(
                              padding: const EdgeInsets.only(
                                  top: 0, left: 0, right: 20),
                              child: Text("GAD-7",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                            ),
                            description: Container(
                              child: Text("Ansiedade",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      backgroundColor: Colors.black,
                                      fontSize: 12)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 35.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => testSCOFFScreen(
                                      scofftesttitle: scofftestTitle!,
                                      scofftesttitleABV: scofftestTitleABV!,
                                      scofftestdescription: scofftestDesc!,
                                    )));
                          },
                          child: TransparentImageCard(
                            width: 150,
                            height: 170,
                            imageProvider:
                                AssetImage('assets/images/psychologuiqueTests/foodDisorder.jpg'),
                            title: Padding(
                              padding: const EdgeInsets.only(
                                  top: 0, left: 0, right: 20),
                              child: Text("SCOFF",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                            ),
                            description: Container(
                              child: Text("Comportamento Alimentar",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      backgroundColor: Colors.black,
                                      fontSize: 10)),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => testRosenbergScaleScreen(
                                      rosenbergtesttitle: rosenbergtestTitle!,
                                      rosenbergtesttitleABV:
                                          rosenbergtestTitleABV!,
                                      rosenbergtestdescription:
                                          rosenbergtestDesc!,
                                    )));
                          },
                          child: TransparentImageCard(
                            width: 150,
                            height: 170,
                            imageProvider:
                                AssetImage('assets/images/psychologuiqueTests/selfEsteem.jpg'),
                            title: Padding(
                              padding: const EdgeInsets.only(
                                  top: 0, left: 0, right: 20),
                              child: Text("Rosenberg Scale",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                            ),
                            description: Container(
                              child: Text("Auto-estima",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      backgroundColor: Colors.black,
                                      fontSize: 12)),
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
        height: 50.0,
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
