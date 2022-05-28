import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:footwearclub/buyer/database/cart_db.dart';
import 'package:footwearclub/buyer/database/wishlish_db.dart';
import 'package:footwearclub/buyer/models/cart_model.dart';
import 'package:footwearclub/buyer/models/wishlist_model.dart';
import 'package:footwearclub/buyer/pages/Cart/cart.dart';
import 'package:footwearclub/buyer/pages/Cart/cart_controller.dart';
import 'package:footwearclub/constants/constant.dart';
import 'package:footwearclub/seller/constants/seller_constant.dart';
import 'package:get/get.dart';

class WishList extends StatefulWidget {
  const WishList({Key? key}) : super(key: key);

  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  WishListHelper wishListHelper = WishListHelper();
  Future<List<WishListModel>>? wishoflist;
  List<WishListModel>? currentwishlist;
  CartHelper cartHelper = CartHelper();
  Future<List<CartModel>>? cartlist;

  @override
  void initState() {
    super.initState();
    wishListHelper.initializeDatabase();
    cartHelper.initializeDatabase();
    loadWishlist();
  }

  void loadWishlist() {
    wishoflist = wishListHelper.getWishList();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    loadWishlist();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          backgroundColor: Colors.white,
          title: Text(
            "Wishlist",
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: wishoflist,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // print(snapshot.connectionState);
              currentwishlist = snapshot.data;
              // print(currentwishlist!.length);
              // print("snapshot.data");
              // print(snapshot.data);
              return currentwishlist!.length != 0
                  ? ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: currentwishlist!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 4,
                                  blurRadius: 6,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                15,
                              )),
                          child: Column(
                            children: [
                              Row(
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
                                        height: Get.height * 0.13,
                                        width: Get.width * 0.24,
                                        imageUrl: currentwishlist![index]
                                            .imgurl
                                            .toString(),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text(
                                              currentwishlist![index]
                                                  .title
                                                  .toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          Text(
                                              "Price: ${currentwishlist![index].price}"),
                                          Text(
                                              "Color: ${currentwishlist![index].color}"),
                                          Text(
                                              "In Stock - ${currentwishlist![index].stock}"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (ctx) => AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  content: Text(
                                                      "Are You Sure Want to Remove Product From Wishlist?"),
                                                  actions: <Widget>[
                                                    ElevatedButton(
                                                      child: Text("Close"),
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                    ),
                                                    ElevatedButton(
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(
                                                                      kSellerPrimaryColor)),
                                                      child: Text("Ok"),
                                                      onPressed: () {
                                                        print(currentwishlist![
                                                                index]
                                                            .id);
                                                        wishListHelper
                                                            .deleteWishList(
                                                                currentwishlist![
                                                                        index]
                                                                    .id!
                                                                    .toInt())
                                                            .then((value) {
                                                          setState(() {
                                                            currentwishlist!
                                                                .removeAt(
                                                                    index);
                                                          });
                                                        });
                                                        Get.back();
                                                      },
                                                    )
                                                  ],
                                                ));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black54,
                                                width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Icon(
                                            Icons.favorite,
                                            color: kPrimaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        List productidlist = [];

                                        cartlist = cartHelper.getCartList();
                                        cartlist!.then((cartmodellist) {
                                          cartmodellist.forEach((value) {
                                            productidlist.add(value.productid);
                                          });
                                        }).then((value) {
                                          print(productidlist);

                                          if (!productidlist.contains(
                                              currentwishlist![index]
                                                  .productid)) {
                                            var cartModel = CartModel(
                                                title: currentwishlist![index]
                                                    .title,
                                                price: currentwishlist![index]
                                                    .price,
                                                color: currentwishlist![index]
                                                    .color,
                                                stock: currentwishlist![index]
                                                    .stock,
                                                imgurl: currentwishlist![index]
                                                    .imgurl,
                                                sellerid:
                                                    currentwishlist![index]
                                                        .sellerid,
                                                productid:
                                                    currentwishlist![index]
                                                        .productid,
                                                category:
                                                    currentwishlist![index]
                                                        .category,
                                                subtype: currentwishlist![index]
                                                    .subtype,
                                                size: "8",
                                                quantity: "1");
                                            cartHelper.insertCart(cartModel);

                                            print("added to cart");
                                          } else {
                                            // scafoldmessage(context,
                                            //     " Already added to cart");
                                            print("already in cart added");
                                          }
                                          Get.to(Cart());
                                        });
                                      },
                                      child: Container(
                                        width: Get.width * 0.65,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: kPrimaryColor, width: 2),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 4),
                                          child: Text(
                                            "Add to cart",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: kPrimaryColor,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        "Add Favorite Product",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    );
            }
            return Center(
                child: CircularProgressIndicator(
              color: kPrimaryColor,
            ));
          },
        ),
      ),
  
    );
  }
}
