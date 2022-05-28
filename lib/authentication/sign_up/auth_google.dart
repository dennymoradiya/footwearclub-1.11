import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:footwearclub/authentication/sign_in/logincontroller.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../shred_pref.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;

FirebaseFirestore _firestore = FirebaseFirestore.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
final Future<FirebaseApp> _initialization = Firebase.initializeApp();
Googlecontroller googlecontroller = Get.put(Googlecontroller());

late String name;
late String email;
late String imageUrl;
late String uid;
late String phone;
// late int sId;

void signOutGoogle() async {
  await googleSignIn.signOut();
 await _auth.signOut();
  removeLoggedIn();
  print("User Signed Out");
}

Future<String?> signInWithGoogle() async {
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult =
      await _auth.signInWithCredential(credential);

  final User? user = authResult.user;

  if (user != null) {
    assert(!user.isAnonymous);
    final User? currentUser = _auth.currentUser;
    assert(user.uid == currentUser!.uid);
    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoURL != null);

    // Store the retrieved data
    name = user.displayName!;
    email = user.email!;
    imageUrl = user.photoURL!;
    if (user.phoneNumber==null) {
      phone ="";
    } 
    else
    {
    phone = user.phoneNumber!;

    }

    if (googlecontroller.usertype.value == "buyer") {
      try {
        await _firestore.collection('buyer').doc(_auth.currentUser!.uid).set({
          "uid": _auth.currentUser!.uid,
          "name": name,
          "email": email,
          "phone" : phone,
          "imageUrl": imageUrl,
          "usertype": googlecontroller.usertype.value
        });
      } catch (e) {
        print("error buyer data : $e");
      }
    } else {
      try {
        await _firestore.collection('seller').doc(_auth.currentUser!.uid).set({
          "uid": _auth.currentUser!.uid,
          "name": name,
          "email": email,
          "phone" : phone,
          "imageUrl": imageUrl,
          "usertype": googlecontroller.usertype.value,
          "businessname" : ""
        });
      } catch (e) {
        print("error seller : $e");
      }
    }

    setAccountObject(
        uid: user.uid,
        name: user.displayName,
        email: user.email,
        phone: user.phoneNumber,
        imageURL: user.photoURL,
        usertype: googlecontroller.usertype.value);
    setLoggedIn();
    return "$user";
  }

  return null;
}