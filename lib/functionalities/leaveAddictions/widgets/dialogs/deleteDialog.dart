import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> openDeleteDialog(context, String adictionCode) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return DeleteDialog(
          adictionCode: adictionCode,
        );
      },
    );
  }
class DeleteDialog extends StatefulWidget {
  final String adictionCode;

  const DeleteDialog({
    Key? key,
    required this.adictionCode,
  }) : super(key: key);

  @override
  State<DeleteDialog> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      content: Text("Tem a certeza que pretende eliminar este registo?"),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(backgroundColor: Colors.white),
          child: Text('Cancelar', style: TextStyle(color: Colors.black)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(backgroundColor: Colors.white),
          child: Text('Confirmar', style: TextStyle(color: Colors.red)),
          onPressed: () {
            Navigator.of(context).pop();
            FirebaseFirestore.instance
                .collection('userAddictions')
                .doc('users')
                .collection(user.uid)
                .doc(widget.adictionCode)
                .delete();
          },
        ),
      ],
    );
  }
}
