import 'package:chatapp/Vues/signin.dart';
import 'package:chatapp/widgets/EBouton.dart';
import 'package:chatapp/widgets/Navigation.dart';
import 'package:chatapp/widgets/background.dart';
import 'package:flutter/material.dart';

class Splach extends StatelessWidget {
  const Splach({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const Background(),
          Center(
            child: SizedBox(
              height: height,
              width: width - 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    width: width / 1.6,
                  ),
                  Column(
                    children: [
                      const Text(
                        'Hello!',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 25),
                      const Text(
                        'Bienvenue sur notre novelle plateforme de méssagerie\n Connectez-vous et restez en contact avec vos proche ou que vous soyez. Commencez a discuter, partager des photos et des moment precieux...',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 35),
                      EBouton(
                        height: 45,
                        width: width,
                        text: 'Continuer',
                        onTap: () =>
                            Navigates.navigateFor(context, const Signin()),
                      ),
                    ],
                  ),
                  const Text(''),
                  Column(
                    children: [
                      const Text.rich(
                        TextSpan(
                          text: 'Par ',
                          children: [
                            TextSpan(
                              text: "M Dev & Design",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Color.fromARGB(255, 106, 1, 124),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Color.fromARGB(255, 241, 3, 83),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Color.fromARGB(255, 245, 180, 0),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
