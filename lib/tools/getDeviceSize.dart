import 'package:flutter/material.dart';

Future DeviceHeight(context, num size) async {
    return MediaQuery.of(context).size.height * size;
}

Future DeviceWidth(context, num size) async {
    return MediaQuery.of(context).size.width * size;
}
