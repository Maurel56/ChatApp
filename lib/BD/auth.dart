// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  User get user => FirebaseAuth.instance.currentUser!;

  void signOut() async {
    await auth.signOut();
  }
}
