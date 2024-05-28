// ignore_for_file: dead_code, depend_on_referenced_packages, use_build_context_synchronously, unrelated_type_equality_checks, must_be_immutable, file_names

import 'dart:async';

import 'package:chatapp/BD/bd.dart';
import 'package:chatapp/Modeles/Utilisateur.dart';
import 'package:chatapp/Vues/navBar.dart';
import 'package:chatapp/widgets/EBouton.dart';
import 'package:chatapp/widgets/Navigation.dart';
import 'package:chatapp/widgets/background.dart';
import 'package:chatapp/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerficationOTP extends StatefulWidget {
  final String verificationId;
  Utilisateur user;
  VerficationOTP({super.key, required this.verificationId, required this.user});

  @override
  State<VerficationOTP> createState() => _VerficationOTPState();
}

class _VerficationOTPState extends State<VerficationOTP> {
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<bool> signInWithPhoneAndSMSCode(
    BuildContext context,
    String verificationId,
    String smsCode,
  ) async {
    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      UserCredential result =
          await auth.signInWithCredential(phoneAuthCredential);
      final user = widget.user;
      user.uid = result.user!.uid;
      if (result.user != null) {
        final userCheck = await DBServices().getUserId(user.uid);
        if (userCheck == null) {
          await DBServices().saveUser(user);
        }
        setState(() {
          load = false;
        });
        Navigates.navigateAndReplace(context, const NavBar());
      }
      return true; // Authentification réussie
    } catch (e) {
      setState(() {
        load = false;
      });
      return false; // Une erreur s'est produite lors de l'authentification
    }
  }

  TextEditingController code = TextEditingController();
  late String currentText;
  bool load = false;
  int time = 60;
  bool resend = false;
  late Timer myTimer;

  get errorController => null;

  void startTimer() {
    myTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (time == 0) {
          setState(() {
            resend = true;
            timer.cancel();
          });
        } else {
          setState(() {
            time--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    myTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
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
                      const Text("Veillez renseigner le code OTP reçu par SMS"),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: width - 50,
                        child: PinCodeTextField(
                          length: 6,
                          keyboardType: TextInputType.phone,
                          obscureText: false,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            activeColor: Colors.green,
                            selectedColor:
                                const Color.fromARGB(255, 241, 3, 83),
                            inactiveColor:
                                const Color.fromARGB(255, 106, 1, 124),
                            selectedFillColor: Colors.transparent,
                            inactiveFillColor: Colors.transparent,
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            activeFillColor: Colors.white,
                          ),
                          animationDuration: const Duration(milliseconds: 300),
                          enableActiveFill: true,
                          errorAnimationController: errorController,
                          controller: code,
                          appContext: context,
                        ),
                      ),
                      resend
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton(
                                onPressed: () {
                                  resend = false;
                                  time = 30;
                                  startTimer();
                                },
                                child: const Text("Renvoyer le code"),
                              ),
                            )
                          : Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton(
                                onPressed: null,
                                child: Text("Renvoyer le code dans $time"),
                              ),
                            ),
                      const SizedBox(height: 20),
                      EBouton(
                        height: 45,
                        width: width - 40,
                        text: 'Continuer',
                        onTap: () async {
                          if (code != '') {
                            load = true;
                            setState(() {});
                            await signInWithPhoneAndSMSCode(
                              context,
                              widget.verificationId,
                              code.text,
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
          Visibility(
            visible: load,
            child: loading(context),
          ),
        ],
      ),
    );
  }
}
