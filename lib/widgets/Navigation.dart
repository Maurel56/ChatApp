import 'package:flutter/material.dart';

class Navigates {
  static navigateFor(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: ((context) => page)),
    );
  }

  static navigateAndReplace(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: ((context) => page)),
    );
  }

  static close(BuildContext context) {
    Navigator.of(context);
  }
}
