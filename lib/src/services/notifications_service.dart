import 'package:flutter/material.dart';

// No le pongo el ChangeNotifier porque no necesito redibujar nada
// Este messengerKey me va a matener la referencia al Widget scaffoldMessengerKey en el main.dart
class NotificationsService {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      new GlobalKey<ScaffoldMessengerState>();
  static showSnackbar(String message) {
    final snackBar = new SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
    messengerKey.currentState!.showSnackBar(snackBar);
  }
}
