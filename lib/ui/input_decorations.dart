import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration authInputDecoration(
      {required String hinText,
      required String labelText,
      IconData? prefixIcon}) {
    return InputDecoration(
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black87, width: 2)),
        hintText: hinText,
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: Colors.black87)
            : null);
  }
}
