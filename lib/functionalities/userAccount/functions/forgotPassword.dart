import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_i_am_in_control/components/widgets/dialogs/errorDialog.dart';
import 'package:project_i_am_in_control/functionalities/userAccount/dialogs/loginDialog.dart';

import '../../../config/appLocalizations/appLocalizations.dart';

Future FirebaseForgotPassword(context, String email) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(
      email: email.trim(),
    );
    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
      content:Text(AppLocalization.of(context).translate('forgotPassword.Success')), 
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.symmetric(vertical: 20.0),
      duration: Duration(milliseconds: 3000),
    ));
    Navigator.of(context).pop();
    openLoginDialog(context);
  } on FirebaseAuthException catch (error) {
    switch (error.code) {
      case 'invalid-email':
        openErrorDialog(context,
            AppLocalization.of(context).translate('forgotPassword.InvalidEmail'));
        break;
      case 'user-not-found':
        openErrorDialog(context,
            AppLocalization.of(context).translate('forgotPassword.UserNotFound'));
        break;
      default: openErrorDialog(context, AppLocalization.of(context).translate('forgotPassword.InternalError')); break;
    }
  }
}
