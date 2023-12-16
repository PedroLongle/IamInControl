import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AddictionCard extends StatelessWidget {
  final dynamic onTap;
  final dynamic onTapDelete;
  final String addictionTitle; 
  final String addictionCode;
  final String addictionReason;
  final String lastTimeDate; 
  final String lastTimeHour;
  const AddictionCard(
      {Key? key,
      required this.onTap,
      required this.onTapDelete,
      required this.addictionTitle,
      required this.addictionCode,
      required this.addictionReason,
      required this.lastTimeDate,
      required this.lastTimeHour})
      : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 330,
        height: 130,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.red, width: 0.5),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
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
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 10),
                    child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 30,
                        backgroundImage: AssetImage(
                            'assets/images/addictionIcons/${addictionCode}.png')),
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 209,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, left: 15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              addictionTitle,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Wrap(children: [
                                Text(
                                  'Motivo: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                                Text(
                                  addictionReason,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ]),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 11, bottom: 2.0),
                          child: Row(
                            children: [
                              Text('Último Registo:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12))
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Wrap(spacing: 6, children: [
                              Text(
                                lastTimeDate,
                                style: TextStyle(fontSize: 13),
                              ),
                              Text('|',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold)),
                              Text(lastTimeHour,
                                  style: TextStyle(fontSize: 13)),
                            ]),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, top: 12.0),
                    child: Row(
                      children: [
                        InkWell(
                            onTap: onTapDelete,
                            child: Icon(
                              PhosphorIcons.trash,
                              color: Colors.white,
                              size: 20,
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
