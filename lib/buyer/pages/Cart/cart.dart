import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:footwearclub/authentication/shred_pref.dart';
import 'package:footwearclub/buyer/database/cart_db.dart';
import 'package:footwearclub/buyer/models/cart_model.dart';
import 'package:footwearclub/buyer/pages/Order/checkout_screen.dart';
import 'package:footwearclub/constants/constant.dart';
import 'package:footwearclub/seller/constants/seller_constant.dart';
import 'package:get/get.dart';

class Cart extends StatefulWidget {
  Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  CartHelper cartHelper = CartHelper();
  Future<List<CartModel>>? cartlist;
  List<CartModel>? currentcartlist;
  int total = 0;

  @override
  void initState() {
    super.initState();
    cartHelper.initializeDatabase();
    Timer(Duration(milliseconds: 300), () {
      setState(() {
        loadCartlist();
      });
    });
  }

  void loadCartlist() {
    cartlist = cartHelper.getCartList().then((value) {
      getTotal();
      return value;
    });
  }

  void getTotal() {
    total = 0;
    cartlist!.then((value) {
      value.forEach((element) {
        int itemtotal = int.parse(element.price.toString()) *
            int.parse(element.quantity.toString());
        total = total + itemtotal;
      });
      print("total $total");
    });
    setState(() {
      total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          backgroundColor: Colors.white,
          title: Text(
            "Shopping Cart",
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: cartlist,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                currentcartlist = snapshot.data;
                return currentcartlist!.length != 0
                    ? Stack(
                        children: [
                          ListView.builder(
                              itemCount: currentcartlist!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 14.0,
                                          left: 14,
                                          right: 14,
                                          bottom: 5),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 70,
                                            width: 70,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              child: CachedNetworkImage(
                                                progressIndicatorBuilder:
                                                    (context, url, progress) =>
                                                        Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: kPrimaryColor,
                                                  ),
                                                ),
                                                imageUrl:
                                                    currentcartlist![index]
                                                        .imgurl
                                                        .toString(),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            120,
                                                    child: Text(
                                                      currentcartlist![index]
                                                          .title
                                                          .toString(),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                      ),
                                                    )),
                                                Text(
                                                  "Type: ${currentcartlist![index].subtype.toString()}",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Text(
                                                  "₹ ${currentcartlist![index].price.toString()}",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      120,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          showDialog(
                                                              context: context,
                                                              builder: (ctx) =>
                                                                  AlertDialog(
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                    ),
                                                                    content: Text(
                                                                        "Remove Product From Cart?"),
                                                                    actions: <
                                                                        Widget>[
                                                                      ElevatedButton(
                                                                        child: Text(
                                                                            "Close"),
                                                                        onPressed:
                                                                            () {
                                                                          Get.back();
                                                                        },
                                                                      ),
                                                                      ElevatedButton(
                                                                        style: ButtonStyle(
                                                                            backgroundColor:
                                                                                MaterialStateProperty.all(kSellerPrimaryColor)),
                                                                        child: Text(
                                                                            "Ok"),
                                                                        onPressed:
                                                                            () {
                                                                          cartHelper
                                                                              .deleteCartitem(currentcartlist![index].id!.toInt())
                                                                              .then((value) {
                                                                            setState(() {
                                                                              currentcartlist!.removeAt(index);
                                                                              getTotal();
                                                                            });
                                                                          });
                                                                          Get.back();
                                                                        },
                                                                      )
                                                                    ],
                                                                  ));
                                                        },
                                                        child: Container(
                                                          height: 30,
                                                          width: 30,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              border: Border.all(
                                                                  color: Colors
                                                                          .grey[
                                                                      400]!)),
                                                          child: Icon(
                                                            Icons.delete,
                                                            color: Colors
                                                                .grey[600],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 110,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                var b = int.parse(
                                                                    currentcartlist![
                                                                            index]
                                                                        .quantity
                                                                        .toString());
                                                                b = b - 1;

                                                                currentcartlist![
                                                                            index]
                                                                        .quantity =
                                                                    b.toString();

                                                                int? id =
                                                                    currentcartlist![
                                                                            index]
                                                                        .id;

                                                                cartHelper
                                                                    .updateCartItem(
                                                                        id!,
                                                                        b.toString());

                                                                if (b == 0) {
                                                                  cartHelper
                                                                      .deleteCartitem(currentcartlist![
                                                                              index]
                                                                          .id!
                                                                          .toInt())
                                                                      .then(
                                                                          (value) {
                                                                    setState(
                                                                        () {
                                                                      currentcartlist!
                                                                          .removeAt(
                                                                              index);
                                                                    });
                                                                  });
                                                                }

                                                                getTotal();
                                                                setState(() {});
                                                              },
                                                              child: Container(
                                                                height: 25,
                                                                width: 25,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      kPrimaryColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              6),
                                                                ),
                                                                child: Icon(
                                                                  Icons.remove,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      10.0),
                                                              child: Text(
                                                                currentcartlist![
                                                                        index]
                                                                    .quantity
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                var b = int.parse(
                                                                    currentcartlist![
                                                                            index]
                                                                        .quantity
                                                                        .toString());
                                                                b = b + 1;
                                                                currentcartlist![
                                                                            index]
                                                                        .quantity =
                                                                    b.toString();

                                                                int? id =
                                                                    currentcartlist![
                                                                            index]
                                                                        .id;

                                                                cartHelper
                                                                    .updateCartItem(
                                                                        id!,
                                                                        b.toString());
                                                                getTotal();
                                                                setState(() {});
                                                              },
                                                              child: Container(
                                                                height: 25,
                                                                width: 25,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      kPrimaryColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              6),
                                                                ),
                                                                child: Icon(
                                                                  Icons.add,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    index == 5 - 1
                                        ? SizedBox(
                                            height: 70,
                                          )
                                        : Divider(),
                                  ],
                                );
                              }),
                        ],
                      )
                    : Center(
                        child: Text("Cart is Empty"),
                      );
              }

              return Center(
                  child: CircularProgressIndicator(
                color: kPrimaryColor,
              ));
            }),
        bottomNavigationBar: Container(
          height: Get.height * 0.10,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      "$total",
                      // "₹ 40.16",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ],
                ),
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  color: kPrimaryColor,
                  textColor: Colors.white,
                  child: Text('Next'),
                  onPressed: () {
                    if (total != 0) {
                      Get.to(CheckOutScreen());
                    }
                    else{
                      scafoldmessage(context, "Please add item to the cart");
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
