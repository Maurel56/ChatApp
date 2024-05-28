import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double rowSpace = (width / 5);
    double columnSpace = (height / 10);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          width: width,
          child: Opacity(
            opacity: 0.05,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: columnSpace,
                      width: rowSpace,
                    ),
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: columnSpace,
                      width: rowSpace,
                    ),
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: columnSpace,
                      width: rowSpace,
                    ),
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: columnSpace,
                      width: rowSpace,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: columnSpace,
                      width: rowSpace,
                    ),
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: columnSpace,
                      width: rowSpace,
                    ),
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: columnSpace,
                      width: rowSpace,
                    ),
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: columnSpace,
                      width: rowSpace,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: columnSpace,
                      width: rowSpace,
                    ),
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: columnSpace,
                      width: rowSpace,
                    ),
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: columnSpace,
                      width: rowSpace,
                    ),
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: columnSpace,
                      width: rowSpace,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: columnSpace,
                      width: rowSpace,
                    ),
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: columnSpace,
                      width: rowSpace,
                    ),
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: columnSpace,
                      width: rowSpace,
                    ),
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: columnSpace,
                      width: rowSpace,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: columnSpace,
                      width: rowSpace,
                    ),
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: columnSpace,
                      width: rowSpace,
                    ),
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: columnSpace,
                      width: rowSpace,
                    ),
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: columnSpace,
                      width: rowSpace,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: columnSpace,
                      width: rowSpace,
                    ),
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: columnSpace,
                      width: rowSpace,
                    ),
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: columnSpace,
                      width: rowSpace,
                    ),
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: columnSpace,
                      width: rowSpace,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: columnSpace,
                      width: rowSpace,
                    ),
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: columnSpace,
                      width: rowSpace,
                    ),
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: columnSpace,
                      width: rowSpace,
                    ),
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: columnSpace,
                      width: rowSpace,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: columnSpace,
                      width: rowSpace,
                    ),
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: columnSpace,
                      width: rowSpace,
                    ),
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: columnSpace,
                      width: rowSpace,
                    ),
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: columnSpace,
                      width: rowSpace,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: columnSpace,
                      width: rowSpace,
                    ),
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: columnSpace,
                      width: rowSpace,
                    ),
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: columnSpace,
                      width: rowSpace,
                    ),
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: columnSpace,
                      width: rowSpace,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: columnSpace,
                      width: rowSpace,
                    ),
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: columnSpace,
                      width: rowSpace,
                    ),
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: columnSpace,
                      width: rowSpace,
                    ),
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: columnSpace,
                      width: rowSpace,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
