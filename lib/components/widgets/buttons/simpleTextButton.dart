


import 'package:flutter/material.dart';

class SimpleTextButton extends StatelessWidget {
  const SimpleTextButton(
      {Key? key,
      required this.onTap,
      required this.isLoading,
      required this.text,
      })
      : super(key: key);

  final VoidCallback onTap;
  final bool isLoading;
  final String text;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.white),
                child: Text('Confirmar',
                    style: TextStyle(
                      color: Colors.black,
                    )),
                onPressed: onTap,
              )
        : TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.white),
                child: Text('Confirmar',
                    style: TextStyle(
                      color: Colors.black,
                    )),
                onPressed: onTap
              );
  }
}
/*
{
                  setState(() {
                    isLoading = true;
                  });
                  addCurrentUserAddiction(
                      dropdownValueAddictions,
                      formattedDate,
                      _timeOfDay.format(context).toString(),
                      dropdownValueReasons);
                  Navigator.of(context).pop();
                },*/