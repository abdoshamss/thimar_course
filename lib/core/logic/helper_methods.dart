import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void navigateTo(Widget page) {
  Navigator.push(
    navigatorKey.currentContext!,
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );}
  void showMessage(String message) {
    ScaffoldMessenger.of(navigatorKey.currentContext!)
        .showSnackBar(SnackBar(content: Text(message)));
  }

///  Platform  Firebase App Id
// android   1:563451404729:android:7c1a21beea852083c89668
// ios       1:563451404729:ios:81d9cb784ba2b783c89668