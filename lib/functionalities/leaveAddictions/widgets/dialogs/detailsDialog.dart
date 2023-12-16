import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_i_am_in_control/functionalities/leaveAddictions/widgets/dialogs/deleteDialog.dart';

Future<void> openDetailsDialog(BuildContext context, String addictionTitle,
      String lastTimeDate, String lastTimeHour, String addictionReason) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return DetailsDialog(
            addictionTitle: addictionTitle,
            lastTimeDate: lastTimeDate,
            lastTimeHour: lastTimeHour,
            addictionReason: addictionReason);
      },
    );
  }
class DetailsDialog extends StatefulWidget {
  final String addictionTitle;
  final String lastTimeDate;
  final String lastTimeHour;
  final String addictionReason;

  const DetailsDialog(
      {Key? key,
      required this.addictionTitle,
      required this.lastTimeDate,
      required this.lastTimeHour,
      required this.addictionReason})
      : super(key: key);

  @override
  State<DetailsDialog> createState() => _DetailsDialogState();
}

class _DetailsDialogState extends State<DetailsDialog> {
  String fromLastTime = '';

  String time_passed(DateTime datetime, {bool full = true}) {
    DateTime now = DateTime.now();
    DateTime ago = datetime;
    Duration dur = now.difference(ago);
    int days = dur.inDays;
    int years = (days / 365).toInt();
    int months = ((days - (years * 365)) / 30).toInt();
    int weeks = ((days - (years * 365 + months * 30)) / 7).toInt();
    int rdays = days - (years * 365 + months * 30 + weeks * 7).toInt();
    int hours = (dur.inHours % 24).toInt();
    int minutes = (dur.inMinutes % 60).toInt();
    int seconds = (dur.inSeconds % 60).toInt();
    var diff = {
      "d": rdays,
      "w": weeks,
      "m": months,
      "y": years,
      "s": seconds,
      "i": minutes,
      "h": hours
    };

    Map str = {
      'y': 'ano',
      'm': 'mes',
      'w': 'semana',
      'd': 'dia',
      'h': 'hora',
      'i': 'minuto',
      's': 'segundo',
    };

    str.forEach((k, v) {
      if (diff[k]! > 0) {
        str[k] =
            diff[k].toString() + ' ' + v.toString() + (diff[k]! > 1 ? 's' : '');
      } else {
        str[k] = "";
      }
    });
    str.removeWhere((index, ele) => ele == "");
    List<String> tlist = [];
    str.forEach((k, v) {
      tlist.add(v);
    });
    if (full) {
      return str.length > 0 ? tlist.join(", ") + "" : "Just Now";
    } else {
      return str.length > 0 ? tlist[0] + "" : "Just Now";
    }
  }

  Future calculateAddictionStatus(
    String lastTimeDate,
    String lastTimeHour,
  ) async {
    String timeago =
        time_passed(DateTime.parse('${lastTimeDate} ${lastTimeHour}'));
    setState(() {
      fromLastTime = timeago;
    });
  }

  void selectNavigatorPop(
    String addictionTitle,
  ) {
FirebaseFirestore.instance
        .collection("userAddictions")
        .doc("users")
        .collection(FirebaseAuth.instance.currentUser!.uid)
        .doc(addictionTitle)
        .get()
        .then(
      (snapshot) async {
        if (mounted)
          setState(() {
            if (snapshot.exists) {
              return ;
            }
            else {
              return Navigator.of(context).pop();
            }
          });
      },
    );

  }
  

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        setState(() {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            calculateAddictionStatus(widget.lastTimeDate, widget.lastTimeHour);
          });
        });
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          contentPadding: EdgeInsets.all(0),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [
                        0.1,
                        0.1,
                        0.9,
                        0.5,
                      ],
                      colors: [
                        Colors.red,
                        Colors.white,
                        Colors.white,
                        Colors.white,
                      ],
                    )),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 15.0,
                            top: 20,
                          ),
                          child: Text(
                            widget.addictionTitle,
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 35),
                          child: Row(children: [
                            Text('Última Vez:',
                                style: TextStyle(
                                  fontSize: 14,
                                )),
                          ]),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 23, top: 15),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: Text(widget.lastTimeDate),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 0),
                                child: Text('às'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Text(widget.lastTimeHour),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 35),
                          child: Row(
                            children: [
                              Text('Tempo de Abstinência Total:',
                                  style: TextStyle(
                                    fontSize: 14,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 30.0, right: 25, top: 20),
                      child: Row(
                        children: [
                          Flexible(
                              child: Text(
                            fromLastTime,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 40),
                          child: Column(
                            children: [
                              Text(
                                'Parabéns pelo seu progresso até aqui!\nContinue no bom caminho!',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15)
                  ],
                ),
              );
            },
          ),
          actions: <Widget>[
            TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.white),
                child: Text('Eliminar',
                    style: TextStyle(
                      color: Colors.red,
                    )),
                onPressed: () {
                  openDeleteDialog(context, widget.addictionTitle).then((value) => selectNavigatorPop(widget.addictionTitle));
                }),
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.white),
              child: Text('Fechar',
                  style: TextStyle(
                    color: Colors.black,
                  )),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
