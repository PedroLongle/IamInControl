import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:project_i_am_in_control/components/widgets/dialogs/errorDialog.dart';
import 'package:project_i_am_in_control/config/sharedPreferences/sharedPreferences.dart';

import '../../../config/appLocalizations/appLocalizations.dart';

Future addUserDetails(
  context,
  String firstName,
  String lastName,
  String email,
  String avatarIconRef
) async {
  final user = FirebaseAuth.instance.currentUser!;
  try {
    Jiffy.setLocale('pt_br');
    var jiffyNow = Jiffy.now();

    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'first name': firstName,
      'last name': lastName,
      'email': email,
      'uid': user.uid,
      'registerDate': jiffyNow.yMMMMd,
      'avatarIconRef': avatarIconRef
    });
  // ignore: unused_catch_clause
  } on FirebaseException catch (error) {
    openErrorDialog(
        context, AppLocalization.of(context).translate('signUp.databaseError'));
    user.delete();
  }
}

Future FirebaseSignUp(context, String firstName, String lastName, String email,
    String password, String avatarIconRef, Widget onSucessRedirect) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(), password: password.trim());
    await addUserDetails(context, firstName, lastName, email, avatarIconRef);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(AppLocalization.of(context).translate('singUp.Success')), 
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.symmetric(vertical: 20.0),
      duration: Duration(milliseconds: 2000),
    ));
    AppSharedPreferences().setUserLoggedIn(true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return onSucessRedirect;
        },
      ),
    );
  } on FirebaseAuthException catch (error) {
    switch (error.code) {
      case 'email-already-in-use':
        openErrorDialog(context,
            AppLocalization.of(context).translate('signUp.EmailAlreadyInUse'));
        break;
      case 'invalid-email':
        openErrorDialog(context,
            AppLocalization.of(context).translate('signUp.InvalidEmail'));
        break;
      case 'operation-not-allowed':
        openErrorDialog(
            context,
            AppLocalization.of(context)
                .translate('signUp.operationNotAllowed'));
        break;
      case 'weak-password':
        openErrorDialog(context,
            AppLocalization.of(context).translate('signUp.weakPassword'));
        break;
    }
  }
}
