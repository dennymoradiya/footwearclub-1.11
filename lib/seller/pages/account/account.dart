import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:footwearclub/authentication/sign_up/auth_google.dart';
import 'package:footwearclub/constants/constant.dart';
import 'package:footwearclub/constants/screens/privacy_policy.dart';
import 'package:footwearclub/constants/screens/term_and_condition.dart';
import 'package:footwearclub/seller/pages/account/account_controller.dart';
import 'package:get/get.dart';
import 'about.dart';
import 'edit_account.dart';

String? uid;

class SellerAccount extends StatefulWidget {
  const SellerAccount({Key? key}) : super(key: key);

  @override
  _SellerAccountState createState() => _SellerAccountState();
}

class _SellerAccountState extends State<SellerAccount> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SellerAccountController sellerAccountController =
      Get.put(SellerAccountController());

      
  @override
  void initState() {
    super.initState();
    sellerAccountController.getaccountdetail();
    uid = firebaseAuth.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "Account",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Obx(
          () => sellerAccountController.isloading.value
              ? Center(
                  child: CircularProgressIndicator(
                    color: kPrimaryColor,
                  ),
                )
              : SingleChildScrollView(
                  child: Container(
                    width: Get.width,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Obx(() => Container(
                              height: 140,
                              width: 140,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: CachedNetworkImage(
                                  progressIndicatorBuilder:
                                      (context, url, progress) => Center(
                                    child: CircularProgressIndicator(
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                  imageUrl:
                                      sellerAccountController.myImgUrl.value,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 7,
                        ),
                        TextButton(
                          onPressed: () {
                            // Get.to(AccountDetail());
                            // setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SellerAccountDetail()));
                            // });
                          },
                          child: Text(
                            "Edit Account",
                            style:
                                TextStyle(color: kPrimaryColor, fontSize: 15),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Divider(
                                color: Colors.grey,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Name : ${sellerAccountController.myname.value.toString()}",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.grey,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Email : ${sellerAccountController.myemail.value.toString()}",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.grey,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Phone : ${sellerAccountController.myphone.value.toString()}",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.grey,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(SellerAboutPage());
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "About",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                      ),
                                      Icon(
                                        Icons.arrow_right,
                                        color: Colors.grey,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.grey,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(TermsCondition());
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Terms and Conditions",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                      ),
                                      Icon(
                                        Icons.arrow_right,
                                        color: Colors.grey,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.grey,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(PrivacyPolicy());
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Privacy Policy",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                      ),
                                      Icon(
                                        Icons.arrow_right,
                                        color: Colors.grey,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.grey,
                              ),
                              InkWell(
                                onTap: () {
                                  signOutGoogle();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.logout,
                                        color: kPrimaryColor,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "Sign Out",
                                        style: TextStyle(
                                            fontSize: 15, color: kPrimaryColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
        ));
  }
}
