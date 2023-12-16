import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'components/routes/routesHandler.dart';
import 'config/appLocalizations/appLocalizations.dart';
import 'config/firebase/firebase_options.dart';
import 'firstScreen.dart';
import 'functionalities/settings/notifiers/localeNotifier.dart';

void main() async {
  runApp(App());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
      overlays: [SystemUiOverlay.top]);
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocaleNotifier(),
      builder: (context, child) {
        final appLocaleProvider = Provider.of<LocaleNotifier>(context);
        return MaterialApp(
          theme: ThemeData(
            fontFamily: 'lato',
            useMaterial3: true,
          ),
          locale: appLocaleProvider.locale,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            AppLocalization.delegate
          ],
          supportedLocales: [
            Locale('en', 'EN'),
            Locale('pt', 'PT'),
          ],
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            for (var locale in supportedLocales) {
              if (locale.languageCode == deviceLocale!.languageCode &&
                  locale.countryCode == deviceLocale.countryCode) {
                return deviceLocale;
              }
            }
            return supportedLocales.first;
          },
          onGenerateRoute: generateRoute,
          home: FirstScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
