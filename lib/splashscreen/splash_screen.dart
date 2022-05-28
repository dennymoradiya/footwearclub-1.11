import 'dart:async';
import 'package:flutter/material.dart';
import 'package:footwearclub/constants/constant.dart';
import 'package:footwearclub/splashscreen/splash.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
     Timer(const Duration(seconds: 3), () =>  Get.off(Splash_Screen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Container(
        width: Get.width,
        height: Get.height,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: Get.height * 0.28,
                    width: Get.height * 0.28,
                    child: Image.asset(
                      "assets/logo/icon.png",
                      color: kPrimaryColor,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    "Footwear Club",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
