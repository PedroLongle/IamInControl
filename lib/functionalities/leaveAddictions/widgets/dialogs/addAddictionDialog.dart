import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diacritic/diacritic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

DateTime _dateTime = DateTime.now();
TimeOfDay _timeOfDay = TimeOfDay.now();

const List<String> addictionList = <String>[
  'Consumir Tabaco',
  'Consumir Álcool',
  'Ver Pornografia',
  'Visitar Redes Sociais',
  'Compras Impulsivas'
];
String dropdownValueAddictions = addictionList.first;

const List<String> reasonList = <String>[
  'Custo Monetário',
  'Consumo de Tempo',
  'É prejudicial para mim',
];
String dropdownValueReasons = reasonList.first;

Future<void> openAddAddictionDialog(context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AddAddictionDialog();
    },
  );
}

class AddAddictionDialog extends StatefulWidget {
  const AddAddictionDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<AddAddictionDialog> createState() => _AddAddictionDialogState();
}

class _AddAddictionDialogState extends State<AddAddictionDialog> {
  final user = FirebaseAuth.instance.currentUser!;

  bool isLoading = false;

  Future addCurrentUserAddiction(
    String addictionTitle,
    String lastTimeDate,
    String lastTimeHour,
    String addictionReason,
  ) async {
    final user = FirebaseAuth.instance.currentUser!;
    final String noDiacritics = removeDiacritics(addictionTitle);
    final String addictionCode = noDiacritics.replaceAll(' ', '');
    await FirebaseFirestore.instance
        .collection('userAddictions')
        .doc('users')
        .collection(user.uid)
        .doc(addictionCode)
        .set({
      'addictionCode': addictionCode,
      'addictionTitle': addictionTitle,
      'lastTimeDate': lastTimeDate,
      'lastTimeHour': lastTimeHour,
      'reason': addictionReason,
    });
    if (this.mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(_dateTime);

    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          _showDatePicker() {
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2025),
              helpText: 'Selecionar data da Última vez',
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
                  _dateTime = value;
                });
            });
          }

          _showTimePicker() {
            showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
              helpText: 'Selecionar data da Última vez',
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
                  _timeOfDay = value;
                });
            });
          }

          DateFormat formatter = DateFormat('yyyy-MM-dd');
          String formattedDate = formatter.format(_dateTime);

          return Container(
            height: 425,
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 2.0, top: 10, right: 15),
                      child: Text(
                        'Estamos prontos para\nte ajudar!',
                        style: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 35),
                      child: Row(
                        children: [
                          Text('Quero deixar o hábito de:',
                              style: TextStyle(
                                fontSize: 14,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: Row(
                        children: [
                          DropdownButtonAddictions(),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 25),
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
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Text(formattedDate.toString()),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 35.0),
                            child: Text(_timeOfDay.format(context).toString()),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8, top: 4.0),
                      child: Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        elevation: 18.0,
                        color: Colors.black,
                        child: MaterialButton(
                          height: 2,
                          color: Colors.black,
                          onPressed: _showDatePicker,
                          child: Text(
                            'Escolher Data',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, top: 4.0),
                      child: Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        elevation: 18.0,
                        color: Colors.black,
                        child: MaterialButton(
                          height: 2,
                          color: Colors.black,
                          onPressed: _showTimePicker,
                          child: Text(
                            'Escolher Hora',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 35),
                      child: Row(
                        children: [
                          Text(
                              'Motivo:', // forEach para receber todos os dados da base de dados. Para cada dado recebido, fazer um card com: Nome do vicio, contagem do tempo. -> Onclick do card: levar para um "showAddictionStateScreen" que irá ter um grafico e tal, dinheiro poupado, calendario, etc.
                              style: TextStyle(
                                fontSize: 14,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 5),
                      child: Row(
                        children: [
                          DropdownButtonReasons(),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(backgroundColor: Colors.white),
          child: Text('Confirmar',
              style: TextStyle(
                color: Colors.black,
              )),
          onPressed: () {
            setState(() {
              isLoading = true;
            });
            addCurrentUserAddiction(dropdownValueAddictions, formattedDate,
                _timeOfDay.format(context).toString(), dropdownValueReasons);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class DropdownButtonAddictions extends StatefulWidget {
  const DropdownButtonAddictions({super.key});

  @override
  State<DropdownButtonAddictions> createState() =>
      _DropdownButtonAddictionsState();
}

class _DropdownButtonAddictionsState extends State<DropdownButtonAddictions> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: DropdownButton<String>(
        value: dropdownValueAddictions,
        dropdownColor: Colors.white,
        icon: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: const Icon(
            PhosphorIcons.arrowDownBold,
            size: 18,
            color: Colors.red,
          ),
        ),
        elevation: 1,
        style: const TextStyle(color: Colors.red),
        underline: Container(
          height: 1.5,
          color: Colors.red,
        ),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValueAddictions = value!;
          });
        },
        items: addictionList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class DropdownButtonReasons extends StatefulWidget {
  const DropdownButtonReasons({super.key});

  @override
  State<DropdownButtonReasons> createState() => _DropdownButtonReasonsState();
}

class _DropdownButtonReasonsState extends State<DropdownButtonReasons> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 0, bottom: 0),
      child: DropdownButton<String>(
        dropdownColor: Colors.white,
        value: dropdownValueReasons,
        icon: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: const Icon(
            PhosphorIcons.arrowDownBold,
            size: 18,
            color: Colors.black,
          ),
        ),
        elevation: 1,
        style: const TextStyle(color: Colors.black),
        underline: Container(
          height: 1.5,
          color: Colors.black,
        ),
        onChanged: (String? value) {
          setState(() {
            dropdownValueReasons = value!;
          });
        },
        items: reasonList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(backgroundColor: Colors.white),
            ),
          );
        }).toList(),
      ),
    );
  }
}
