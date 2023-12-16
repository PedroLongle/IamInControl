import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../homePage/screens/homeScreen.dart';
import 'package:provider/provider.dart';

import '../models/language.dart';
import '../notifiers/localeNotifier.dart';
import '../../../config/sharedPreferences/sharedPreferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenScreenState();
}

class _SettingsScreenScreenState extends State<SettingsScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void _changeLanguage(Language language, context) async {
    Locale _selectedLocale =
        await AppSharedPreferences().setLocale(language.languageCode);

    final appLocaleProvider =
        Provider.of<LocaleNotifier>(context, listen: false);

    appLocaleProvider.setLocale(_selectedLocale);
  }

  List<String> reasonList = <String>[
    'Custo Monetário',
    'Consumo de Tempo',
    'É mau para mim'
  ];

  @override
  void dispose() {
    super.dispose();
  }

  String getCurrentUserUid() {
    final user = _auth.currentUser;
    if (user != null) {
      print(user.uid);
      return user.uid;
    } else {
      return 'sem id';
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return HomeScreen();
                  },
                ),
              );
            }),
        title: Padding(
          padding: const EdgeInsets.only(left: 45.0),
          child: Text(
            '',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              Wrap(
                  children: Language.languageList()
                      .map(
                        (language) => Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: ElevatedButton(
                            onPressed: () {
                              _changeLanguage(language, context);
                            },
                            child: Text("${language.name} ${language.flag}"),
                          ),
                        ),
                      )
                      .toList()),
                      SizedBox(height: 30),
              SizedBox(height: 30),
              

            ],
          ),
        ),
      ),
    );
  }
}
