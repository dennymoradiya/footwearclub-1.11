
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:footwearclub/seller/pages/products/products_controller.dart';
import 'package:get/get.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
ProductController productController = Get.put(ProductController());
 FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  
Future<void> getProduct() async {
   productController.productData.clear();
    var userId = firebaseAuth.currentUser!.uid;
    CollectionReference mencollectionRef1 = firestore
        .collection("seller")
        .doc(userId)
        .collection("product")
        .doc("Man")
        .collection("Shoes");
    QuerySnapshot manquerySnapshot1 = await mencollectionRef1.get();
    manquerySnapshot1.docs.map((doc) {
      Map data = doc.data() as Map;
      productController.productData.add(data);
    }).toList();

    CollectionReference mencollectionRef2 = firestore
        .collection("seller")
        .doc(userId)
        .collection("product")
        .doc("Man")
        .collection("Sandals");
    QuerySnapshot manquerySnapshot2 = await mencollectionRef2.get();
    manquerySnapshot2.docs.map((doc) {
      Map data = doc.data() as Map;
      productController.productData.add(data);
    }).toList();

    CollectionReference mencollectionRef3 = firestore
        .collection("seller")
        .doc(userId)
        .collection("product")
        .doc("Man")
        .collection("Slippers");
    QuerySnapshot manquerySnapshot3 = await mencollectionRef3.get();
    manquerySnapshot3.docs.map((doc) {
      Map data = doc.data() as Map;
      productController.productData.add(data);
    }).toList();

    CollectionReference womencollectionRef1 = firestore
        .collection("seller")
        .doc(userId)
        .collection("product")
        .doc("Woman")
        .collection("Shoes");
    QuerySnapshot womanquerySnapshot1 = await womencollectionRef1.get();
    womanquerySnapshot1.docs.map((doc) {
      Map data = doc.data() as Map;
      productController.productData.add(data);
    }).toList();

    CollectionReference womencollectionRef2 = firestore
        .collection("seller")
        .doc(userId)
        .collection("product")
        .doc("Woman")
        .collection("Sandals");
    QuerySnapshot womanquerySnapshot2 = await womencollectionRef2.get();
    womanquerySnapshot2.docs.map((doc) {
      Map data = doc.data() as Map;
      productController.productData.add(data);
    }).toList();

    CollectionReference womencollectionRef3 = firestore
        .collection("seller")
        .doc(userId)
        .collection("product")
        .doc("Woman")
        .collection("Heels");
    QuerySnapshot womanquerySnapshot3 = await womencollectionRef3.get();
    womanquerySnapshot3.docs.map((doc) {
      Map data = doc.data() as Map;
      productController.productData.add(data);
    }).toList();

    CollectionReference chilcollectionRef1 = firestore
        .collection("seller")
        .doc(userId)
        .collection("product")
        .doc("Children")
        .collection("Shoes");
    QuerySnapshot chquerySnapshot1 = await chilcollectionRef1.get();
    chquerySnapshot1.docs.map((doc) {
      Map data = doc.data() as Map;
      productController.productData.add(data);
    }).toList();

    CollectionReference chilcollectionRef2 = firestore
        .collection("seller")
        .doc(userId)
        .collection("product")
        .doc("Children")
        .collection("Sandals");
    QuerySnapshot chquerySnapshot2 = await chilcollectionRef2.get();
    chquerySnapshot2.docs.map((doc) {
      Map data = doc.data() as Map;
      productController.productData.add(data);
    }).toList();

    CollectionReference chilcollectionRef3 = firestore
        .collection("seller")
        .doc(userId)
        .collection("product")
        .doc("Children")
        .collection("Boot");
    QuerySnapshot chquerySnapshot3 = await chilcollectionRef3.get();
    chquerySnapshot3.docs.map((doc) {
      Map data = doc.data() as Map;
      productController.productData.add(data);
    }).toList();
  }
