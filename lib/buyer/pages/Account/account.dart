import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:footwearclub/authentication/sign_up/auth_google.dart';
import 'package:footwearclub/buyer/pages/Account/account_controller.dart';
import 'package:footwearclub/buyer/pages/Order/my_order.dart';
import 'package:footwearclub/constants/constant.dart';
import 'package:footwearclub/constants/screens/privacy_policy.dart';
import 'package:footwearclub/constants/screens/term_and_condition.dart';
import 'package:get/get.dart';
import 'about.dart';
import 'edit_account.dart';

String? uid;

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);
  
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  AccountController accountController = Get.put(AccountController());
  @override
  void initState() {
    super.initState();
    accountController.getaccountdetail();
  }

  @override
  Widget build(BuildContext context) {
    uid = firebaseAuth.currentUser!.uid;
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
          () => accountController.isloading.value
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
                                  imageUrl: accountController.myImgUrl.value,
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
                                    builder: (_) => AccountDetail()));
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
                                      "Name : ${accountController.myname.value.toString()}",
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
                                      "Email : ${accountController.myemail.value.toString()}",
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
                                      "Phone : ${accountController.myphone.value.toString()}",
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
                                  Get.to(MyOrders());
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
                                        "My Orders",
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
                                  Get.to(AboutPage());
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
