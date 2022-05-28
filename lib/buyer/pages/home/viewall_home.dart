import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:footwearclub/buyer/pages/ProductDescription/product_description.dart';
import 'package:footwearclub/constants/constant.dart';
import 'package:get/get.dart';

import 'buyer_home_controller.dart';

class ViewallHomeScreen extends StatefulWidget {
  final String screentitle;
  final String type;
  final bool isprice;

  ViewallHomeScreen({
    Key? key,
    required this.screentitle,
    required this.type,
    required this.isprice,
  }) : super(key: key);

  @override
  State<ViewallHomeScreen> createState() => _ViewallHomeScreenState();
}

BuyerHomeController buyerHomeController = Get.put(BuyerHomeController());

class _ViewallHomeScreenState extends State<ViewallHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final data;
    if (widget.isprice) {
      data = buyerHomeController.priceproductlist;
    } else {
      data = buyerHomeController.typeproductlist;
    }
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
      body: Obx(() {
        return data.length > 0
            ? GridView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: MediaQuery.of(context).size.height * 0.368,
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, index) {
                  double price = double.parse(data[index]['price'].toString());
                  double discountPrice = price * 1.20;

                  return InkWell(
                    onTap: () {
                      Get.to(BuyerHomeCategoryProductDescription(
                        productdatalist: data[index],
                      ));
                    },
                    child: Card(
                      elevation: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.20,
                            width: Get.width,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  topRight: Radius.circular(4)),
                              child: CachedNetworkImage(
                                progressIndicatorBuilder:
                                    (context, url, progress) => Center(
                                  child: CircularProgressIndicator(
                                    color: kPrimaryColor,
                                  ),
                                ),
                                imageUrl: data[index]["imgurl"][0],
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 2),
                            child: Text(
                              data[index]["name"],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Colors.black54.withOpacity(0.6)),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                left: 8,
                              ),
                              child: Text(
                                "${data[index]['stock']} In Stock",
                                style: TextStyle(
                                    color: Colors.green, fontSize: 10),
                              )),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    child: Text(
                                  "₹ ${data[index]['price']}",
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
                                )),
                                Text(
                                  "₹ ${discountPrice.toStringAsFixed(2)}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 12,
                                      color: Colors.black54.withOpacity(0.6)),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "${data[index]['subtype']}",
                              // "Category : ${data[index]['subtype']}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          )
                        ],
                      ),
                    ),
                  );
                })
            : Center(
                child: Text(
                "No Products Available !",
                style: TextStyle(color: kPrimaryColor, fontSize: 18),
              ));
      }),
    );
  }
}
