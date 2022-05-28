import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:footwearclub/authentication/shred_pref.dart';
import 'package:footwearclub/buyer/database/cart_db.dart';
import 'package:footwearclub/buyer/database/wishlish_db.dart';
import 'package:footwearclub/buyer/models/cart_model.dart';
import 'package:footwearclub/buyer/models/wishlist_model.dart';
import 'package:footwearclub/buyer/pages/Cart/cart_controller.dart';
import 'package:footwearclub/buyer/pages/ProductDescription/product_desc_controller.dart';
import 'package:footwearclub/buyer/pages/ProductDescription/product_fullpage_image.dart';
import 'package:footwearclub/constants/constant.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'buynow_bottomsheet.dart';

class BuyerHomeCategoryProductDescription extends StatefulWidget {
  final Map<String, dynamic>? productdatalist;

  const BuyerHomeCategoryProductDescription({Key? key, this.productdatalist})
      : super(key: key);

  @override
  _HomeCategoryProductDescriptionState createState() =>
      _HomeCategoryProductDescriptionState();
}

class _HomeCategoryProductDescriptionState
    extends State<BuyerHomeCategoryProductDescription> {
  List<String> sizes = ["6", "7", "8", "9", "10", "11"];
  CartController cartController = Get.put(CartController());
  ProductDescriptionController productDescriptionController =
      Get.put(ProductDescriptionController());
  WishListHelper wishListHelper = WishListHelper();
  CartHelper cartHelper = CartHelper();
  Future<List<CartModel>>? cartlist;
  bool? isAddtoCart;
  var mypath;

  void onSaveWishList() {
    var wishListModel = WishListModel(
      title: widget.productdatalist!["name"],
      price: widget.productdatalist!["price"],
      color: widget.productdatalist!["color"],
      stock: widget.productdatalist!["stock"],
      imgurl: widget.productdatalist!["imgurl"][0],
      sellerid: widget.productdatalist!["sellerid"],
      productid: widget.productdatalist!["productid"],
      category: widget.productdatalist!["category"],
      subtype: widget.productdatalist!["subtype"],
    );

    wishListHelper.insertData(wishListModel);
  }

  void removeWishlist() {
    var pid = widget.productdatalist!["productid"];
    wishListHelper.deleteproductWishList(pid);
  }

  @override
  void initState() {
    super.initState();
    wishListHelper.initializeDatabase();
    cartHelper.initializeDatabase();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle());
  }

  @override
  Widget build(BuildContext context) {
    int imgid = 0;
    List imageList = [
      widget.productdatalist!["imgurl"][0],
      widget.productdatalist!["imgurl"][1],
      widget.productdatalist!["imgurl"][2],
      widget.productdatalist!["imgurl"][3],
    ];

    Future<String> createFolder() async {
      const folderName = "footwearclub";
      Directory tempDir = await getTemporaryDirectory();
      String temppath = tempDir.path + "/$folderName";
      final path = Directory(temppath);
      setState(() {
        mypath = path.path;
      });
      print(mypath);

      var status = await Permission.storage.status;

      if (!status.isGranted) {
        await Permission.storage.request();
      }
      if ((await path.exists())) {
        return path.path;
      } else {
        path.create();
        return path.path;
      }
    }

    Future<void> _saveImage(int saveindex) async {
      var savePath = await createFolder();
      savePath = savePath + "/footwear$saveindex.jpeg";
      await Dio().download(widget.productdatalist!["imgurl"][0], savePath);
      final result = await ImageGallerySaver.saveFile(savePath);
    }

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(ProductFullPageImage(
                            imgList: imageList,
                          ));
                        },
                        child: GFCarousel(
                          hasPagination: true,
                          activeIndicator: kPrimaryColor,
                          passiveIndicator: Colors.white,
                          viewportFraction: 0.9,
                          aspectRatio: 1.34,
                          items: imageList.map(
                            (url) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    top:
                                        MediaQuery.of(context).padding.top + 5),
                                child: Container(
                                  height: Get.height * 0.3,
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
                                      imageUrl: url,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                          onPageChanged: (index) {
                            setState(() {
                              index;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[350],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Icon(Icons.arrow_back),
                                  )),
                            ),
                            InkWell(
                              onTap: () {
                                imgid = imgid + 1;
                                _saveImage(imgid).then((value) async {
                                  var save = "$mypath/footwear$imgid.jpeg";
                                  await Share.shareFiles([save],
                                      text: 'Footwear Club');
                                });
                              },
                              child: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[350],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Icon(MdiIcons.shareOutline),
                                  )),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //price
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "₹ ${widget.productdatalist!["price"]}",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 21,
                              fontWeight: FontWeight.w700),
                        ),
                        Obx(
                          () => InkWell(
                            onTap: () {
                              productDescriptionController.addToWishList.value =
                                  !productDescriptionController
                                      .addToWishList.value;
                              productDescriptionController
                                          .addToWishList.value ==
                                      true
                                  ? scafoldmessage(
                                      context, "Product Added to WishList")
                                  : scafoldmessage(
                                      context, "Product Removed from WishList");
                              productDescriptionController.addToWishList.value
                                  ? onSaveWishList()
                                  : removeWishlist();
                            },
                            child:
                                productDescriptionController.addToWishList.value
                                    ? Icon(
                                        Icons.favorite,
                                        color: kPrimaryLightColor,
                                        size: 28,
                                      )
                                    : Icon(
                                        Icons.favorite_outline,
                                        color: Colors.black,
                                        size: 28,
                                      ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  //description
                  Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.05,
                          right: MediaQuery.of(context).size.width * 0.05),
                      child: Wrap(
                        children: [
                          Text(
                            widget.productdatalist!["name"],
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54.withOpacity(0.6)),
                          )
                        ],
                      )),
                  SizedBox(
                    height: 10,
                  ),

                  //availble in stock
                  Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.05),
                      child: Text(
                        "Availble - In Stock ${widget.productdatalist!["stock"]}",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      )),
                  SizedBox(
                    height: 10,
                  ),

                  //devider
                  Container(
                    height: 12,
                    width: double.infinity,
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  //Information section
                  Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.05),
                      child: Text(
                        "Information",
                        style: TextStyle(
                            fontSize: 16.5,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Weight",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54.withOpacity(0.6)),
                        ),
                        Text(
                          widget.productdatalist!["weight"],
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54.withOpacity(0.6),
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Category",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54.withOpacity(0.6)),
                        ),
                        Text(
                          widget.productdatalist!["category"],
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54.withOpacity(0.6),
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Type",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54.withOpacity(0.6)),
                        ),
                        Text(
                          widget.productdatalist!["subtype"],
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54.withOpacity(0.6),
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Color",
                          style: TextStyle(
                              fontSize: 16, color: Colors.grey.shade600),
                        ),
                        Text(
                          widget.productdatalist!["color"],
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  //devider
                  Container(
                    height: 12,
                    width: double.infinity,
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  //Description section
                  Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.05),
                      child: Text(
                        "Description",
                        style: TextStyle(
                            fontSize: 16.5,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.05,
                          right: 10),
                      child: Text(
                        widget.productdatalist!["desc"],
                        style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                      )),
                  SizedBox(
                    height: 15,
                  ),

                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 5),
                child: InkWell(
                  onTap: () {
                    isAddtoCart = true;
                    buyNowModelsheet(
                        context,
                        widget.productdatalist!["imgurl"][0],
                        widget.productdatalist!["price"],
                        widget.productdatalist!["stock"],
                        widget.productdatalist!["subtype"],
                        isAddtoCart,
                        widget.productdatalist!);
                    // List productidlist = [];
                    // cartlist = cartHelper.getCartList();
                    // cartlist!.then((cartmodellist) {
                    //   cartmodellist.forEach((value) {
                    //     productidlist.add(value.productid);
                    //   });
                    // }).then((value) async {
                    //   // print(productidlist);
                    //   // print(widget.productdatalist!["productid"]);
                    //   if (!productidlist
                    //       .contains(widget.productdatalist!["productid"])) {
                    //     var cartModel = CartModel(
                    //       title: widget.productdatalist!["name"],
                    //       price: widget.productdatalist!["price"],
                    //       color: widget.productdatalist!["color"],
                    //       stock: widget.productdatalist!["stock"],
                    //       imgurl: widget.productdatalist!["imgurl"][0],
                    //       sellerid: widget.productdatalist!["sellerid"],
                    //       productid: widget.productdatalist!["productid"],
                    //       category: widget.productdatalist!["category"],
                    //       subtype: widget.productdatalist!["subtype"],
                    //       size: "8",
                    //       quantity: "1",
                    //     );
                    //     cartHelper.insertCart(cartModel);
                    //     scafoldmessage(context, "Added to cart");
                    //   } else {
                    //     scafoldmessage(context, " Already added to cart");
                    //   }
                    // });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 2.5, color: kPrimaryColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Icon(
                        MdiIcons.cart,
                        size: 25,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    isAddtoCart = false;
                    buyNowModelsheet(
                        context,
                        widget.productdatalist!["imgurl"][0],
                        widget.productdatalist!["price"],
                        widget.productdatalist!["stock"],
                        widget.productdatalist!["subtype"],
                        isAddtoCart,
                        widget.productdatalist!);
                  },
                  child: Container(
                    height: 55,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Buy Now",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
