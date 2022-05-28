import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:footwearclub/buyer/pages/Order/myorder_controller.dart';
import 'package:footwearclub/constants/constant.dart';
import 'package:footwearclub/seller/constants/seller_constant.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'rating_review.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  MyOrderController myOrderController = Get.put(MyOrderController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        title: Text(
          "My Orders",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 22,
          ),
        ),
      ),
      body: Obx(
        () => myOrderController.myorderlist.length != 0
            ? ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: myOrderController.myorderlist.length,
                itemBuilder: (BuildContext context, int index) {
                  var myorder = myOrderController.myorderlist[index];
                  var temptime = DateTime.parse(myOrderController
                      .myorderlist[index]["time"]
                      .toDate()
                      .toString());
                  String orderdt = DateFormat('dd-MM-yyyy').format(temptime);
                  // getRating(myorder);
                  return Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 4,
                            blurRadius: 6,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          15,
                        )),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5.0,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  progressIndicatorBuilder:
                                      (context, url, progress) => Center(
                                    child: CircularProgressIndicator(
                                      color: kSellerPrimaryColor,
                                    ),
                                  ),
                                  height: Get.height * 0.13,
                                  width: Get.width * 0.24,
                                  imageUrl: myorder["imgurl"],
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 10),
                              child: Container(
                                width: Get.width * 0.60,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        myorder["name"].toString(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Size: ${myorder["size"]}"),
                                        Text("x ${myorder["quantity"]}"),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text("₹${myorder["price"]}"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${myorder["quantity"]} item"),
                              Container(
                                child: Row(
                                  children: [
                                    Text(
                                      "Order Total: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    Text("₹${myorder["totalamt"]}",
                                        style: TextStyle(
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Order Date:\n${orderdt}",
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                              myorder["rating"] == ""
                                  ? ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          barrierDismissible:
                                              true, // set to false if you want to force a rating
                                          builder: (context) =>
                                              ratingDialog(myorder),
                                        );
                                      },
                                      child: Text("Add Review"),
                                      style: ElevatedButton.styleFrom(
                                        primary: kPrimaryColor,
                                        shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(5.0),
                                        ),
                                      ),
                                    )
                                  // : Text(myorder["rating"].toString())
                                  : RatingBar.builder(
                                      initialRating: double.parse(
                                          myorder["rating"].toString()),
                                      minRating: 1,
                                      itemSize: 25,
                                      tapOnlyMode: false,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 2.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 15,
                                      ),
                                      ignoreGestures: true,
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              ),
      ),
    );
    // return Scaffold(
    //   body: FutureBuilder(
    //     future: FirebaseFirestore.instance
    //         .collection("buyer")
    //         .doc(FirebaseAuth.instance.currentUser!.uid)
    //         .collection("orders")
    //         .get(),
    //     builder: (BuildContext context, AsyncSnapshot snapshot) {
    //       if (snapshot.connectionState == ConnectionState.done) {
    //         if (snapshot.data != null) {
    //           QuerySnapshot data = snapshot.data;
    //           List myOrder = [];
    //           data.docs.map((e) {
    //             var orderdata = e.data();
    //             print(orderdata);
    //             myOrder.add(orderdata);
    //           }).toList();
    //           return ListView.builder(
    //             itemCount: myOrder.length,
    //             itemBuilder: (BuildContext context, int index) {
    //               print(myOrder);
    //               if (myOrder.isEmpty) {
    //                 return Center(
    //                   child: Text("not orders!"),
    //                 );
    //               }
    //               return Center(
    //                 child: Text(myOrder[index]["name"]),
    //               );
    //             },
    //           );
    //         }
    //       }
    //       return Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     },
    //   ),
    // );
 
  }
}
