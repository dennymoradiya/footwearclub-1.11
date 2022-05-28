

import 'package:firebase_auth/firebase_auth.dart';

Future<String> signInwithEmail(email,pass) async {
  String message= "";
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: email, password: pass);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      message= 'User Not Registered';
      return message;
    } else if (e.code == 'wrong-password') {
      message= 'Your password is wrong';
      return message;
    }

  }
  return message ="";
}
