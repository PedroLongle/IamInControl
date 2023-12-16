import 'package:flutter/material.dart';

class CheckboxWithLabel extends StatelessWidget {
  final bool? value;
  final ValueChanged<bool?>? onChanged;
  final Widget label;

  const CheckboxWithLabel({
    Key? key,
    required this.value,
    this.onChanged,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28,
      child: GestureDetector(
        onTap: () => onChanged?.call(value),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Transform.scale(
              scale: 0.7,
              child: Checkbox(
                fillColor: MaterialStateProperty.resolveWith((states) {
                  if (!states.contains(MaterialState.selected)) {
                    return Colors.black;
                  }
                  return Colors.green;
                }),
                checkColor: Colors.white,
                value: value,
                onChanged: onChanged,
              ),
            ),
            Row(
              children: [
                label,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
