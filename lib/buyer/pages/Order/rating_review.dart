import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:footwearclub/buyer/database/cart_db.dart';
import 'package:footwearclub/buyer/pages/Order/myorder_controller.dart';
import 'package:get/get.dart';
import 'package:rating_dialog/rating_dialog.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseAuth firebaseAuth = FirebaseAuth.instance;

void submitReview(productData, rating, comment) {
  var sellerid = productData["sellerid"];
 MyOrderController myOrderController = Get.put(MyOrderController());
  firestore
      .collection("seller")
      .doc(sellerid)
      .collection("reviews")
      .doc(productData["orderid"])
      .set({
    "orderid": productData["orderid"],
    "sellerid": productData["sellerid"],
    "rating": rating,
    "comment": comment,
  }).then((value) => print("seller review added..."));

  firestore
      .collection("buyer")
      .doc(firebaseAuth.currentUser!.uid)
      .collection("orders")
      .doc(productData["orderid"])
      .update({"rating": rating}).then((value) {
        myOrderController.getmyOrder();
      });
}

Widget ratingDialog(productData) {
  print(productData);
  return RatingDialog(
    initialRating: 0.0,
    title: Text(
      'Please rate & review our products',
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    submitButtonText: 'Submit',
    commentHint: 'Write Something...',
    onCancelled: () => print('cancelled'),
    onSubmitted: (response) {
      var rating = response.rating;
      var comment = response.comment;
      print('rating: ${response.rating}, comment: ${response.comment}');
      submitReview(productData, rating, comment);
    },
  );
}
