import 'package:flutter/material.dart';
import 'package:footwearclub/authentication/shred_pref.dart';
import 'package:footwearclub/authentication/sign_in/login.dart';
import 'package:footwearclub/authentication/sign_up/auth_google.dart';
import 'package:footwearclub/constants/screens/privacy_policy.dart';
import 'package:footwearclub/constants/screens/term_and_condition.dart';
import 'package:footwearclub/constants/size_mediaquery.dart';
import 'package:footwearclub/seller/constants/logout.dart';
import 'package:footwearclub/seller/constants/seller_constant.dart';
import 'package:footwearclub/seller/controller.dart';
import 'package:footwearclub/seller/pages/account/account.dart';
import 'package:footwearclub/seller/pages/dashboard/dashbord_screen.dart';
import 'package:footwearclub/seller/pages/order/screen/order_screen.dart';
import 'package:footwearclub/seller/pages/products/products.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SellerDrawer extends StatelessWidget {
  const SellerDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SellerController sellerController = Get.put(SellerController());
    return Drawer(
      child: ListView(
        
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            
            title: Obx(() => Text(
                  sellerController.sellerName.value,
                  style: TextStyle(color: Colors.white, fontSize: 22),
                )),
            tileColor: kSellerPrimaryColor,
          ),
          InkWell(
            onTap: () {
              Get.to(DashbordScreen());
            },
            child: ListTile(
              leading: Icon(Icons.dashboard_rounded),
              title: Text('Dashboard'),
            ),
          ),
          
          InkWell(
            onTap: () {
              Get.to(Products());
            },
            child: ListTile(
              leading: Icon(Icons.inventory_2_rounded),
              title: Text('Products'),
            ),
          ),
          // InkWell(
          //   onTap: () {
          //     Get.to(OrderScreen());
          //   },
          //   child: ListTile(
          //     leading: Icon(MdiIcons.viewList),
          //     title: Text('Orders'),
          //   ),
          // ),
          InkWell(
            onTap: () {
              Get.to(SellerAccount());
            },
            child: ListTile(
              leading: Icon(Icons.account_circle,size: 27,),
              title: Text('Profile'),
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(PrivacyPolicy());
            },
            child: ListTile(
              leading: Icon(Icons.privacy_tip),
              title: Text('Privacy Policy'),
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(TermsCondition());
            },
            child: ListTile(
              leading: Icon(MdiIcons.noteCheck),
              title: Text('Terms & Conditions'),
            ),
          ),
          InkWell(
            onTap: ()  {
              logOut(context);
            },
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
            ),
          ),
        ],
      ),
    );
  }
}
