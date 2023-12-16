import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:project_i_am_in_control/functionalities/dailyAffirmations/screens/manageNotifications.dart';

class ReloadAffirmationsButton extends StatelessWidget {
  const ReloadAffirmationsButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: GestureDetector(
        onTap: (() {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const manageNotificationsScreen()));
        }),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
              child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Icon(
                PhosphorIcons.arrowCounterClockwise,
                color: Colors.white,
                size: 15,
              ),
            ],
          )),
        ),
      ),
    );
  }
}
