import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:footwearclub/authentication/shred_pref.dart';
import 'package:get/get.dart';

class Ordercontroller extends GetxController {
  RxList orderlist = [].obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> getorder() async {
    orderlist.clear();
    CollectionReference data = firestore
        .collection("seller")
        .doc(auth.currentUser?.uid)
        .collection("orders");
    QuerySnapshot datasnapshort = await data.get();
    datasnapshort.docs.map((element) {
      Map ordertdata = element.data() as Map;
      orderlist.add(ordertdata);
    }).toList();
  }

  Future<void> deleteorder(String id) async {
    firestore
        .collection("seller")
        .doc(await getUid())
        .collection("orders")
        .doc(id)
        .delete();
  }
}
