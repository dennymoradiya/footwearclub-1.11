import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SellerController extends GetxController{
  RxInt currentIndex = 0.obs;
  RxString sellerName = "".obs;
  RxString imgurl = "".obs;


  void getSellerName() async{
    var collection = FirebaseFirestore.instance.collection('seller');
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    firebaseAuth.currentUser!.uid;
    //  getUid().then((value) async {
     await collection.doc( firebaseAuth.currentUser!.uid).get().then((DocumentSnapshot ds) {
        Map data = ds.data() as Map;
        sellerName.value = data["businessname"];
        imgurl.value= data["imageUrl"];
      });
    // });
  }
} 



