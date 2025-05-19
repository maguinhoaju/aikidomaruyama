import 'package:flutter/material.dart';

InputDecoration getLabelInputDecoration(String label) {
  return InputDecoration(
    label: Text(label),
    contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
  );
}

InputDecoration getHintTextInputDecoration(String hintText) {
  return InputDecoration(
    label: Text(hintText),
    contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
  );
}

ButtonStyle getButtonStyle() {
  return const ButtonStyle(
    backgroundColor:
        WidgetStatePropertyAll<Color>(Color.fromARGB(255, 8, 64, 110)),
    //padding: WidgetStatePropertyAll(EdgeInsetsGeometry(12)),
  );
}

TextStyle getTittleTextStyle() {
  return const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 8, 64, 110),
  );
}
