import 'package:flutter/material.dart';

class NotificationsService {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      new GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String message) {
    final snackBar = new SnackBar(
        content: Text(
      message,
      style: TextStyle(fontFamily: 'Avenir', fontSize: 14, color: Colors.white),
      textAlign: TextAlign.center,
    ));

    messengerKey.currentState!.showSnackBar(snackBar);
  }
}
