import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:footwearclub/buyer/pages/serch/serch_screen.dart';
import 'package:footwearclub/constants/constant.dart';
import 'package:footwearclub/seller/constants/seller_constant.dart';
import 'package:footwearclub/seller/controller.dart';
import 'package:footwearclub/seller/pages/dashboard/dashboard_controller.dart';
import 'package:footwearclub/seller/pages/dashboard/dashbord_screen.dart';
import 'package:get/get.dart';
import 'pages/account/account.dart';
import 'pages/order/controller/order_controller.dart';
import 'pages/order/screen/order_screen.dart';
import 'pages/products/get_product.dart';
import 'pages/products/products.dart';

class SellerMainScreen extends StatefulWidget {
  const SellerMainScreen({Key? key}) : super(key: key);

  @override
  State<SellerMainScreen> createState() => _SellerMainScreenState();
}

class _SellerMainScreenState extends State<SellerMainScreen> {
  int _selectedIndex = 0;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  List pages = [DashbordScreen(), Products(), OrderScreen(), SellerAccount()];
  SellerController sellerController = Get.put(SellerController());
  Dashboardcontroller dashboardcontroller = Get.put(Dashboardcontroller());
  Ordercontroller ordercontroller = Get.put(Ordercontroller());

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    getProduct();
    sellerController.getSellerName();
    ordercontroller.getorder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 17,
        selectedIconTheme:
            const IconThemeData(color: kSellerPrimaryColor, size: 30),
        selectedItemColor: kSellerPrimaryColor,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedItemColor: Colors.black,
        unselectedIconTheme: const IconThemeData(
          color: kSellerPrimaryColor,
        ),
        unselectedLabelStyle: TextStyle(color: Colors.black),
        unselectedFontSize: 17,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/store.svg",
              color: kSellerPrimaryColor,
              height: 33,
            ),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/account-circle.svg",
              color: kSellerPrimaryColor,
              height: 33,
            ),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex, //New
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
     
    );
  }
}
