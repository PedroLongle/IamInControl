import 'package:flutter/material.dart';

import '../../../config/appLocalizations/appLocalizations.dart';

Future<void> openErrorDialog(context,String errorMessage, [bool barrierDismissible = false]) {
  return showDialog<void>(
    context: context,
    barrierDismissible: barrierDismissible ? false : true,
    builder: (BuildContext context) {
      return ErrorDialog(errorMessage: errorMessage);
    },
  );
}

class ErrorDialog extends StatefulWidget {
  final String errorMessage;
  const ErrorDialog(
      {Key? key, required this.errorMessage})
      : super(key: key);

  @override
  State<ErrorDialog> createState() => _ErrorDialogState();
}

class _ErrorDialogState extends State<ErrorDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      content: Container(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 10.0, top: 8.0, left: 2.0),
                    child: Text(
                      AppLocalization.of(context).translate('errorDialog.title'),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                          fontFamily: 'lato'),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Text(
                        widget.errorMessage,
                        style: TextStyle(
                            color: Colors.black, fontSize: 14, fontFamily: 'lato'),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
            style: TextButton.styleFrom(backgroundColor: Colors.white),
            child: Text('Fechar',
                style: TextStyle(color: Colors.red, fontSize: 12)),
            onPressed: () {
              Navigator.of(context).pop();
              return;
            }),
      ],
    );
  }
}
