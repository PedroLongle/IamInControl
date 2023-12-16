// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'userInfoScreen.dart';

class reAuth extends StatefulWidget {
  const reAuth({super.key});

  @override
  State<reAuth> createState() => _reAuthState();
}

class _reAuthState extends State<reAuth> {
  final _reAuthEmailController = TextEditingController();
  final _reAuthPasswordController = TextEditingController();

  Future reAuth() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _reAuthEmailController.text.trim(),
        password: _reAuthPasswordController.text.trim(),
      );
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            content: Text(
                'Identidade confirmada com sucesso.\nPode proceder à alteração das suas informações.'),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.white),
                child: Text('Proceder', style: TextStyle(color: Colors.black)),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => userUpdateInfoScreen(
                            
                          )));
                },
              ),
            ],
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.white,
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose() {
    _reAuthEmailController.dispose();
    _reAuthPasswordController.dispose();

    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child:
                            Text('Confirme a sua Identidade                   ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                )),
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                            'Para proceder à alteração das suas informações pessoais, é necessário confirmar a sua identidade.',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            )),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 35),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                      controller: _reAuthEmailController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(14),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.5, color: Colors.black),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Email',
                        fillColor: Colors.grey[200],
                        filled: true,
                      )),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                      controller: _reAuthPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(14),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.5, color: Colors.black),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Password',
                        fillColor: Colors.grey[200],
                        filled: true,
                      )),
                ),
                SizedBox(height: 35),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45),
                  child: GestureDetector(
                    onTap: (() {
                      reAuth();
                    }),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                          child: Text('Confirmar',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'antipastobold',
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ))),
                    ),
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ));
  }
}

class UserInfo {
  final String? fistName;
  final String? laststate;
  final String? email;

  UserInfo({
    this.fistName,
    this.laststate,
    this.email,
  });

  factory UserInfo.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserInfo(
      fistName: data?['first name'],
      laststate: data?['last name'],
      email: data?['email'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (fistName != null) "first name": fistName,
      if (laststate != null) "state": laststate,
      if (email != null) "country": email,
    };
  }
}

class userUpdateInfoScreen extends StatefulWidget {
  const userUpdateInfoScreen(
      {super.key,});

  @override
  State<userUpdateInfoScreen> createState() => _userUpdateInfoScreen();
}

class _userUpdateInfoScreen extends State<userUpdateInfoScreen> {
  final currentUser = FirebaseAuth.instance.currentUser;

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? userFirstName = '';
  String? userLastName = '';
  String? userEmail = '';
  String? userRegisterDate = '';

  String? updatedUserFirstName = '';
  String? updatedUserLastName = '';
  String? updatedUserEmail = '';

  Future getUserData() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
      (snapshot) async {
        if (snapshot.exists) {
          setState(() {
            userFirstName = snapshot.data()!["first name"];
            userLastName = snapshot.data()!["last name"];
            userEmail = snapshot.data()!["email"];
            userRegisterDate = snapshot.data()!["registerDate"];
          });
        }
      },
    );
  }

  Future updateUserData() async {
    final user = FirebaseAuth.instance.currentUser!;

    if (_firstNameController.text != "") {
      updatedUserFirstName = _firstNameController.text.trim();
    } else {
      updatedUserFirstName = userFirstName;
    }
    if (_lastNameController.text != "") {
      updatedUserLastName = _lastNameController.text.trim();
    } else {
      updatedUserLastName = userLastName;
    }

    if (_emailController.text != "") {
      updatedUserEmail = _emailController.text.trim();
    } else {
      updatedUserEmail = userEmail;
    }

    FirebaseFirestore.instance.collection('users').doc(user.uid).update({
      'email': updatedUserEmail,
      'first name': updatedUserFirstName,
      'last name': updatedUserLastName,
      'uid': user.uid
    });

    user.updateEmail(updatedUserEmail!);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  Widget build(BuildContext context) {
    getUserData();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => UserAccountScreen()));
          },
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Text(
            'Editar Informações',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.only(left: 8.0, top: 25),
                child: Column(children: [
                  SizedBox(height: 20),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 45),
                        child: Icon(PhosphorIcons.userCircle,
                            size: 100, color: Colors.black),
                      ),
                      SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.only(top: 110, bottom: 35),
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
                  SizedBox(height: 20),
                  Form(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: TextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[a-zA-Z]")),
                                LengthLimitingTextInputFormatter(20),
                              ],
                              controller: _firstNameController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(15),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.5, color: Colors.black),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                hintText: userFirstName,
                                fillColor: Colors.grey[200],
                                filled: true,
                              )),
                        ),
                        SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: TextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[a-zA-Z]")),
                                LengthLimitingTextInputFormatter(20),
                              ],
                              controller: _lastNameController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(15),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.5, color: Colors.black),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                hintText: userLastName,
                                fillColor: Colors.grey[200],
                                filled: true,
                              )),
                        ),
                        SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(15),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.5, color: Colors.black),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                hintText: userEmail,
                                fillColor: Colors.grey[200],
                                filled: true,
                              )),
                        ),
                        SizedBox(height: 75),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 65),
                          child: GestureDetector(
                            onTap: (() {
                              updateUserData();
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    surfaceTintColor: Colors.white,
                                    backgroundColor: Colors.white,
                                    content: Text(
                                        'Alterações realizadas com sucesso!\nSe procedeu à alteração do e-mail, execute o próximo login com o email atualizado.'),
                                    actions: <Widget>[
                                      TextButton(
                                        style: TextButton.styleFrom(
                                            backgroundColor: Colors.white),
                                        child: Text('Ok',
                                            style:
                                                TextStyle(color: Colors.black)),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UserAccountScreen()));
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                              ;
                            }),
                            child: Container(
                              padding: EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                  child: Text('Guardar Alterações',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'antipastobold',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ))),
                            ),
                          ),
                        ),
                        SizedBox(height: 70),
                      ],
                    ),
                  )
                ]))),
      ),
    );
  }
}
