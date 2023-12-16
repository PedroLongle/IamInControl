import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:project_i_am_in_control/functionalities/dailyAffirmations/screens/manageNotifications.dart';

class manageNotificationsButton extends StatelessWidget {
  const manageNotificationsButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
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
              Text(
                'Gerir Notificações  ',
                style: TextStyle(color: Colors.white),
              ),
              Icon(
                PhosphorIcons.bellRinging,
                color: Colors.white,
                size: 18,
              ),
            ],
          )),
        ),
      ),
    );
  }
}
