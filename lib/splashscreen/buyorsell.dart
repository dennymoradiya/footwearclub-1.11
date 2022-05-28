import 'package:flutter/material.dart';
import 'package:footwearclub/authentication/sign_in/logincontroller.dart';
import 'package:footwearclub/authentication/sign_up/signup.dart';
import 'package:footwearclub/constants/size_mediaquery.dart';
import 'package:get/get.dart';
import '../constants/constant.dart';

class Buyorsale extends StatelessWidget {
  Buyorsale({Key? key}) : super(key: key);
  final Googlecontroller googlecontroller = Get.put(Googlecontroller());

  @override
  Widget build(BuildContext context) {
    SizeConfig().initsize(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "FootWear Club",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(36),
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "Are You Buyer Or Seller ? ",
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          
          Image.asset(
            "assets/images/buyerseller.png",
            height: getProportionateScreenHeight(265),
            width: getProportionateScreenWidth(235),
          ),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.07,
                child: TextButton(
                  onPressed: () {
                    googlecontroller.usertype.value = "buyer";
                    Get.to(Signup_Screen());
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    primary: Colors.white,
                    backgroundColor: kPrimaryColor,
                  ),
                  child: Text(
                    "Buyer",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      color: Colors.white,
                    ),
                  ),
                )),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SizedBox(
                width: double.infinity,
                height: getProportionateScreenHeight(56),
                child: TextButton(
                  onPressed: () {
                    googlecontroller.usertype.value = "seller";
                    Get.to(Signup_Screen());
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    primary: Colors.white,
                    backgroundColor: kPrimaryColor,
                  ),
                  child: Text(
                    "Seller",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      color: Colors.white,
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}