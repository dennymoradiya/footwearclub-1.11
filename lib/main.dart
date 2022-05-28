import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:footwearclub/buyer/buyer_main.dart'; 
import 'package:footwearclub/seller/database/readytoship.dart';
import 'package:footwearclub/seller/seller_main.dart';
import 'package:footwearclub/splashscreen/splash.dart';
import 'package:get/get.dart';
import 'authentication/shred_pref.dart';
import 'buyer/database/cart_db.dart';
import 'buyer/database/wishlish_db.dart';
import 'buyer/pages/home/buyer_home_controller.dart';
import 'constants/theme.dart';
import 'dart:async';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false;
  // ..dismissOnTap = false
  // ..customAnimation = CustomAnimation();
}

void initializeDatabase() {
  ReadyToShipHelper readyToShipHelper = ReadyToShipHelper();
  WishListHelper wishListHelper = WishListHelper();
  CartHelper cartHelper = CartHelper();
  wishListHelper.initializeDatabase();
  cartHelper.initializeDatabase();
  readyToShipHelper.initializeDatabase();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp(
      defaultHome: (true == await getLoggedIn())
          ? await getUsertype() == "seller"
              ? SellerMainScreen()
              : BuyerMainScreen()
          : Splash_Screen()));
  configLoading();
  initializeDatabase();
  PrefManager prefManager = Get.put(PrefManager());
  BuyerHomeController buyerHomeController = Get.put(BuyerHomeController());
  await prefManager.getlastserch();
  await buyerHomeController.get30product();
  buyerHomeController.getserchproduct(prefManager.serchlist).whenComplete(() {
    buyerHomeController.isserchdataload.value = true;
  });

  buyerHomeController.productlist.isEmpty
      ? await buyerHomeController.getproduct().whenComplete(() {
          buyerHomeController.isdataload.value = true;
        })
      : null;
}

class MyApp extends StatelessWidget {
  final Widget? defaultHome;
  const MyApp({Key? key, this.defaultHome}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Footwear Club',
      theme: theme(),
      home: defaultHome,
      builder: EasyLoading.init(),
    );
  }
}
