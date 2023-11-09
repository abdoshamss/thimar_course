import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future navigateTo(Widget page, {bool removeHistory = false}) async{
  return Navigator.pushAndRemoveUntil(
    navigatorKey.currentContext!,
    MaterialPageRoute(
      builder: (context) => page,
    ),
    (route) => !removeHistory,
  );
}

enum MessageType {
  warning,
  success,
  error,
}

void showMessage(String message,
    {MessageType messageType = MessageType.success}) {
  if (message.isNotEmpty) {
    Color bgColor = Colors.green;
    if (messageType == MessageType.warning) {
      bgColor = Colors.yellow;
    } else if (messageType == MessageType.error) {
      bgColor = Colors.red;
    }

    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(
        backgroundColor: bgColor,
      shape: const StadiumBorder(),
        behavior: SnackBarBehavior.floating,
        width: 250,
        content: Center(
            child: Text(
          message,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,

          ),
        ))));
  }
}

void loadingWidget() => const Center(
      child: CircularProgressIndicator(),
    );

///  Platform  Firebase App Id
// android   1:563451404729:android:7c1a21beea852083c89668
// ios       1:563451404729:ios:81d9cb784ba2b783c89668
