import 'dart:math';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:project_i_am_in_control/components/widgets/texts/blinkingText.dart';
import 'package:project_i_am_in_control/config/sharedPreferences/sharedPreferences.dart';
import 'functionalities/homePage/screens/homeScreen.dart';

import 'config/appLocalizations/appLocalizations.dart';
import 'functionalities/userAccount/dialogs/loginDialog.dart';

class FirstScreen extends StatefulWidget {
  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  bool isOpenLoginDialog = false;
  late bool isLoggedStatus;

  getLoggedInState() async {
    await AppSharedPreferences().isUserLoggedIn().then((value) {
      setState(() => isLoggedStatus = value );
    });
  }

  onOpenLoginDialog() => setState(() => isOpenLoginDialog = true);
  
  @override
  Widget build(BuildContext context) {
    getLoggedInState();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: ClippedPartsWidget(
          top: Container(
              color: Colors.white,
              child: Container(
                  color: Colors.white,
                  child: isOpenLoginDialog
                      ? Column()
                      : Column(
                          children: [
                            Center(
                              child: Padding(
                              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.115),
                              child: Column(
                                children: [
                                  Text(
                                    'I am in',
                                    style: TextStyle(
                                      fontSize: 75,
                                      color: Colors.black,
                                      fontFamily: 'tommy',
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.010),
                                    child: Text(
                                      'Control',
                                      style: TextStyle(
                                        fontSize: 75,
                                        color: Colors.black,
                                        fontFamily: 'tommy',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                          ],
                        ))),
          bottom: InkWell(
              child: Container(
                  color: Colors.white,
                  child: Container(
                    color: Colors.black,
                    child: Center(
                      child: isOpenLoginDialog
                          ?  Text('') 
                          :  Padding(
                             padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.700),
                            child: BlinkText(
                                text: AppLocalization.of(context).translate('touchAwait'),
                                hasIcon: true,
                                icon: Icon(PhosphorIcons.handPointing,
                                    color: Colors.white, size: 25),
                                fontSize: 17,
                                color: Colors.white,
                                blinkDuration: 1),
                          )
                    ),
                  )),
              onTap: () {
                isLoggedStatus
                    ? Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()))
                    : openLoginDialog(context); onOpenLoginDialog();
              }),
          splitFunction: (Size size, double x) {
            final normalizedX = x / size.width * 2 * pi;
            final waveHeight = size.height / 15;
            final y = size.height / 2 - sin(normalizedX) * waveHeight;

            return y;
          },
        ));
  }
}

class ClippedPartsWidget extends StatelessWidget {
  final Widget top;
  final Widget bottom;
  final double Function(Size, double) splitFunction;

  ClippedPartsWidget({
    required this.top,
    required this.bottom,
    required this.splitFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        top,
        Align(
          alignment: Alignment.bottomCenter,
          child: ClipPath(
            clipper: FunctionClipper(splitFunction: splitFunction),
            child: bottom,
          ),
        ),
      ],
    );
  }
}

class FunctionClipper extends CustomClipper<Path> {
  final double Function(Size, double) splitFunction;

  FunctionClipper({required this.splitFunction}) : super();

  Path getClip(Size size) {
    final path = Path();

    path.moveTo(0, splitFunction(size, 0));

    for (double x = 1; x <= size.width; x++) {
      path.lineTo(x, splitFunction(size, x));
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
