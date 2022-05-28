import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../shred_pref.dart';
import 'auth_google.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<String> createUserwithEmail(name, email, phone, pass) async {
  String val = "";
  String imageUrl =
      "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/extra%2Fuser.png?alt=media&token=d8759c7a-1a73-4dc5-888b-4670ec21a511";
  try {
    UserCredential authResult = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: pass);

    final User? user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);
      final User? currentUser = authResult.user;
      assert(user.uid == currentUser!.uid);
      assert(user.email != null);

      if (googlecontroller.usertype.value == "buyer") {
        try {
          await _firestore.collection('buyer').doc(authResult.user!.uid).set({
            "uid": _auth.currentUser!.uid,
            "name": name,
            "email": email,
            "phone": phone,
            "imageUrl": imageUrl,
            "usertype": googlecontroller.usertype.value
          });
        } catch (e) {
          print("error buyer data : $e");
        }
      } else {
        try {
          await _firestore.collection('seller').doc(authResult.user!.uid).set({
            "uid": _auth.currentUser!.uid,
            "name": name,
            "email": email,
            "phone": phone,
            "imageUrl": imageUrl,
            "usertype": googlecontroller.usertype.value,
            "businessname": ""
          });
        } catch (e) {
          print("error seller : $e");
        }
      }

      setAccountObject(
          uid: user.uid,
          name: name,
          email: email,
          phone: phone,
          imageURL: imageUrl,
          usertype: googlecontroller.usertype.value);
      setLoggedIn();
      return "$user";
    }

    print(authResult.user);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'email-already-in-use') {
      val = 'Email already exists';
      return val;
    }
  } catch (e) {
    print(e);
  }
  return val;
}

