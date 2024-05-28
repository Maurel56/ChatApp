import 'package:flutter/material.dart';

Widget loading(BuildContext context) {
  return Container(
    color: const Color.fromARGB(255, 106, 1, 124).withOpacity(0.3),
    child: Center(
      child: CircularProgressIndicator(
        backgroundColor: const Color.fromARGB(255, 241, 3, 83).withOpacity(0.4),
        valueColor:
            AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
      ),
    ),
  );
}
