import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class MyOrderController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  RxList myorderlist = [].obs;

  Future getmyOrder() async {
    myorderlist.clear();
    print(firebaseAuth.currentUser!.uid);
    CollectionReference data = firebaseFirestore
        .collection("buyer")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("orders");
    QuerySnapshot datasnapshort = await data.get();
    datasnapshort.docs.map((element) {
      Map ordertdata = element.data() as Map;
      myorderlist.add(ordertdata);
    }).toList();
  }
}
