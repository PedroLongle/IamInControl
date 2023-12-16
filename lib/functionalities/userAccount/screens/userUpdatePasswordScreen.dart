// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../firstScreen.dart';

class userUpdateCredentialsScreen extends StatefulWidget {
  const userUpdateCredentialsScreen({super.key});

  @override
  State<userUpdateCredentialsScreen> createState() => _userUpdateCredentialsScreenState();
}

class _userUpdateCredentialsScreenState extends State<userUpdateCredentialsScreen> {
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
                'Identidade confirmada com sucesso.\nPode proceder à alteração da sua palvra-passe.'),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.white),
                child: Text('Proceder', style: TextStyle(color: Colors.black)),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => changePasswordScreen(
                            userEmail: _reAuthEmailController.text.trim(),
                            userPassword: _reAuthPasswordController.text.trim(),
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
          title: Padding(
            padding: const EdgeInsets.only(left: 35.0),
            child: Text(
              'Alterar Palavra-Passe',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
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
                            'Para proceder à alteração da sua palavra-passe, é necessário confirmar a sua identidade.',
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
                  padding: const EdgeInsets.symmetric(horizontal: 25),
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

class changePasswordScreen extends StatelessWidget {
  String userEmail, userPassword;
  changePasswordScreen(
      {super.key, required this.userEmail, required this.userPassword});

  final currentUser = FirebaseAuth.instance.currentUser;

  final _newPasswordController = TextEditingController();
  final _newConfirPasswordController = TextEditingController();

  Future changePassword() async {
    try {
      String newPassword = _newConfirPasswordController.text.trim();

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: userEmail, password: userPassword);

      await currentUser!.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      return AlertDialog(
        surfaceTintColor: Colors.white,
                    backgroundColor: Colors.white,
        content: Text(e.message.toString()),
      );
    }
  }

  
  void dispose() {
    _newPasswordController.dispose();
    _newConfirPasswordController.dispose();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Text(
              'Alterar Palavra-Passe',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text('Digite a sua nova palavra-passe      ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            )),
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
                SizedBox(height: 2),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                      obscureText: true,
                      controller: _newPasswordController,
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
                        hintText: 'Password',
                        fillColor: Colors.grey[200],
                        filled: true,
                      )),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                      controller: _newConfirPasswordController,
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
                        hintText: 'Confirm Password',
                        fillColor: Colors.grey[200],
                        filled: true,
                      )),
                ),
                SizedBox(height: 35),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: GestureDetector(
                    onTap: (() {
                      if (_newPasswordController.text.trim() ==
                          _newConfirPasswordController.text.trim()) {
                        try {
                          changePassword();

                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                surfaceTintColor: Colors.white,
                                backgroundColor: Colors.white,
                                content: Text(
                                    'A sua password foi atualizada com sucesso!\nDeverá executar login com a sua nova password.'),
                                actions: <Widget>[
                                  TextButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.white),
                                    child: Text('Entendi',
                                        style: TextStyle(color: Colors.black)),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FirstScreen()));
                                      FirebaseAuth.instance.signOut();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        } on FirebaseAuthException {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                surfaceTintColor: Colors.white,
                    backgroundColor: Colors.white,
                                content: Text('Ocorreu um erro.'),
                                actions: <Widget>[
                                  TextButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.white),
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
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              surfaceTintColor: Colors.white,
                    backgroundColor: Colors.white,
                              content: Text('As passwords não correspondem!'),
                              actions: <Widget>[
                                TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.white),
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
                    }),
                    child: Container(
                      padding: EdgeInsets.all(13),
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
                                fontSize: 18,
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
@override
Widget build(BuildContext context) {
  return Container();
}
