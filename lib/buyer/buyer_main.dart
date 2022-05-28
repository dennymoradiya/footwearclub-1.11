import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:footwearclub/authentication/sign_up/auth_google.dart';
import 'package:footwearclub/buyer/pages/Account/account.dart';
import 'package:footwearclub/buyer/pages/Cart/cart.dart';
import 'package:footwearclub/buyer/pages/WishList/wishlist.dart';
import 'package:footwearclub/buyer/buyer_main_controller.dart';
import 'package:footwearclub/buyer/pages/serch/serch_screen.dart';
import 'package:footwearclub/constants/constant.dart';
import 'package:footwearclub/seller/constants/seller_constant.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'pages/Category/screen/buyer_category.dart';
import 'pages/home/buyer_home.dart';

class BuyerMainScreen extends StatefulWidget {
  const BuyerMainScreen({Key? key}) : super(key: key);

  @override
  _FootWearMainHomeState createState() => _FootWearMainHomeState();
}

class _FootWearMainHomeState extends State<BuyerMainScreen> {
  List pageList = [
    BuyerHomeScreen(),
    BuyerCategory(),
    WishList(),
    Cart(),
    Account()
    ];
    BuyerMainController _footWearMainHomeController =
        Get.put(BuyerMainController());

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Obx(
            () => Expanded(
              child: pageList[_footWearMainHomeController.currentIndex.value],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.065,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                    onTap: () {
                      _footWearMainHomeController.currentIndex.value = 0;
                    },
                    child: Obx(() => Icon(
                          Icons.home,
                          size: MediaQuery.of(context).size.width * 0.08,
                          color:
                              _footWearMainHomeController.currentIndex.value ==
                                      0
                                  ? kPrimaryLightColor
                                  : Colors.black,
                        ))),
                InkWell(
                    onTap: () {
                      _footWearMainHomeController.currentIndex.value = 1;
                    },
                    child: Obx(() => Icon(
                          MdiIcons.shopping,
                          size: MediaQuery.of(context).size.width * 0.08,
                          color:
                              _footWearMainHomeController.currentIndex.value ==
                                      1
                                  ? kPrimaryLightColor
                                  : Colors.black,
                        ))),
                InkWell(
                    onTap: () {
                      _footWearMainHomeController.currentIndex.value = 2;
                    },
                    child: Obx(
                      () => Icon(Icons.favorite_outlined,
                          color:
                              _footWearMainHomeController.currentIndex.value ==
                                      2
                                  ? kPrimaryLightColor
                                  : Colors.black,
                          size: MediaQuery.of(context).size.width * 0.08),
                    )),
                InkWell(
                  onTap: () {
                    _footWearMainHomeController.currentIndex.value = 3;
                  },
                  child: Obx(() => Icon(Icons.shopping_cart,
                      color: _footWearMainHomeController.currentIndex.value == 3
                          ? kPrimaryLightColor
                          : Colors.black,
                      size: MediaQuery.of(context).size.width * 0.08)),
                ),
                InkWell(
                  onTap: () {
                    _footWearMainHomeController.currentIndex.value = 4;
                  },
                  child: Obx(() => Icon(Icons.person_rounded,
                      color: _footWearMainHomeController.currentIndex.value == 4
                          ? kPrimaryLightColor
                          : Colors.black,
                      size: MediaQuery.of(context).size.width * 0.08)),
                ),
              ],
            ),
          )
        ],
      ),
       
    );
  }
}
