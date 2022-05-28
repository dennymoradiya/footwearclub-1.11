import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:footwearclub/buyer/pages/ProductDescription/product_description.dart';
import 'package:footwearclub/buyer/pages/home/buyer_home_controller.dart';
import 'package:footwearclub/constants/constant.dart';
import 'package:footwearclub/seller/constants/seller_constant.dart';
import 'package:get/get.dart';

class ViewallcategoryScreen extends StatefulWidget {
  final String screentitle;
  final String subtype;
  final String maintype;
  final String gender;

  ViewallcategoryScreen(
      {Key? key,
      required this.screentitle,
      required this.subtype,
      required this.maintype,
      required this.gender})
      : super(key: key);

  @override
  State<ViewallcategoryScreen> createState() => _ViewallcategoryScreenState();
}

BuyerHomeController buyerHomeController = Get.put(BuyerHomeController());

class _ViewallcategoryScreenState extends State<ViewallcategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            widget.screentitle,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: kPrimaryColor,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: 22,
            ),
          )),
      body: Obx(() {
        return buyerHomeController.subtypeproductlist.length > 0
            ? ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: buyerHomeController.subtypeproductlist.length,
                itemBuilder: (BuildContext context, int index) {
                  double price = double.parse(buyerHomeController
                      .subtypeproductlist[index]["price"]
                      .toString());
                  double discountPrice = price * 1.20;

                  return InkWell(
                    onTap: () {
                      Get.to(BuyerHomeCategoryProductDescription(
                        productdatalist:
                            buyerHomeController.subtypeproductlist[index],
                      ));
                    },
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 4,
                              blurRadius: 6,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            15,
                          )),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                height: Get.height * 0.12,
                                width: Get.height * 0.12,
                                imageUrl: buyerHomeController
                                    .subtypeproductlist[index]["imgurl"][0],
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 5),
                            child: Container(
                              width: Get.width * 0.60,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      buyerHomeController
                                          .subtypeproductlist[index]["name"],
                                      maxLines: 2,
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
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
                                      Text(
                                        "Price: ₹${buyerHomeController.subtypeproductlist[index]['price']}",
                                        style: TextStyle(color: kPrimaryColor),
                                      ),
                                      Text(
                                        "MRP: ${discountPrice.toStringAsFixed(2)}",
                                        style: TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                      "Category: ${buyerHomeController.subtypeproductlist[index]['subtype']}"),
                                  Text(
                                      "Stock: ${buyerHomeController.subtypeproductlist[index]['stock']}"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(
                color: kPrimaryColor,
              ));
      }),
    );
  }
}
