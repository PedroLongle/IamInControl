import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/constants/constants.dart';

class AppSharedPreferences {
  static const String APP_LOCALE = "app_localization";

  Future<Locale> setLocale(String languageCode) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(APP_LOCALE, languageCode);
    return _locale(languageCode);
  }

  Future<Locale> getLocale() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String languageCode = _prefs.getString(APP_LOCALE) ?? ENGLISH;
    return _locale(languageCode);
  }

  Future<void> setUserLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('loggedIn', value);
  }
  Future<bool> isUserLoggedIn() async {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool('loggedIn') ?? false;
    }
}

Locale _locale(String languageCode) {
  Locale _tempLocale;
  switch (languageCode) {
    case ENGLISH:
      _tempLocale = Locale(languageCode, "US");
      break;
    case PORTUGUESE:
      _tempLocale = Locale(languageCode, "PT");
      break;
    default:
      _tempLocale = Locale(languageCode, "US");
  }
  return _tempLocale;
}
