// ignore_for_file: must_be_immutable, sort_child_properties_last

import 'package:flutter/material.dart';

class EBouton extends StatelessWidget {
  VoidCallback onTap;
  double height, width;
  String text;
  EBouton({
    super.key,
    required this.height,
    required this.width,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color.fromARGB(255, 106, 1, 124).withOpacity(0.8),
              const Color.fromARGB(255, 241, 3, 83).withOpacity(0.8),
              const Color.fromARGB(255, 245, 180, 0).withOpacity(0.8),
            ],
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
