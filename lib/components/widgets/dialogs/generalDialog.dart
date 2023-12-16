import 'package:flutter/material.dart';

Future<void> openGeneralAlertDialog(context, child, [bool barrierDismissible = false]) {
  return showDialog<void>(
        barrierDismissible: barrierDismissible ? false : true,
    context: context,
    builder: (BuildContext context) {
      return GeneralAlertDialog(child: child);
    },
  );
}


class GeneralAlertDialog extends StatefulWidget {
  final Widget child;
  final EdgeInsets? contentPadding;
  final Color? surfaceTintColor;
  final Color? backgroundColor;

  const GeneralAlertDialog({
    Key? key,
    required this.child,
    this.surfaceTintColor = Colors.white,
    this.backgroundColor = Colors.white,
    this.contentPadding
  }) : super(key: key);

  @override
  State<GeneralAlertDialog> createState() => _GeneralAlertDialogState();
}



class _GeneralAlertDialogState extends State<GeneralAlertDialog> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: widget.surfaceTintColor,
      backgroundColor: widget.backgroundColor,
      content: Container(
        child: Padding(
          padding: widget.contentPadding != null ? const EdgeInsets.all(0) : EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
                widget.child
            ],
          ),
        ),
      )
      );
  }
}

// Seguir este modelo para aplicar os estilos opcionais.