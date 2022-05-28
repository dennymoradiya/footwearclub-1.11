import 'package:flutter/material.dart';
import 'package:footwearclub/buyer/buyer_main.dart';
import 'package:footwearclub/constants/constant.dart';
import 'package:footwearclub/constants/size_mediaquery.dart';
import 'package:get/get.dart';

class Login_succes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.04),
          Image.asset(
            "assets/animation/sucess.gif",
            height: SizeConfig.screenHeight * 0.4,
            width: Get.width,
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.08),
          Text(
            "Login Success",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(30),
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          SizedBox(
            width: SizeConfig.screenWidth * 0.6,
            child: DefaultButton(
              text: "Back to home",
              press: () {
                Get.offAll(BuyerMainScreen());
              },
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
