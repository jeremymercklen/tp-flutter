import 'package:exo1/consts.dart';
import 'package:flutter/material.dart';

class MyPadding extends Padding {
  const MyPadding({super.key, required super.child}): super(padding: defaultPadding);
}

class MyText extends Text {
  const MyText(super.data, {super.key}): super(style: defaultTextStyle);
}

String? stringNotEmptyValidator (value, message) {
  if (value == null || value.trim().isEmpty) {
    return message;
  }
  return null;
}