import 'package:flutter/material.dart';

class MySizedBox extends SizedBox {
  const MySizedBox({super.key, required super.child}) : super(width: 100);
}

String? stringNotEmptyValidator(value, message) {
  if (value == null || value.trim().isEmpty) {
    return message;
  }
  return null;
}
