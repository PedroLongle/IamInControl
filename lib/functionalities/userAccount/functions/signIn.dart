import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_i_am_in_control/components/widgets/dialogs/errorDialog.dart';
import 'package:project_i_am_in_control/config/sharedPreferences/sharedPreferences.dart';

import '../../../config/appLocalizations/appLocalizations.dart';

Future FirebaseSignIn(context, String email, String password, Widget onSucessRedirect) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
      content: Text(AppLocalization.of(context).translate('signIn.Success')), 
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
      case 'invalid-email':
        openErrorDialog(context,
            AppLocalization.of(context).translate('signIn.InvalidEmail'));
        break;
      case 'user-disabled':
        openErrorDialog(context,
            AppLocalization.of(context).translate('signIn.UserDisabled'));
        break;
      case 'user-not-found':
        openErrorDialog(context,
            AppLocalization.of(context).translate('signIn.UserNotFound'));
        break;
      case 'wrong-password':
        openErrorDialog(context,
            AppLocalization.of(context).translate('signIn.WrongPassword'));
        break;
    }
  }
}
