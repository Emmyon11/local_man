import 'package:flutter/material.dart';

void nextScreen({required Widget widget, required BuildContext context}) {
  Navigator.push(
      context,
      MaterialPageRoute<Widget>(
          builder: (BuildContext context) =>
              widget)); // push() is used to navigate from one
}

void nextScreenWithOutReplacement(
    {required Widget widget, required BuildContext context}) {
  Navigator.pushReplacement(
      context,
      MaterialPageRoute<Widget>(
          builder: (BuildContext context) =>
              widget)); // push() is used to navigate from one
}
