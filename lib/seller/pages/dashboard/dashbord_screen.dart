import 'package:flutter/material.dart';
import 'package:footwearclub/authentication/shred_pref.dart';
import 'package:footwearclub/constants/constant.dart';
import 'package:footwearclub/seller/constants/seller_constant.dart';
import 'package:footwearclub/seller/pages/order/controller/order_controller.dart';
import 'package:footwearclub/seller/pages/products/products_controller.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../controller.dart';
import 'dashboard_controller.dart';

class DashbordScreen extends StatefulWidget {
  DashbordScreen({Key? key}) : super(key: key);
  @override
  State<DashbordScreen> createState() => _DashbordScreenState();
}

class _DashbordScreenState extends State<DashbordScreen> {
  SellerController sellerController = Get.put(SellerController());
  Dashboardcontroller dashboardcontroller = Get.put(Dashboardcontroller());
  ProductController productController = Get.put(ProductController());
  PrefManager prefManager = Get.put(PrefManager());
  void getdashboard() async {
    print("get dashbord call from dash screen");
    await prefManager.getdashbord();
    dashboardcontroller.getrating();
    sellerController.getSellerName();
  }

  Ordercontroller ordercontroller = Get.put(Ordercontroller());
  @override
  void initState() {
    super.initState();
    getdashboard();
  }
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    setState(() {
      getdashboard();
    });
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: kSellerPrimaryColor,
        elevation: 0,
      ),
      // drawer: SellerDrawer(),
      body: SmartRefresher(
       controller: _refreshController,
        onRefresh: _onRefresh,
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 20.0),
                  height: Get.height * 0.3,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(63, 45),
                    ),
                    color: kPrimaryColor,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 110, left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Monthly Revenue",
                          style: TextStyle(color: Colors.white70),
                        ),
                        Obx(() {
                          return Text(
                            prefManager.dashboard["revenue"].toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          );
                        }),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.only(
                    top: 5,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Hello,\n${sellerController.sellerName.value}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: sellerController.imgurl.value != ""
                                ? CircleAvatar(
                                    radius: 28,
                                    backgroundImage: NetworkImage(
                                        '${sellerController.imgurl.value}'))
                                : Container(),
                            radius: 30,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25, left: 25, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Overview",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18),
                  ),
                ],
              ),
            ),
            //boxes
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Card(
                    elevation: 5,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                        side: BorderSide(width: 5, color: kSellerPrimaryColor)),
                    child: Container(
                      height: 110,
                      width: size.width * 0.45,
                      child: Card(
                        elevation: 6.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Orders",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Obx(() => Text(
                                    ordercontroller.orderlist.length.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        side: BorderSide(width: 5, color: kSellerPrimaryColor)),
                    child: Container(
                      height: 110,
                      width: size.width * 0.45,
                      child: Card(
                        elevation: 6.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Total Sales",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Obx(() => Text(
                                    prefManager.dashboard["sales"].toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                          side: BorderSide(width: 5, color: kSellerPrimaryColor)),
                      child: Container(
                        height: 110,
                        width: size.width * 0.45,
                        child: Card(
                          elevation: 6.0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text(
                                  "Shop Rating",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Obx(() => dashboardcontroller.rating.value !=
                                            double.nan
                                        ? Text(
                                            dashboardcontroller.rating
                                                .toStringAsFixed(1),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          )
                                        : Text(
                                            "0 ",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          )),
                                    Icon(Icons.star),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 5,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                          side: BorderSide(width: 5, color: kSellerPrimaryColor)),
                      child: Container(
                        height: 110,
                        width: size.width * 0.45,
                        child: Card(
                          elevation: 6.0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Total Product",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Obx(() => Text(
                                      productController.productData.length
                                          .toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
