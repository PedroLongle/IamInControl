import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_i_am_in_control/components/widgets/dialogs/generalDialog.dart';

Future deleteUserAccount(String userReEmail, String userRepassword) async {
  final currentUser = FirebaseAuth.instance.currentUser;
  String finalMessage = 'Conta eliminada com sucesso';
  try {
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userReEmail, password: userRepassword);

    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .delete();

    var collection = FirebaseFirestore.instance
        .collection("userAddictions")
        .doc('users')
        .collection(FirebaseAuth.instance.currentUser!.uid);
        
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }

    currentUser?.delete();
  } finally {
    return openGeneralAlertDialog(context, Text(finalMessage));
  }
}
