import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:footwearclub/buyer/pages/ProductDescription/product_description.dart';
import 'package:footwearclub/buyer/pages/home/buyer_home_controller.dart';
import 'package:footwearclub/constants/constant.dart';
import 'package:footwearclub/seller/constants/seller_constant.dart';
import 'package:get/get.dart';

class ViewallScreen extends StatefulWidget {
  final List productdatalist;
  final String screentitle;

  ViewallScreen(
      {Key? key, required this.productdatalist, required this.screentitle})
      : super(key: key);

  @override
  State<ViewallScreen> createState() => _ViewallScreenState();
}

BuyerHomeController buyerHomeController = Get.find();

class _ViewallScreenState extends State<ViewallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            widget.screentitle,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),
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
      body: Obx(
        () => buyerHomeController.isserchdataload.value
            ? ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: buyerHomeController.serchproductlist.length,
                itemBuilder: (BuildContext context, int index) {
                  var data = buyerHomeController.serchproductlist[index];

                  double price = double.parse(data["price"].toString());
                  double discountPrice = price * 1.20;

                  // print(data);
                  return InkWell(
                    onTap: () {
                      Get.to(BuyerHomeCategoryProductDescription(
                        productdatalist:
                            buyerHomeController.serchproductlist[index],
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
                            height: Get.height*0.12,
                            width: Get.height * 0.12,
                            imageUrl: data["imgurl"][0].toString(),
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
                                          .serchproductlist[index]["name"],
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
                                      Text("Price: ₹ ${data['price']}"),
                                      Text(
                                        // "MRP: ${double.parse(data['price']) * 1.15} ₹",
                                        "₹ ${discountPrice.toStringAsFixed(2)}",
                                        style: TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                               fontSize: 13
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text("Category: ${data['subtype']}"),
                                  Text("Stock: ${data['stock']}"),
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
            : Center(child: Text("No Poducts")),
      ),
    );
    ;
  }
}
