// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:project_i_am_in_control/functionalities/homePage/screens/homeScreen.dart';

import 'userDeleteScreen.dart';

class UserAccountScreen extends StatefulWidget {
  const UserAccountScreen({super.key});

  @override
  State<UserAccountScreen> createState() => _UserAccountScreenState();
}

class _UserAccountScreenState extends State<UserAccountScreen> {
  final currentUser = FirebaseAuth.instance.currentUser;

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();

  String? userFirstName = '';
  String? userLastName = '';
  String? userEmail = '';
  String? userRegisterDate = '';

  Future getUserData() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
      (snapshot) async {
        if (mounted)
          setState(() {
            if (snapshot.exists) {
              setState(() {
                userFirstName = snapshot.data()!["first name"];
                userLastName = snapshot.data()!["last name"];
                userEmail = snapshot.data()!["email"];
                userRegisterDate = snapshot.data()!["registerDate"];
              });
            }
          });
      },
    );
  }

  Future FillTextBoxes() async {
    _firstNameController.text = userFirstName!;
    _lastNameController.text = userLastName!;
    _emailController.text = userEmail!;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();

    super.dispose();
  }

  Widget build(BuildContext context) {
    getUserData();
    FillTextBoxes();

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
          padding: const EdgeInsets.only(left: 60.0),
          child: Text(
            'A minha Conta',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              SizedBox(height: 20),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 45),
                    child: Icon(PhosphorIcons.userCircle,
                        size: 120, color: Colors.black),
                  ),
                  SizedBox(height: 1),
                  Padding(
                    padding: const EdgeInsets.only(top: 120, bottom: 35),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 45),
                      child: Text(userFirstName! + " " + userLastName!,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'antipastobold',
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          )),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: ListTile(
                  tileColor: Colors.grey[100],
                  leading: Icon(PhosphorIcons.userCircle, size: 25),
                  title: Text('Informações Pessoais'),
                  titleTextStyle:
                      TextStyle(fontSize: 13, color: Colors.grey[700]),
                  trailing: Icon(PhosphorIcons.arrowRight, size: 25),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 2, color: Colors.white),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: ListTile(
                  tileColor: Colors.grey[100],
                  leading: Icon(PhosphorIcons.eyeSlash, size: 25),
                  title: Text('Alterar Password'),
                  titleTextStyle:
                      TextStyle(fontSize: 13, color: Colors.grey[700]),
                  trailing: Icon(PhosphorIcons.arrowRight),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 2, color: Colors.white),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: ListTile(
                  tileColor: Colors.grey[100],
                  leading: Icon(PhosphorIcons.userCircle, size: 25),
                  title: Text('Estatísticas do utilizador'),
                  titleTextStyle:
                      TextStyle(fontSize: 13, color: Colors.grey[700]),
                  trailing: Icon(
                    PhosphorIcons.arrowRight,
                    size: 25,
                  ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 2, color: Colors.white),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: ListTile(
                  tileColor: Colors.grey[100],
                  leading: Icon(PhosphorIcons.trash, size: 25),
                  title: Text('Apagar Conta'),
                  titleTextStyle:
                      TextStyle(fontSize: 14, color: Colors.grey[700]),
                  trailing: Icon(
                    PhosphorIcons.arrowRight,
                    size: 25,
                  ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 2, color: Colors.white),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              SizedBox(height: 75),
              Padding(
                padding: const EdgeInsets.only(left: 45.0, bottom: 20),
                child: Row(
                  children: [
                    Text.rich(TextSpan(
                        text: 'Aderiu a\n',
                        style: TextStyle(fontSize: 15),
                        children: [
                          TextSpan(
                              text: userRegisterDate,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                        ])),
                    SizedBox(width: 40),
                    GestureDetector(
                      onTap: (() {
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const userDeleteScreen()));
                      }),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 0,
                        ),
                        child: Container(
                          width: 110,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Center(
                              child: Text('Apagar Conta',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'antipastobold',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ))),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
