import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:footwearclub/constants/constant.dart';
import 'package:footwearclub/constants/size_mediaquery.dart';
import 'package:footwearclub/seller/seller_main.dart';
import 'package:get/get.dart';

var collection = FirebaseFirestore.instance.collection('seller');
final FirebaseAuth _auth = FirebaseAuth.instance;

TextEditingController businesscontroller = TextEditingController(text: '');
final String uid = _auth.currentUser!.uid;

void updateBusiness() {
  collection
      .doc(uid)
      .update({'businessname': businesscontroller.text}).then((_) {
    print('Update business ${businesscontroller.text}');
    Get.back();
    Get.offAll(SellerMainScreen());
  }).catchError((error) => print('Update failed: $error'));
}

Future bussinessNameDialog(context) {
  final formKey = GlobalKey<FormState>();
  return showModalBottomSheet(
      context: context,
      // barrierColor: popupBackground,
      isScrollControlled: true, // only work on showModalBottomSheet function
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      builder: (context) => Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: SizeConfig.screenHeight * 0.4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Enter Your Bussiness",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: buildBussinessNameFormField(
                          businesscontroller, formKey),
                    ),
                    DefaultButton(
                      text: "Done",
                      press: () {
                        if (formKey.currentState!.validate()) {
                          print(businesscontroller.text);
                          updateBusiness();
                        }
                      },
                    ),
                  ],
                ),
              ), //height or you can use Get.width-100 to set height
            ),
          ));
}

Form buildBussinessNameFormField(businesscontroller, key) {
  return Form(
    key: key,
    child: TextFormField(
      controller: businesscontroller,
      cursorColor: kPrimaryColor,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your business';
        }
        return null;
      },
      decoration: const InputDecoration(
        hintText: "Your Business name",
        labelStyle: TextStyle(color: kPrimaryColor),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    ),
  );
}
