import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../homePage/screens/homeScreen.dart';
import 'package:project_i_am_in_control/functionalities/userPersonalDiary/screens/userPersonalDiary.dart';

class UserPersonalDiaryLoginScreen extends StatefulWidget {
  const UserPersonalDiaryLoginScreen({super.key});

  @override
  State<UserPersonalDiaryLoginScreen> createState() => _UserPersonalDiaryLoginScreenState();
}

class _UserPersonalDiaryLoginScreenState extends State<UserPersonalDiaryLoginScreen> {
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
            content: Text('Identidade confirmada com sucesso.'),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.white),
                child: Text('Avançar', style: TextStyle(color: Colors.black)),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UserPersonalDiaryScreen()));
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
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              }),
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
                        padding: const EdgeInsets.only(left: 5.0, top: 30),
                        child: Center(
                            child: Icon(
                          PhosphorIcons.bookBookmarkBold,
                          color: Colors.black,
                          size: 80,
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Center(
                          child: Text('O meu Diário Pessoal',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 26,
                              )),
                        ),
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
                SizedBox(height: 45),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45.0),
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
                  padding: const EdgeInsets.symmetric(horizontal: 45.0),
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
                      width: 180,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                          child: Text('Entrar',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'antipastobold',
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ))),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 30.0, top: 120, right: 35),
                  child: Text(
                      'Para aceder ao conteúdo do seu diário pessoal, é necessário confirmar a sua identidade.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 15,
                      )),
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ));
  }
}
