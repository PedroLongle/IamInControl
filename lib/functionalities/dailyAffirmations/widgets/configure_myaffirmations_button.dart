import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:project_i_am_in_control/functionalities/dailyAffirmations/screens/dailyAffirmationsMyAffirmations.dart';
class configureMyAffirmationsButton extends StatelessWidget {
  const configureMyAffirmationsButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: GestureDetector(
        onTap: (() {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const MyAffirmationsScreen()));
        }),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
              child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                'Configurar ',
                style: TextStyle(color: Colors.black),
              ),
              Icon(
                PhosphorIcons.slidersHorizontal,
                color: Colors.black,
                size: 18,
              ),
            ],
          )),
        ),
      ),
    );
  }
}
