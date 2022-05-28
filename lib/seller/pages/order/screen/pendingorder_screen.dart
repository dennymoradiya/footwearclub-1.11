import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:footwearclub/authentication/shred_pref.dart';
import 'package:footwearclub/constants/constant.dart';
import 'package:footwearclub/seller/constants/seller_constant.dart';
import 'package:footwearclub/seller/database/readytoship.dart';
import 'package:footwearclub/seller/models/readytoship_model.dart';
import 'package:footwearclub/seller/pages/order/controller/order_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controller/order_controller.dart';

class PendingOrder extends StatefulWidget {
  PendingOrder({Key? key}) : super(key: key);

  @override
  State<PendingOrder> createState() => _PendingOrderState();
}

Ordercontroller ordercontroller = Get.put(Ordercontroller());
Future getorder() async {
  await ordercontroller.getorder();
}

class _PendingOrderState extends State<PendingOrder> {
  @override
  void initState() {
    super.initState();
    readyToShipHelper.initializeDatabase();
    getorder();
  }

  Ordercontroller ordercontroller = Get.put(Ordercontroller());
  ReadyToShipHelper readyToShipHelper = ReadyToShipHelper();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Obx(() {
      return ordercontroller.orderlist.length > 0
          ? ListView.builder(
              itemCount: ordercontroller.orderlist.length,
              itemBuilder: (BuildContext context, int index) {
                var temptime = DateTime.parse(ordercontroller.orderlist[index]
                        ["time"]
                    .toDate()
                    .toString());
                String time = DateFormat('dd-MM-yyyy').format(temptime);
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 2, right: 2),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // if you need this
                      side: BorderSide(
                        color: Colors.grey.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Container(
                      height: Get.height * 0.40,
                      width: Get.width * 0.90,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(.1),
                            blurRadius: 40.0, // soften the shadow
                            spreadRadius: 10, //extend the shadow
                            offset: const Offset(
                              5.0, // Move to right 10  horizontally
                              5.0, // Move to bottom 10 Vertically
                            ),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(
                              // color: kPrimaryColor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      "Date : ${time.toString()}",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                              ordercontroller.orderlist[index]["name"],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    progressIndicatorBuilder:
                                        (context, url, progress) => Center(
                                      child: CircularProgressIndicator(
                                        color: kSellerPrimaryColor,
                                      ),
                                    ),
                                    height: 100,
                                    width: Get.width * 0.25,
                                    imageUrl: ordercontroller.orderlist[index]
                                        ["imgurl"],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Container(
                                width: size.width * 0.65,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("product Id",
                                              style: TextStyle(
                                                  color: Colors.black)),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Text(
                                              ordercontroller.orderlist[index]
                                                      ["orderid"]
                                                  .toString(),
                                              maxLines: 1,
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Divider(
                                        height: 3,
                                        color: Colors.grey,
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Quantity",
                                                style: TextStyle(
                                                    color: Colors.black)),
                                            Text(ordercontroller
                                                .orderlist[index]["quantity"]
                                                .toString()),
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                        height: 3,
                                        color: Colors.grey,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Size",
                                              style: TextStyle(
                                                  color: Colors.black)),
                                          Text(ordercontroller.orderlist[index]
                                              ["size"]),
                                        ],
                                      ),
                                      const Divider(
                                        height: 3,
                                        color: Colors.grey,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Price",
                                              style: TextStyle(
                                                  color: Colors.black)),
                                          Text(
                                              "${ordercontroller.orderlist[index]["price"]} ₹"),
                                        ],
                                      ),
                                      const Divider(
                                        height: 3,
                                        color: Colors.grey,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Total Amount",
                                            style:
                                                TextStyle(color: kPrimaryColor),
                                          ),
                                          Text(
                                            "${ordercontroller.orderlist[index]["totalamt"]} ₹"
                                                .toString(),
                                            style:
                                                TextStyle(color: kPrimaryColor),
                                          ),
                                        ],
                                      ),
                                      const Divider(
                                        height: 3,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: size.width * 0.42,
                                height: 45.0,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.red, // background
                                    onPrimary: Colors.black, // foreground
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.42,
                                height: 45.0,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.green, // background
                                    onPrimary: Colors.black, // foreground
                                  ),
                                  onPressed: () async {
                                    String address =
                                        "${ordercontroller.orderlist[index]["buyerdeatil"][0]["address"]},\n${ordercontroller.orderlist[index]["buyerdeatil"][0]["city"]},${ordercontroller.orderlist[index]["buyerdeatil"][0]["state"]},\n${ordercontroller.orderlist[index]["buyerdeatil"][0]["pincode"]}.";
                                    var readyToShipModel = ReadyToShipModel(
                                        buyerphone:
                                            ordercontroller.orderlist[index]
                                                ["buyerdeatil"][0]["phone"],
                                        buyeraddress: address,
                                        buyername: ordercontroller.orderlist[index]
                                            ["buyerdeatil"][0]["name"],
                                        date: time,
                                        orderid: ordercontroller.orderlist[index]
                                            ["orderid"],
                                        title: ordercontroller.orderlist[index]
                                            ["name"],
                                        price: ordercontroller.orderlist[index]
                                                ["price"]
                                            .toString(),
                                        imgurl: ordercontroller.orderlist[index]
                                            ["imgurl"],
                                        quantity: ordercontroller.orderlist[index]["quantity"].toString(),
                                        size: ordercontroller.orderlist[index]["size"],
                                        totalamt: ordercontroller.orderlist[index]["totalamt"].toString());

                                    PrefManager prefManager =
                                        Get.put(PrefManager());
                                    await prefManager
                                        .getdashbord()
                                        .then((value) async {
                                      Map dashdata = {
                                        "sales":
                                            prefManager.dashboard["sales"] +
                                                ordercontroller.orderlist[index]
                                                    ["totalamt"],
                                        "revenue":
                                            prefManager.dashboard["revenue"] +
                                                ordercontroller.orderlist[index]
                                                    ["totalamt"]
                                      };
                                      await prefManager.setdashbord(dashdata);
                                    });

                                    readyToShipHelper
                                        .insertData(readyToShipModel);
                                    await ordercontroller.deleteorder(
                                      ordercontroller.orderlist[index]
                                          ["orderid"],
                                    );
                                    ordercontroller.orderlist.removeAt(index);
                                  },
                                  child: const Text(
                                    'Accept',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Text(
              "No Order Found !",
              style: TextStyle(
                color: kPrimaryColor,
              ),
            ));
    });
  }
}
