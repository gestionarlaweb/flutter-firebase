import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration authInputDecoration(
      {required String hintText,
      required String labelText,
      IconData? prefixIcon}) {
    return InputDecoration(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.deepPurple,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.deepPurple,
          width: 2,
        ),
      ),
      labelText: labelText,
      labelStyle: TextStyle(fontSize: 14.0),
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0),
      prefixIcon: prefixIcon != null
          ? Icon(Icons.alternate_email_sharp, color: Colors.deepPurple)
          : null,
    );
  }
}
