import 'package:flutter/material.dart';
import 'package:footwearclub/buyer/buyer_main.dart';
import 'package:footwearclub/buyer/database/cart_db.dart';
import 'package:footwearclub/constants/constant.dart';
import 'package:footwearclub/constants/size_mediaquery.dart';
import 'package:get/get.dart';

class OrderSuccess extends StatefulWidget {
  @override
  State<OrderSuccess> createState() => _OrderSuccessState();
}

class _OrderSuccessState extends State<OrderSuccess> {
  CartHelper cartHelper = CartHelper();

  @override
  void initState() {
    super.initState();
    cartHelper.initializeDatabase();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().initsize(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.04),
          Image.asset(
            "assets/animation/sucess.gif",
            height: SizeConfig.screenHeight * 0.4,
            width: Get.width,
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.08),
          Text(
            "Order Placed Sucessfully !",
            textAlign: TextAlign.center,
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
              text: "Go to home",
              press: () {
                cartHelper.deleteTable();
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
