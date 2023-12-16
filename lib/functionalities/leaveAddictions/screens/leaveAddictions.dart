// ignore_for_file: division_optimization

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:project_i_am_in_control/components/widgets/buttons/roundedTextButton.dart';
import 'package:project_i_am_in_control/components/widgets/texts/headingText.dart';
import 'package:project_i_am_in_control/functionalities/leaveAddictions/widgets/dialogs/addAddictionDialog.dart';
import 'package:project_i_am_in_control/functionalities/leaveAddictions/widgets/card/addictionCard.dart';
import 'package:project_i_am_in_control/functionalities/leaveAddictions/widgets/dialogs/deleteDialog.dart';
import 'package:project_i_am_in_control/functionalities/leaveAddictions/widgets/dialogs/detailsDialog.dart';

import '../../homePage/screens/homeScreen.dart';
import '../widgets/showcase/affirmationShowcase.dart';

class LeaveAddictionsScreen extends StatefulWidget {
  const LeaveAddictionsScreen({super.key});

  @override
  State<LeaveAddictionsScreen> createState() => _LeaveAddictionsScreenState();
}

class _LeaveAddictionsScreenState extends State<LeaveAddictionsScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(
    BuildContext context,
  ) {
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
          },
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Text('Abandonar Vícios', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: IconButton(
              icon: Icon(PhosphorIcons.dotsThreeBold, color: Colors.white),
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
              },
            ),
          )
        ],
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 30.0, top: 40),
                      child: HeadingText(
                          title: 'Melhore a sua qualidade de vida, por si!',
                          subtitle: 'Abandonar Vícios',
                          color: Colors.black,
                          isTitleBold: false)),
                ],
              ),
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 30.0, top: 30),
                      child: Text('Motivação Diária')),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Column(children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: AffirmationShowcase(),
                          ))
                    ]),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0, top: 35),
                    child: Row(
                      children: [
                        Text(
                          'Compromento-me a desistir de...',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  height: 305,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('userAddictions')
                          .doc('users')
                          .collection(user.uid)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 50.0),
                            child: Center(
                              child: Text(
                                'A carregar...',
                                style: TextStyle(
                                    color: Colors.grey[500], fontSize: 15),
                              ),
                            ),
                          );
                        } else if (snapshot.data!.docs.length < 1) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 50.0),
                            child: Center(
                              child: Text(
                                'Sem progressos ativos no momento.',
                                style: TextStyle(
                                    color: Colors.grey[500], fontSize: 15),
                              ),
                            ),
                          );
                        } else {
                          return GridView.count(
                            primary: false,
                            crossAxisCount: 1,
                            mainAxisSpacing: 15,
                            childAspectRatio:
                                MediaQuery.of(context).size.width /
                                    (MediaQuery.of(context).size.height / 6),
                            children: List.generate(snapshot.data!.docs.length,
                                (index) {
                              final String addictionTitle = snapshot
                                  .data!.docs[index]
                                  .get('addictionTitle');
                              final String addictionCode = snapshot
                                  .data!.docs[index]
                                  .get('addictionCode');
                              final String addictionReason =
                                  snapshot.data!.docs[index].get('reason');
                              final String lastTimeDate = snapshot
                                  .data!.docs[index]
                                  .get('lastTimeDate');
                              final String lastTimeHour = snapshot
                                  .data!.docs[index]
                                  .get('lastTimeHour');
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0),
                                child: AddictionCard(
                                    onTap: () => openDetailsDialog(
                                        context,
                                        addictionTitle,
                                        lastTimeDate,
                                        lastTimeHour,
                                        addictionReason),
                                    onTapDelete: () => openDeleteDialog(
                                        context, addictionCode),
                                    addictionTitle: addictionTitle,
                                    addictionCode: addictionCode,
                                    addictionReason: addictionReason,
                                    lastTimeDate: lastTimeDate,
                                    lastTimeHour: lastTimeHour),
                              );
                            }),
                          );
                        }
                      }),
                ),
              ),
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 30.0, top: 60),
                      child: Text(
                        'Linhas de Apoio',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Column(children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: RoundedTextButton(
                                onTap: () => {
                                  Navigator.of(context).pop(),
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const HomeScreen();
                                      },
                                    ),
                                  ),
                                },
                                isLoading: false,
                                text: "Consultar Linhas de apoio ",
                                fontSize: 11,
                                height: 30,
                                width: 180,
                                color: Colors.white,
                                textColor: Colors.red[300]!,
                                borderRadius: 10,
                                borderColor: Colors.white,
                                borderWidth: 1,
                                textAlignment: TextAlign.start,
                                textWeight: FontWeight.bold,
                                textPadding: EdgeInsets.only(left: 8),
                                icon: Icon(
                                  PhosphorIcons.phoneCall,
                                  size: 15,
                                  color: Colors.red[300],
                                ),
                                iconPadding: EdgeInsets.only(left: 8),
                                hasShadow: true,
                              )))
                    ]),
                  ),
                ],
              ),
            ], //
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 15, right: 20),
        child: FloatingActionButton(
          onPressed: () => openAddAddictionDialog(context),
          child: Icon(
            PhosphorIcons.plusBold,
            color: Colors.white,
          ),
          backgroundColor: Colors.black,
        ),
      ),
    );
  }
}
