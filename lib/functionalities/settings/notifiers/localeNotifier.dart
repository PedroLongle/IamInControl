import 'package:flutter/cupertino.dart';

import '../../../config/sharedPreferences/sharedPreferences.dart';

class LocaleNotifier extends ChangeNotifier {
  LocaleNotifier() {
    initLocale();
  }

  initLocale() async {
    Locale appLocale = await AppSharedPreferences().getLocale();
    _locale = appLocale;
    notifyListeners();
  }

  late Locale _locale = Locale("en");

  Locale get locale => _locale;

  void setLocale(Locale locale) async {
    _locale = locale;
    await AppSharedPreferences().setLocale(locale.languageCode);
    notifyListeners();
  }
}