import 'package:flutter/material.dart';

class NavigationRoutes {
  void push(context, String routeName, {Object? arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }
  //mostra o ecrã por cima do outro

  void pushReplacement(context, String routeName, {Object? arguments}) {
    Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
  }
  //subsitui o ecrã

  void pushNamedAndRemoveUntil(context, String routeName, {Object? arguments}) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      routeName,
      (Route<dynamic> route) => false,
      arguments: arguments,
    );
  }
  //remover todas as rotas antes da indicada e substituir o ecrã 
  void pop(context) {
    Navigator.pop(context);
  }
}