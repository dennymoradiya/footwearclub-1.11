import 'package:firebase_auth/firebase_auth.dart';
import 'package:footwearclub/authentication/shred_pref.dart';
import 'package:footwearclub/authentication/sign_up/auth_google.dart';
import 'package:footwearclub/splashscreen/buyorsell.dart';
import 'package:get/get.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

void logOut(context) async {
  await googleSignIn.signOut();
  await _auth.signOut();
  removeLoggedIn().then((value) {
    print("User Signed Out");
    scafoldmessage(context, "You have been Logout!");
    Get.offAll(Buyorsale());
  });
}
