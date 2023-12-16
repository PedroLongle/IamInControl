import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_card/image_card.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../homePage/screens/homeScreen.dart';
import 'package:project_i_am_in_control/functionalities/sleepHabits/screens/sleepHabitsFullLog.dart';
import 'package:project_i_am_in_control/functionalities/sleepHabits/screens/sleepSounds.dart';
import 'package:project_i_am_in_control/functionalities/sleepHabits/screens/sleepTips.dart';

class SleepHabitsScreen extends StatefulWidget {
  const SleepHabitsScreen({super.key});

  @override
  State<SleepHabitsScreen> createState() => _SleepHabitsScreenState();
}

class _SleepHabitsScreenState extends State<SleepHabitsScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  String sleepDuration = '';
  String tempDate = '';

  Future getSleepLogDuration(
    String bedTime,
    String wakeUpTime,
  ) async {
    var temptime;
    var format = DateFormat("HH:mm");
    var start = format.parse(bedTime);
    var end = format.parse(wakeUpTime).add(const Duration(days: 1));

    String _printDuration(Duration duration) {
      String twoDigits(int n) => n.toString().padLeft(2, "0");
      String twoDigitMinutes =
          twoDigits(duration.inMinutes.remainder(60).abs());
      setState(() {
        sleepDuration = "${twoDigits(duration.inHours.abs())}:$twoDigitMinutes";
      });
      return '';
    }

    if (start.isAfter(end)) {
      setState(() {
        temptime = start.difference(end);
        _printDuration(temptime);
      });
    } else if (start.isBefore(end)) {
      setState(() {
        temptime = start.difference(end);
        _printDuration(temptime);
      });
    } else {
      setState(() {
        temptime = end.difference(start);
        _printDuration(temptime);
      });
    }
  }

  Future addCurrentUserSleepLog(
    String date,
    String duration,
    String bedTime,
    String wakeUpTime,
  ) async {
    await FirebaseFirestore.instance
        .collection('sleepHabits')
        .doc('userLogs')
        .collection(user.uid)
        .doc(date)
        .set({
      'date': date,
      'duration': duration,
      'bedTime': bedTime,
      'wakeUpTime': wakeUpTime,
    });
  }

  @override
  Widget build(BuildContext context) {
    TimeOfDay _bedTime = TimeOfDay(hour: 22, minute: 00);
    TimeOfDay _wakeUpTime = TimeOfDay(hour: 06, minute: 30);

    var now = new DateTime.now();
    var yesterday = new DateTime.now().subtract(const Duration(days: 1));
    var formatter = new DateFormat('dd-MM');
    String todayDate = formatter.format(now);
    String yesterdayDate = formatter.format(yesterday);
    String finalDate = yesterdayDate + ' - ' + todayDate;

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
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 40),
            child: Text(
              'Os meus Hábitos de Sono',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: SizedBox(
                    height: 140,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('sleepHabits')
                            .doc('userLogs')
                            .collection(user.uid)
                            .where('date', isEqualTo: finalDate)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container(
                                height: 110,
                                width: 320,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[200],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 12.0, top: 12),
                                            child: Text('Registo de Hoje:'),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Center(
                                          child: Text(
                                            'A carregar..',
                                            style: TextStyle(
                                                color: Colors.grey[500],
                                                fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ));
                          } else if (snapshot.data!.docs.length < 1) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 35, left: 0),
                              child: Container(
                                  height: 110,
                                  width: 320,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[200],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12.0, top: 12),
                                              child: Text('Registo de Hoje:'),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20.0),
                                          child: Center(
                                            child: Text(
                                              'Sem registo adicionado até ao momento',
                                              style: TextStyle(
                                                  color: Colors.grey[500],
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            );
                          } else {
                            return GridView.count(
                              primary: false,
                              crossAxisCount: 1,
                              childAspectRatio: 5 / 1.8,
                              children: List.generate(
                                  snapshot.data!.docs.length, (index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 35, left: 30, right: 30),
                                  child: Container(
                                      height: 20,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey[200],
                                      ),
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 12.0,
                                                            top: 12),
                                                    child: Text(
                                                        'Registo de Hoje:'),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 12.0,
                                                            left: 10),
                                                    child: Text(
                                                      snapshot.data!.docs[index]
                                                              .get('duration') +
                                                          'h',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                          fontSize: 22),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 33.0, left: 35),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('Hora de Início: '),
                                                    Text(
                                                      snapshot.data!.docs[index]
                                                          .get('bedTime'),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text('Hora de Fim: '),
                                                    Text(
                                                      snapshot.data!.docs[index]
                                                          .get('wakeUpTime'),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )),
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
                      padding: const EdgeInsets.only(top: 5, left: 60),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: Colors.white,
                                  surfaceTintColor: Colors.white,
                                  content: StatefulBuilder(builder:
                                      (BuildContext context,
                                          StateSetter setState) {
                                    _showBedTimePicker() {
                                      showTimePicker(
                                        context: context,
                                        initialTime: _bedTime,
                                        helpText:
                                            'Selecionar hora em que se foi deitar',
                                        cancelText: 'Cancelar',
                                        confirmText: 'Confirmar',
                                        builder: (context, child) {
                                          return Theme(
                                            data: ThemeData.dark(),
                                            child: child!,
                                          );
                                        },
                                      ).then((value) {
                                        if (value == null) {
                                          return;
                                        } else
                                          setState(() {
                                            _bedTime = value;
                                          });
                                      });
                                    }

                                    _showWakeTimePicker() {
                                      showTimePicker(
                                        context: context,
                                        initialTime: _wakeUpTime,
                                        helpText:
                                            'Selecionar hora em que acordou',
                                        cancelText: 'Cancelar',
                                        confirmText: 'Confirmar',
                                        builder: (context, child) {
                                          return Theme(
                                            data: ThemeData.dark(),
                                            child: child!,
                                          );
                                        },
                                      ).then((value) {
                                        if (value == null) {
                                          return;
                                        } else
                                          setState(() {
                                            _wakeUpTime = value;
                                          });
                                      });
                                    }

                                    return Container(
                                      height: 420,
                                      child: Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 25.0, top: 8),
                                                  child: Center(
                                                      child: Wrap(
                                                    crossAxisAlignment:
                                                        WrapCrossAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'A que horas se foi deitar?',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0),
                                                        child: Icon(
                                                          PhosphorIcons
                                                              .moonStarsBold,
                                                          color: Colors.blue,
                                                          size: 18,
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 50, top: 35.0),
                                                  child: Center(
                                                    child: Text(
                                                      _bedTime
                                                          .format(context)
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 50),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            GestureDetector(
                                              onTap: _showBedTimePicker,
                                              child: Container(
                                                height: 40,
                                                width: 200,
                                                child: Card(
                                                  color: Colors.blue,
                                                  child: Center(
                                                      child: Wrap(
                                                    crossAxisAlignment:
                                                        WrapCrossAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Escolher hora',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0),
                                                        child: Icon(
                                                          PhosphorIcons
                                                              .moonStars,
                                                          color: Colors.white,
                                                          size: 18,
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 45.0, top: 60),
                                                  child: Center(
                                                      child: Wrap(
                                                    crossAxisAlignment:
                                                        WrapCrossAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'A que horas acordou?',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0),
                                                        child: Icon(
                                                          PhosphorIcons.sunBold,
                                                          color: Colors.yellow,
                                                          size: 18,
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 50, top: 35.0),
                                                  child: Center(
                                                    child: Text(
                                                      _wakeUpTime
                                                          .format(context)
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 50),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            GestureDetector(
                                              onTap: _showWakeTimePicker,
                                              child: Container(
                                                height: 40,
                                                width: 200,
                                                child: Card(
                                                  color: Colors.yellow,
                                                  child: Center(
                                                      child: Wrap(
                                                    crossAxisAlignment:
                                                        WrapCrossAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Escolher hora',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0),
                                                        child: Icon(
                                                          PhosphorIcons.sunBold,
                                                          color: Colors.white,
                                                          size: 18,
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                  actions: <Widget>[
                                    TextButton(
                                      style: TextButton.styleFrom(
                                          backgroundColor: Colors.white),
                                      child: Text('Cancelar',
                                          style: TextStyle(color: Colors.red)),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                          backgroundColor: Colors.white),
                                      child: Text('Concluir',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)),
                                      onPressed: () {
                                        getSleepLogDuration(
                                            _bedTime.format(context),
                                            _wakeUpTime.format(context));
                                        addCurrentUserSleepLog(
                                            finalDate,
                                            sleepDuration,
                                            _bedTime.format(context),
                                            _wakeUpTime.format(context));
                                        Navigator.of(context).pop();
                                        //Este registo irá substituir o existente, pretende fazê-lo na mesma?
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                        child: Container(
                          height: 40,
                          width: 260,
                          child: Card(
                            color: Colors.black,
                            child: Center(
                                child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text(
                                  'Adicionar Registo',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Icon(
                                    PhosphorIcons.plusBold,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ],
                            )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: SizedBox(
                    height: 140,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('sleepHabits')
                            .doc('userLogs')
                            .collection(user.uid)
                            .orderBy("date", descending: true)
                            .limit(1)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container(
                                height: 110,
                                width: 320,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[200],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 12.0, top: 12),
                                            child: Text('Registo de Hoje:'),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Center(
                                          child: Text(
                                            'A carregar..',
                                            style: TextStyle(
                                                color: Colors.grey[500],
                                                fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ));
                          } else if (snapshot.data!.docs.length < 1) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 35, left: 0),
                              child: Container(
                                  height: 110,
                                  width: 320,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[200],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12.0, top: 12),
                                              child: Text('Último Registo:'),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20.0),
                                          child: Center(
                                            child: Text(
                                              'Sem registo adicionados até ao momento',
                                              style: TextStyle(
                                                  color: Colors.grey[500],
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            );
                          } else {
                            return GridView.count(
                              primary: false,
                              crossAxisCount: 1,
                              childAspectRatio: 5 / 1.8,
                              children: List.generate(
                                  snapshot.data!.docs.length, (index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 35, left: 30, right: 30),
                                  child: Container(
                                      height: 20,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey[200],
                                      ),
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 12.0,
                                                            top: 12),
                                                    child:
                                                        Text('Último registo:'),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 12.0,
                                                            left: 10),
                                                    child: Text(
                                                      snapshot.data!.docs[index]
                                                              .get('duration') +
                                                          'h',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                          fontSize: 22),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 33.0, left: 35),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('Hora de Início: '),
                                                    Text(
                                                      snapshot.data!.docs[index]
                                                          .get('bedTime'),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text('Hora de Fim: '),
                                                    Text(
                                                      snapshot.data!.docs[index]
                                                          .get('wakeUpTime'),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )),
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
                      padding: const EdgeInsets.only(top: 5, left: 55),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SleepFullLogScreen()));
                        },
                        child: Container(
                          height: 40,
                          width: 270,
                          child: Card(
                            color: Colors.black,
                            child: Center(
                                child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text(
                                  'Ver Registo Completo ',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Icon(
                                    PhosphorIcons.calendar,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ],
                            )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 85, left: 30, bottom: 50),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SleepSoundsScreen()));
                            },
                            child: TransparentImageCard(
                              width: 150,
                              height: 170,
                              imageProvider: AssetImage(
                                  'assets/images/sleepHabits/sleepSounds.png'),
                              title: Padding(
                                padding: const EdgeInsets.only(
                                    top: 0, left: 0, right: 10),
                                child: Text("Sons para dormir",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                              ),
                              description: Container(
                                child: Text("Ver mais",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: ((context) => sleepTipsScreen()));
                              },
                              child: TransparentImageCard(
                                width: 150,
                                height: 170,
                                imageProvider: AssetImage(
                                    'assets/images/sleepHabits/sleepTips.png'),
                                title: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0, left: 0, right: 10),
                                  child: Text("Dicas para dormir",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                ),
                                description: Container(
                                  child: Text("ver mais",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
