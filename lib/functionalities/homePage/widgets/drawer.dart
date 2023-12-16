// ignore_for_file: division_optimization

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:project_i_am_in_control/config/appLocalizations/appLocalizations.dart';

import '../../../components/routes/routes.dart';
import '../../../config/routes/routesConfig.dart';
import '../../../config/sharedPreferences/sharedPreferences.dart';

import '../../../firstScreen.dart';

class homeDrawer extends StatefulWidget {
  final String? userFirstName;
  final String? userLastName;
  final String userAvatarIconRef;
  const homeDrawer(
      {Key? key, required this.userFirstName, required this.userLastName, required this.userAvatarIconRef})
      : super(key: key);

  @override
  _homeDrawerState createState() => _homeDrawerState();
}

class _homeDrawerState extends State<homeDrawer> {
  final user = FirebaseAuth.instance.currentUser!;

  bool isLoading = false;

  String showUserName(String? userFirstName, String? userLastName) {
    return widget.userFirstName!;
  }

  @override
  Widget build(BuildContext context) {
    Jiffy.setLocale('pt_br');
    var todayDate = Jiffy.now();
    return Drawer(
        backgroundColor: Colors.grey[100],
        width: 240,
        child: Container(
            color: Colors.white,
            child: ListView(
              children: [
                SizedBox(
                  height: 120,
                  child: DrawerHeader(
                    decoration: BoxDecoration(border: Border.all(width: 0, color: Colors.white)),
                    child: Row(
                      children: [
                        Container(
                          width: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 35),
                              Text(
                                showUserName(widget.userFirstName, widget.userLastName),
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900),
                              ),
                              Text(
                                todayDate.yMMMMd,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () => NavigationRoutes()
                                  .push(context, Routes.userAccount),
                              child: Image.asset(
                                widget.userAvatarIconRef,
                                width: 55,
                                height: 55,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                
                DrawerCategorieTitle(
                    itemText: AppLocalization.of(context).translate('mentalHealth')
                ),
                DrawerItem(
                  itemText: AppLocalization.of(context).translate('psychologuiqueTests'),
                  icon: PhosphorIcons.brainBold,
                  routeName: Routes.psychologuiqueTests,
                ),
                DrawerItem(
                  itemText: AppLocalization.of(context).translate('mainCheckUpLists'),
                  icon: PhosphorIcons.listChecksBold,
                  routeName: Routes.checkUpLists,
                ),
                DrawerItem(
                  itemText: AppLocalization.of(context).translate('leaveAddictions'),
                  icon: PhosphorIcons.circleWavyWarningBold,
                  routeName: Routes.leaveAddictions,
                ),
                 DrawerItem(
                  itemText: AppLocalization.of(context).translate('dailyAffirmations'),
                  icon: PhosphorIcons.calendarCheckBold,
                  routeName: Routes.dailyAffirmations,
                ),
                DrawerDivider(),
                DrawerCategorieTitle(
                    itemText: AppLocalization.of(context).translate('physicalHealth')
                ),
                DrawerItem(
                  itemText: AppLocalization.of(context).translate('sleepHabits'),
                  icon: PhosphorIcons.bedBold,
                  routeName: Routes.sleepHabits,
                ),
                DrawerDivider(),
                DrawerCategorieTitle(
                    itemText: AppLocalization.of(context).translate('organization')
                ),
                DrawerItem(
                  itemText: AppLocalization.of(context).translate('myGoals'),
                  icon: PhosphorIcons.targetBold,
                  routeName: Routes.userGoals,
                ),
                DrawerItem(
                  itemText: AppLocalization.of(context).translate('personalDiary'),
                  icon: PhosphorIcons.bookBookmarkBold,
                  routeName: Routes.userPersonalDiary,
                ),
                DrawerDivider(),
                DrawerCategorieTitle(
                    itemText: AppLocalization.of(context).translate('account')
                ),
                DrawerItem(
                  itemText: AppLocalization.of(context).translate('myAccount'),
                  icon: PhosphorIcons.userCircleBold,
                  routeName: Routes.settings,
                ),
                DrawerItem(
                  itemText: AppLocalization.of(context).translate('settings'),
                  icon: PhosphorIcons.gearBold,
                  routeName: Routes.userAccount,
                ),
                DrawerDivider(),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ListTile(
                    leading: Icon(PhosphorIcons.signOutBold,
                        size: 19, color: Colors.black),
                    title: Text(AppLocalization.of(context).translate('logOut'),
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            fontFamily: 'lato',
                            fontWeight: FontWeight.w500)),
                    onTap: () {
                      AppSharedPreferences().setUserLoggedIn(false); //adicionar dialog ao sair
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => FirstScreen()));
                    },
                  ),
                ),
              ],
            )));
  }
}

class DrawerDivider extends StatelessWidget {
  const DrawerDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Divider(
        height: 5,
        thickness: 0.5,
        indent: 10,
        endIndent: 10,
        color: Colors.grey[200],
      ),
    );
  }
}

class DrawerCategorieTitle extends StatelessWidget {
  final String itemText;
  const DrawerCategorieTitle({required this.itemText, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 5),
      child: Text(itemText,
          style: TextStyle(
              fontSize: 13,
              color: Colors.black,
              fontFamily: 'lato',
              fontWeight: FontWeight.w900)),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String itemText;
  final IconData icon;
  final String routeName;
  const DrawerItem(
      {required this.itemText,
      required this.icon,
      required this.routeName,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: ListTile(
        leading: Icon(icon, size: 16, color: Colors.black),
        title: Text(itemText,
            style: TextStyle(
                fontSize: 11,
                color: Colors.black,
                fontFamily: 'lato',
                fontWeight: FontWeight.w400)),
        onTap: () => NavigationRoutes().push(context, routeName), 
      ),
    );
  }
}
