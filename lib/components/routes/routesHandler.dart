import 'package:flutter/material.dart';
import 'package:project_i_am_in_control/functionalities/checkUpLists/screens/checkUpLists.dart';
import 'package:project_i_am_in_control/functionalities/dailyAffirmations/screens/dailyAffirmations.dart';
import 'package:project_i_am_in_control/functionalities/settings/screens/settings.dart';
import 'package:project_i_am_in_control/functionalities/userAccount/screens/userInfoScreen.dart';
import 'package:project_i_am_in_control/functionalities/userGoals/screens/userGoals.dart';
import 'package:project_i_am_in_control/functionalities/psychologuiqueTests/screens/psychologuiqueTests.dart';
import 'package:project_i_am_in_control/functionalities/leaveAddictions/screens/leaveAddictions.dart';
import 'package:project_i_am_in_control/functionalities/sleepHabits/screens/sleepHabits.dart';

import 'routes.dart';
import '../../functionalities/homePage/screens/homeScreen.dart';
import '../../functionalities/userPersonalDiary/screens/userPersonalDiaryLogin.dart';



Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.home:
      return _getPageRoute(
        routeName: settings.name!,
        screen: const HomeScreen(),
        transitionType: PageTransitionType.leftToRight //definir aqui a transição
      );
       case Routes.psychologuiqueTests:
      return _getPageRoute(
        routeName: settings.name!,
        screen: const PsychologuiqueTestsScreen(),
        transitionType: PageTransitionType.leftToRight 
      );
      case Routes.checkUpLists:
      return _getPageRoute(
        routeName: settings.name!,
        screen: const CheckUpListsScreen(),
        transitionType: PageTransitionType.leftToRight 
      );
      case Routes.leaveAddictions:
      return _getPageRoute(
        routeName: settings.name!,
        screen: const LeaveAddictionsScreen(),
        transitionType: PageTransitionType.leftToRight 
      );
      case Routes.dailyAffirmations:
      return _getPageRoute(
        routeName: settings.name!,
        screen: const DailyAffirmationsScreen(),
        transitionType: PageTransitionType.leftToRight 
      );
      case Routes.sleepHabits:
      return _getPageRoute(
        routeName: settings.name!,
        screen: const SleepHabitsScreen(),
        transitionType: PageTransitionType.leftToRight 
      );
      case Routes.userGoals:
      return _getPageRoute(
        routeName: settings.name!,
        screen: const UserGoalsScreen(),
        transitionType: PageTransitionType.leftToRight 
      );
      case Routes.userPersonalDiary:
      return _getPageRoute(
        routeName: settings.name!,
        screen: const UserPersonalDiaryLoginScreen(),
        transitionType: PageTransitionType.leftToRight 
      );
      case Routes.userAccount:
      return _getPageRoute(
        routeName: settings.name!,
        screen: const UserAccountScreen(),
        transitionType: PageTransitionType.leftToRight 
      );
      case Routes.settings:
      return _getPageRoute(
        routeName: settings.name!,
        screen: const SettingsScreen(),
        transitionType: PageTransitionType.leftToRight 
      );
      
      /*
    case Routes.fourth:
      final args = settings.arguments! as String;
      return _getPageRoute(
        routeName: settings.name!,
        screen: FouthScreen(params: args),
      );
      
      !!Para o caso de um screen com paramtros, este "params: args" é uma string required como parametro do screen.
      */
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No Route defined for ${settings.name}'),
          ),
        ),
      );
  }
}

PageRoute _getPageRoute({
  required String routeName,
  required Widget screen,
  required PageTransitionType transitionType,
}) {
  return PageTransition(
    child: screen,
    type: transitionType,
  );
}

enum PageTransitionType {
  fade,
  rightToLeft,
  leftToRight,
  upToDown,
  downToUp,
  scale,
  rotate,
  size,
  rightToLeftWithFade,
  leftToRightWithFade,
}

class PageTransition extends PageRouteBuilder {
  final Widget child;
  final PageTransitionType type;
  final Curve curve;
  final Alignment alignment;
  final Duration duration;

  PageTransition({
    required this.child,
    this.type = PageTransitionType.rightToLeft,
    this.curve = Curves.linear,
    this.alignment = Alignment.center,
    this.duration = const Duration(milliseconds: 300),
  }) : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return child;
          },
          transitionDuration: duration,
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            switch (type) {
              case PageTransitionType.fade:
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              case PageTransitionType.rightToLeft:
                return SlideTransition(
                  transformHitTests: false,
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset.zero,
                      end: const Offset(-1.0, 0.0),
                    ).animate(secondaryAnimation),
                    child: child,
                  ),
                );

              case PageTransitionType.downToUp:
                return SlideTransition(
                  transformHitTests: false,
                  position: Tween<Offset>(
                    begin: const Offset(0.0, 1.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset.zero,
                      end: const Offset(0.0, -1.0),
                    ).animate(secondaryAnimation),
                    child: child,
                  ),
                );

              case PageTransitionType.rightToLeftWithFade:
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset.zero,
                        end: const Offset(-1.0, 0.0),
                      ).animate(secondaryAnimation),
                      child: child,
                    ),
                  ),
                );

              default:
                return FadeTransition(opacity: animation, child: child);
            }
          },
        );
}