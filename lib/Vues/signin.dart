// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chatapp/Modeles/Utilisateur.dart';
import 'package:chatapp/Vues/verificationOTP.dart';
import 'package:chatapp/widgets/EBouton.dart';
import 'package:chatapp/widgets/Navigation.dart';
import 'package:chatapp/widgets/background.dart';
import 'package:chatapp/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatapp/Vues/navBar.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> sendPhoneVerificationCode(
      String phoneNumber, BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
          Navigates.navigateAndReplace(context, const NavBar());
          // Cette fonction est appelée automatiquement si l'authentification est complétée automatiquement.
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print(
                'Le numéro de téléphone entrer est invalide. veillez le rectifié');
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          load = false;
          tel2.clear();
          setState(() {});
          Navigates.navigateFor(
            context,
            VerficationOTP(
              verificationId: verificationId,
              user: user,
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      return true; // Le code de vérification a été envoyé avec succès
    } catch (e) {
      return false; // Une erreur s'est produite lors de l'envoi du code de vérification
    }
  }

  Utilisateur user = Utilisateur(
    uid: '',
    userName: "",
    tel: '',
    lastConnection: Timestamp.now(),
  );
  TextEditingController userName = TextEditingController();
  TextEditingController tel2 = TextEditingController();
  String tel = '';
  bool load = false;
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      width: width / 1.6,
                    ),
                    Column(
                      children: [
                        const Text(
                            "Veillez renseigner votre numéro de téléphone. Un message de confirmation vous sera envoyé"),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 65,
                          width: width - 70,
                          child: TextFormField(
                            controller: userName,
                            decoration: const InputDecoration(
                              label: Text('Pseudo'),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                              prefix: Icon(
                                Icons.person,
                                color: Color.fromARGB(255, 106, 1, 124),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: width - 70,
                          child: IntlPhoneField(
                            controller: tel2,
                            initialCountryCode: 'CM',
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        EBouton(
                          height: 45,
                          width: width - 70,
                          text: 'Continuer',
                          onTap: () async {
                            if (tel2.text != '' && userName.text != '') {
                              setState(() {
                                user.userName = userName.text;
                                user.tel = tel2.text;
                                user.discussion = [];
                                load = true;
                              });
                              await sendPhoneVerificationCode(
                                "+237${tel2.value.text}",
                                context,
                              );
                            }
                          },
                        )
                      ],
                    ),
                    const Text(""),
                    const Text(""),
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
                                color: const Color.fromARGB(255, 106, 1, 124),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: const Color.fromARGB(255, 241, 3, 83),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: const Color.fromARGB(255, 245, 180, 0),
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
          ),
          Visibility(
            visible: load,
            child: loading(context),
          ),
        ],
      ),
    );
  }
}
