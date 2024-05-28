import 'package:chatapp/BD/auth.dart';
import 'package:chatapp/BD/bd.dart';
import 'package:chatapp/Modeles/Utilisateur.dart';
import 'package:chatapp/Vues/navBar.dart';
import 'package:chatapp/Vues/splach.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: apiKey,
      appId: appId,
      messagingSenderId: messagingSenderId,
      projectId: projectId,
    ),
  );
  runApp(const MyApp());
}

void getUser() async {
  Utilisateur.user = await DBServices().getUserId(AuthService().user.uid);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    getUser();
    Utilisateur.loadUsersFromLocalStorage();
    final auth = FirebaseAuth.instance;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StreamBuilder<User?>(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          return snapshot.data == null ? const Splach() : const NavBar();
        },
      ),
    );
  }
}
