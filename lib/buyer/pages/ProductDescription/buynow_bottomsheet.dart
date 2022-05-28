import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:footwearclub/authentication/shred_pref.dart';
import 'package:footwearclub/buyer/database/cart_db.dart';
import 'package:footwearclub/buyer/models/cart_model.dart';
import 'package:footwearclub/buyer/pages/Cart/cart.dart';
import 'package:footwearclub/constants/constant.dart';
import 'package:get/get.dart';
import 'product_desc_controller.dart';

CartHelper cartHelper = CartHelper();
Future<List<CartModel>>? cartlist;

Future buyNowModelsheet(context, imgurl, price, stock, type, isAddtocart, productdatalist) {
  cartHelper.initializeDatabase();
  ProductDescriptionController productDescriptionController =
      Get.put(ProductDescriptionController());
  List<String> sizes = ["6", "7", "8", "9", "10", "11"];
  return showModalBottomSheet(
      context: context,
      // barrierColor: popupBackground,
      isScrollControlled: true, // only work on showModalBottomSheet function
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      builder: (context) => Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
                height: Get.height * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: Get.height * 0.17,
                                margin: EdgeInsets.symmetric(
                                  horizontal: 5.0,
                                ),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  child: CachedNetworkImage(
                                    progressIndicatorBuilder:
                                        (context, url, progress) => Center(
                                      child: CircularProgressIndicator(
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                    imageUrl: imgurl,
                                    width: Get.width * 0.30,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "₹ $price",
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "stock: $stock",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    "$type",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(
                                Icons.close,
                                size: 30,
                              ))
                        ],
                      ),
                    ),
                    Divider(
                      color: kSecondaryColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        "Variation",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.05),
                            child: Text(
                              "Size : ",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey.shade600),
                            )),
                        Obx(() => Text(
                              productDescriptionController.selectedSize.value,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ))
                      ],
                    ),

                    Container(
                      padding: EdgeInsets.only(left: 5),
                      height: 50,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: sizes.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Material(
                              child: Obx(
                                () => InkWell(
                                  borderRadius: BorderRadius.circular(8),
                                  onTap: () {
                                    productDescriptionController
                                        .selectedSize.value = sizes[index];
                                  },
                                  child: Ink(
                                    height: 35,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: productDescriptionController
                                                    .selectedSize.value ==
                                                sizes[index]
                                            ? kPrimaryLightColor
                                            : Color(0xFFF3F3F3),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(sizes[index],
                                          style: TextStyle(
                                              fontSize: 14,
                                              color:
                                                  productDescriptionController
                                                              .selectedSize
                                                              .value ==
                                                          sizes[index]
                                                      ? Colors.white
                                                      : Colors.black87,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Divider(
                      color: kSecondaryColor,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text(
                    //         "Quantity",
                    //         style: TextStyle(
                    //             fontSize: 17,
                    //             fontWeight: FontWeight.w500,
                    //             color: Colors.black),
                    //       ),
                    //       Container(
                    //         width: 110,
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.end,
                    //           children: [
                    //             InkWell(
                    //               onTap: () {},
                    //               child: Container(
                    //                 height: 25,
                    //                 width: 25,
                    //                 decoration: BoxDecoration(
                    //                   color: kPrimaryColor,
                    //                   borderRadius: BorderRadius.circular(6),
                    //                 ),
                    //                 child: Icon(
                    //                   Icons.remove,
                    //                   color: Colors.white,
                    //                 ),
                    //               ),
                    //             ),
                    //             Padding(
                    //               padding: const EdgeInsets.all(10.0),
                    //               child: Text(
                    //                 "1",
                    //                 style: TextStyle(
                    //                     fontSize: 15, color: Colors.black),
                    //               ),
                    //             ),
                    //             InkWell(
                    //               onTap: () {},
                    //               child: Container(
                    //                 height: 25,
                    //                 width: 25,
                    //                 decoration: BoxDecoration(
                    //                   color: kPrimaryColor,
                    //                   borderRadius: BorderRadius.circular(6),
                    //                 ),
                    //                 child: Icon(
                    //                   Icons.add,
                    //                   color: Colors.white,
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // Divider(
                    //   color: kSecondaryColor,
                    // ),
                    InkWell(
                      onTap: () {
                        if (productDescriptionController.selectedSize.value ==
                            "") {
                          Get.snackbar("Size Error", "Please select the size",
                              colorText: Colors.white60);
                        } else {
                          List productidlist = [];
                          cartlist = cartHelper.getCartList();
                          cartlist!.then((cartmodellist) {
                            cartmodellist.forEach((value) {
                              productidlist.add(value.productid);
                            });
                          }).then((value) {
                            print(productidlist);
                            print(productdatalist!["productid"]);
                            if (!productidlist
                                .contains(productdatalist!["productid"])) {
                              var cartModel = CartModel(
                                  title: productdatalist!["name"],
                                  price: productdatalist!["price"],
                                  color: productdatalist!["color"],
                                  stock: productdatalist!["stock"],
                                  imgurl: productdatalist!["imgurl"][0],
                                  sellerid: productdatalist!["sellerid"],
                                  productid: productdatalist!["productid"],
                                  category: productdatalist!["category"],
                                  subtype: productdatalist!["subtype"],
                                  size: productDescriptionController
                                      .selectedSize.value,
                                  quantity: "1");
                              cartHelper.insertCart(cartModel);
                              print("add to cart");
                              if (isAddtocart) {
                                Get.back();
                                scafoldmessage(context, "Added to cart");
                              }
                            } else {
                              if (isAddtocart) {
                                Get.back();
                                scafoldmessage(
                                    context, "Already added to cart");
                              }
                              print("already add to cart");
                            }
                          });
                          if (!isAddtocart) {
                            Get.off(Cart());
                          }
                        }
                      },
                      child: Container(
                        height: 55,
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: isAddtocart
                              ? Text(
                                  "Add to Cart",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Colors.white),
                                )
                              : Text(
                                  "Buy Now",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                        ),
                      ),
                    )
                  ],
                )),
          ));
}
