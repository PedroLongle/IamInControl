// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_i_am_in_control/functionalities/checkUpLists/screens/checkUpLists.dart';
import 'package:project_i_am_in_control/functionalities/homePage/widgets/drawer.dart';
import 'package:project_i_am_in_control/loadingScreen/loadingScreen.dart';
import 'package:project_i_am_in_control/functionalities/userGoals/screens/userGoals.dart';
import 'package:project_i_am_in_control/functionalities/sleepHabits/screens/sleepHabits.dart';
import 'package:project_i_am_in_control/functionalities/leaveAddictions/screens/leaveAddictions.dart';
import 'package:project_i_am_in_control/functionalities/dailyAffirmations/screens/dailyAffirmations.dart';
import 'package:project_i_am_in_control/components/widgets/cards/shadowImageCard.dart';
import '../../../config/appLocalizations/appLocalizations.dart';
import '../../userPersonalDiary/screens/userPersonalDiaryLogin.dart';
import '../../../components/widgets/texts/headingText.dart';
import '../../psychologuiqueTests/screens/psychologuiqueTests.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  String pathPDF = '';

  String? userFirstName = '';
  String? userLastName = '';
  String? userAvatarIconRef = '';

  String welcomeMessage = '';

  bool _isLoading = true;

  Future getUserData() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
      (snapshot) async {
        if (mounted)
          setState(() {
            if (snapshot.exists) {
              setState(() {
                userFirstName = snapshot.data()!["first name"];
                userLastName = snapshot.data()!["last name"];
                userAvatarIconRef = snapshot.data()!["avatarIconRef"];
                _isLoading = false;
              });
            }
          });
      },
    );
    return Future(() => '');
  }

  String setWelcomeMessage() {
    var hour = DateTime.now().hour;
    if (hour <= 11 && hour > 4) {
      setState(() {
        welcomeMessage = AppLocalization.of(context).translate('goodMorning');
      });
    } else if (hour >= 12 && hour <= 18) {
      setState(() {
        welcomeMessage = AppLocalization.of(context).translate('goodAfternoon');
      });
    } else if (hour > 18) {
      setState(() {
        welcomeMessage = AppLocalization.of(context).translate('goodNight');
      });
    } else {
      setState(() {
        welcomeMessage = AppLocalization.of(context).translate('hello');
      });
    }
    return '';
  }

  @override
  void initState() {
    super.initState();
    fromAsset('assets/documents/userManual/IamInControl_ManualdeUtilizador.pdf',
            'IamInControl_ManualdeUtilizador.pdf')
        .then((f) {
      setState(() {
        pathPDF = f.path;
      });
      getUserData().then((value) => setWelcomeMessage());
    });
  }

  Future<File> fromAsset(String asset, String filename) async {
    Completer<File> completer = Completer();
    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        surfaceTintColor: Colors.white,
      ),
      drawer: homeDrawer(
        userFirstName: userFirstName,
        userLastName: userLastName,
        userAvatarIconRef: userAvatarIconRef!,
      ),
      body: _isLoading
          ? IsLoading(text: 'Estamos a preparar\ntudo para ti!', fontSize: 18)
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 40, bottom: 30, right: 15, top: 30),
                          child: HeadingText(
                            title: '$welcomeMessage, $userFirstName!',
                            subtitle: AppLocalization.of(context)
                                .translate('welcomeToMainMenu'),
                            isTitleBold: true,
                            color: Colors.black,
                          )),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 40, right: 40),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Column(
                                children: [
                                  ShadowImageCard(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PsychologuiqueTestsScreen()));
                                      },
                                      text: 'Testes Psicológicos',
                                      fontSize: 13,
                                      height: 150,
                                      width: 150,
                                      textColor: Colors.white,
                                      imageAsset:
                                          'assets/images/homeScreen/psychologuiqueTests.png'),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: ShadowImageCard(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CheckUpListsScreen()));
                                        },
                                        text: 'Listas de Check-up',
                                        fontSize: 13,
                                        height: 150,
                                        width: 150,
                                        textColor: Colors.white,
                                        imageAsset:
                                            'assets/images/homeScreen/checkUpLists.png'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20.0, bottom: 15),
                                    child: ShadowImageCard(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SleepHabitsScreen()));
                                      },
                                      text: "Hábitos de Sono",
                                      fontSize: 13,
                                      height: 350,
                                      width: 150,
                                      textColor: Colors.white,
                                      imageAsset:
                                          'assets/images/homeScreen/sleepHabits.png',
                                      contentPadding: const EdgeInsets.only(
                                          top: 210, left: 8),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20, top: 0),
                              child: Column(
                                children: [
                                  ShadowImageCard(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LeaveAddictionsScreen()));
                                      },
                                      text: "Abandonar Vícios",
                                      fontSize: 13,
                                      height: 360,
                                      width: 120,
                                      textColor: Colors.white,
                                      imageAsset:
                                          'assets/images/homeScreen/leaveAddictions.png',
                                      contentPadding: const EdgeInsets.only(
                                          top: 202, left: 8, right: 20)),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: ShadowImageCard(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UserGoalsScreen()));
                                      },
                                      text: "Objetivos",
                                      fontSize: 13,
                                      height: 150,
                                      width: 120,
                                      textColor: Colors.white,
                                      imageAsset:
                                          'assets/images/homeScreen/userGoals.png',
                                      contentPadding: const EdgeInsets.only(
                                          top: 12, left: 8),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, bottom: 10),
                                    child: ShadowImageCard(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UserPersonalDiaryLoginScreen()));
                                      },
                                      text: "Diário Pessoal",
                                      fontSize: 13,
                                      height: 150,
                                      width: 120,
                                      textColor: Colors.white,
                                      imageAsset:
                                          'assets/images/homeScreen/userPersonalDiary.png',
                                      contentPadding: const EdgeInsets.only(
                                          top: 12, left: 8),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, left: 40, right: 40, bottom: 50),
                            child: ShadowImageCard(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        DailyAffirmationsScreen()));
                              },
                              text: "Afirmações Diárias",
                              fontSize: 13,
                              height: 151,
                              width: 300,
                              textColor: Colors.white,
                              imageAsset:
                                  'assets/images/homeScreen/dailyAffirmations.png',
                              contentPadding:
                                  const EdgeInsets.only(top: 12, left: 8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
