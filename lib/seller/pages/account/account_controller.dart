import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseStorage firebaseStorage = FirebaseStorage.instance;
FirebaseAuth firebaseAuth = FirebaseAuth.instance;
var uid = firebaseAuth.currentUser?.uid;
setname(String newname) async {
  await firestore
      .collection("seller")
      .doc(uid)
      .update({"name": newname});
}

setemail(String newname) async{
 await firestore.collection("seller").doc(uid).update({"email": newname});
}

setphone(String newname) async{
 await firestore.collection("seller").doc(uid).update({"phone": newname});
}

setimage(String newname)async {
 await firestore.collection("seller").doc(uid).update({"imageUrl": newname});
}

class SellerAccountController extends GetxController {
  RxString myImgUrl = "".obs;
  RxString myname = "".obs;
  RxString myemail = "".obs;
  RxString myphone = "".obs;
  RxBool isloading = true.obs;

  void getaccountdetail() async {
    var data = await firestore
        .collection("seller")
        .doc(firebaseAuth.currentUser!.uid)
        .get();
    myImgUrl.value = data["imageUrl"];
    myemail.value = data["email"];
    myname.value = data["name"];
    myphone.value = data["phone"];
    isloading.value = false;
  }
}
