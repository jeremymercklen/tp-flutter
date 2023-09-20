import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySizedBox extends SizedBox {
  MySizedBox({super.key, required super.child}) : super(width: double.infinity);
}

class MyElevatedButton extends ElevatedButton {
  MyElevatedButton({super.key, required String text, required super.onPressed})
      : super(child: Text(text));
}

String? stringNotEmptyValidator(value, message) {
  if (value == null || value.trim().isEmpty) {
    return message;
  }
  return null;
}
