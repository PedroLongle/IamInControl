import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class DropdownInput extends StatefulWidget {
  final List<String> options;

  const DropdownInput(
      {Key? key, required this.options})
      : super(key: key);

  @override
  State<DropdownInput> createState() => _DropdownInputState();
}

class _DropdownInputState extends State<DropdownInput> {
  @override
  Widget build(BuildContext context) {
   String dropDownValue = widget.options.first;
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 0, bottom: 0),
      child: DropdownButton<String>(
        value: dropDownValue,
        icon: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: const Icon(
            PhosphorIcons.arrowDownBold,
            size: 18,
            color: Colors.black,
          ),
        ),
        elevation: 1,
        style: const TextStyle(color: Colors.black),
        underline: Container(
          height: 1.5,
          color: Colors.black,
        ),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropDownValue = value!;
          });
        },
        items: widget.options.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            
            value: value,
            child: Text(value), //style options
          );
        }).toList(),
      ),
    );
  }
}
