import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:footwearclub/authentication/shred_pref.dart';
import 'package:footwearclub/buyer/pages/Allproducts/all_product.dart';
import 'package:footwearclub/buyer/pages/Category/screen/buyer_category.dart';
import 'package:footwearclub/buyer/pages/ProductDescription/product_description.dart';
import 'package:footwearclub/constants/constant.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'buyer_home_controller.dart';
import 'viewall_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  // int pageIndex = 0;
  int pageIndex = 0, malecount = 0, femalecount = 0, childcount = 0;

  Timer? timer;
  List scrollableImages = [
    "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/extra%2F1638543127save-more-trend-more-men-top-desktop-banner.webp?alt=media&token=efdd734a-776e-4fcc-8b25-1b343dff1b39",
    "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/extra%2Fpeter-albanese-Gqlmzo-q6mY-unsplash%20(1).jpg?alt=media&token=4c67db2e-b385-4c5e-838b-9c9f191b7b74",
    "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/extra%2Fmikel-parera-xag0YpBqNfQ-unsplash%20(1).jpg?alt=media&token=c9be0165-e2b5-4187-9997-2870933c8a9b",
    "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/extra%2Fmatthew-dagelet-tBdkpxj3A7Q-unsplash%20(1).jpg?alt=media&token=e2e74adf-bfc5-407e-8d1a-a92137d686aa",
    "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/extra%2Fomar-prestwich-jLEGurepDco-unsplash%20(1).jpg?alt=media&token=362cb764-a6f7-47ef-9364-68976c871e23",
    "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/extra%2Fmatias-ilizarbe-HRYENP2Hfyc-unsplash%20(1).jpg?alt=media&token=189bb580-fb9e-4032-91b9-5403477fdbc8"
  ];

  List categorylist = [
    {
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/extra%2Fshoes.png?alt=media&token=5a305220-f50d-4c53-81f9-7b4b94c4722d",
      "type": 'Shoes'
    },
    {
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/extra%2Fsandles.png?alt=media&token=72ca58ef-3ffb-4676-8148-6ffbab478a0b",
      "type": 'Sandals'
    },
    {
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/extra%2Fboots.png?alt=media&token=541164d5-a80e-42cc-bc3f-9c475926fc9e",
      "type": 'Boot'
    },
    {
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/extra%2Fheels-removebg-preview.png?alt=media&token=67e33e71-cfa0-462f-bc89-61396fdbcac2",
      "type": 'Heels'
    },
  ];

  List pricelist = [
    {
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/extra%2Fnew.png?alt=media&token=44651100-a55b-4277-aae2-13ab0e53248f",
      "type": 'New arrivals',
      "price": 9999
    },
    {
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/extra%2F299.png?alt=media&token=fabe30a1-63d7-4623-9368-35459ccf7ff3",
      "type": 'Under ₹299',
      "price": 299
    },
    {
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/extra%2F499.png?alt=media&token=45a8fe9f-3b6e-46be-aaf6-fc2593a65e52",
      "type": 'Under ₹499',
      "price": 499
    },
    {
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/extra%2F799.png?alt=media&token=b088c992-2ec9-4f24-b3d3-49dc6e83fc58",
      "type": 'Under ₹799',
      "price": 799
    },
  ];

  BuyerHomeController buyerHomeController = Get.put(BuyerHomeController());

  void getdata() async {
    buyerHomeController.productlist.isEmpty
        ? await buyerHomeController.getproduct().whenComplete(() {
            buyerHomeController.isdataload.value = true;
          })
        : null;
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    setState(() {});
    await Future.delayed(Duration(milliseconds: 1000));
    await buyerHomeController.getproduct().whenComplete(() {
      buyerHomeController.isdataload.value = true;
    });
    await buyerHomeController.get30product();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    BuyerHomeController buyerHomeController = Get.put(BuyerHomeController());
    PrefManager prefManager = Get.put(PrefManager());
    return Scaffold(
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: Get.height * 0.3,
                  aspectRatio: 16 / 10,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  // onPageChanged: callbackFunction,
                  scrollDirection: Axis.horizontal,
                ),
                items: scrollableImages.map((url) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
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
                      );
                    },
                  );
                }).toList(),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: Text(
                  "Categories",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Colors.black87),
                ),
              ),

              //Gridview of Icons
              Wrap(
                children: [
                  GridView.builder(
                      padding: EdgeInsets.only(top: 5),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: categorylist.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 90, crossAxisCount: 4),
                      itemBuilder: (BuildContext context, index) {
                        return InkWell(
                          onTap: () async {
                            await buyerHomeController
                                .getbytype(categorylist[index]["type"]);

                            Get.to(ViewallHomeScreen(
                              isprice: false,
                              screentitle: categorylist[index]["type"],
                              type: categorylist[index]["type"],
                            ));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: kSecondaryColor, width: 1),
                                  borderRadius: BorderRadius.circular(60),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: CachedNetworkImage(
                                      progressIndicatorBuilder:
                                          (context, url, progress) => Center(
                                        child: CircularProgressIndicator(
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                      imageUrl: categorylist[index]["imageUrl"],
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                categorylist[index]["type"],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11,
                                    color: Colors.black),
                              )
                            ],
                          ),
                        );
                      }),
                  GridView.builder(
                      padding: EdgeInsets.only(top: 5),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: pricelist.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 90, crossAxisCount: 4),
                      itemBuilder: (BuildContext context, index) {
                        return InkWell(
                          onTap: () async {
                            await buyerHomeController
                                .getbyprice(pricelist[index]["price"]);

                            Get.to(ViewallHomeScreen(
                              isprice: true,
                              screentitle: pricelist[index]["type"],
                              type: pricelist[index]["type"],
                            ));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: kSecondaryColor, width: 1),
                                  borderRadius: BorderRadius.circular(60),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: CachedNetworkImage(
                                      progressIndicatorBuilder:
                                          (context, url, progress) => Center(
                                        child: CircularProgressIndicator(
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                      imageUrl: pricelist[index]["imageUrl"],
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                pricelist[index]["type"],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11,
                                    color: Colors.black),
                              )
                            ],
                          ),
                        );
                      }),
                ],
              ),

              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05,
                    vertical: MediaQuery.of(context).size.width * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recommended Product",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.black87),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(ViewallScreen(
                            screentitle: "Recommended Products",
                            productdatalist:
                                buyerHomeController.serchproductlist));
                      },
                      child: Text(
                        "View all",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: kPrimaryLightColor,
                            fontSize: 15),
                      ),
                    )
                  ],
                ),
              ),

              Obx(() {
                return buyerHomeController.isserchdataload.value
                    ? Container(
                        // width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.33,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount:
                                buyerHomeController.serchproductlist.length,
                            itemBuilder: (context, index) {
                              // if (index == 11) {
                              //   return Padding(
                              //     padding: const EdgeInsets.all(8.0),
                              //     child: Container(
                              //       height: 50,
                              //       width: 50,
                              //       alignment: Alignment.center,
                              //       child: ElevatedButton(
                              //         onPressed: () {},
                              //         style: ElevatedButton.styleFrom(
                              //           shape: CircleBorder(),
                              //           padding: EdgeInsets.all(50),
                              //         ),
                              //         child: null,
                              //       ),
                              //     ),
                              //   );
                              // }
                              return InkWell(
                                onTap: () {
                                  // print(buyerHomeController
                                  //     .serchproductlist[index]);
                                  Get.to(BuyerHomeCategoryProductDescription(
                                    productdatalist: buyerHomeController
                                        .serchproductlist[index],
                                  ));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: index == 0
                                          ? MediaQuery.of(context).size.width *
                                              0.04
                                          : 5),
                                  width:
                                      MediaQuery.of(context).size.width * 0.42,
                                  child: Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.42,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.36,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10)),
                                            child: CachedNetworkImage(
                                              progressIndicatorBuilder:
                                                  (context, url, progress) =>
                                                      Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: kPrimaryColor,
                                                ),
                                              ),
                                              imageUrl: buyerHomeController
                                                      .serchproductlist[index]
                                                  ["imgurl"][0],
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.01,
                                                bottom: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.01,
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.018,
                                                right: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.01),
                                            child: Text(
                                              buyerHomeController
                                                      .serchproductlist[index]
                                                  ["name"],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13,
                                                  color: Colors.black54
                                                      .withOpacity(0.6)),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                        Container(
                                            margin: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.018,
                                                bottom: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.01),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5.0),
                                              child: Text(
                                                buyerHomeController
                                                        .serchproductlist[index]
                                                    ["subtype"],
                                                maxLines: 1,
                                                style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    color: Colors.grey,
                                                    fontSize: 12),
                                              ),
                                            )),
                                        Container(
                                            margin: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.019,
                                                bottom: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.02),
                                            child: Text(
                                              "₹ ${int.parse(buyerHomeController.serchproductlist[index]["price"])}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 15),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              }),

              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05,
                    vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Categories For You",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.black87),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(BuyerCategory());
                      },
                      child: Text(
                        "View all",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: kPrimaryLightColor,
                            fontSize: 15),
                      ),
                    )
                  ],
                ),
              ),

              //Gridview of category product
              Obx(() {
                return buyerHomeController.homeproductlist.isNotEmpty
                    ? Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.04,
                        ),
                        child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                buyerHomeController.homeproductlist.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing:
                                        MediaQuery.of(context).size.width *
                                            0.025,
                                    crossAxisSpacing:
                                        MediaQuery.of(context).size.width *
                                            0.025,
                                    mainAxisExtent:
                                        MediaQuery.of(context).size.height *
                                            0.35,
                                    crossAxisCount: 2),
                            itemBuilder: (BuildContext context, index) {
                              double price = double.parse(buyerHomeController
                                  .homeproductlist[index]["price"]
                                  .toString());

                              double discountPrice = price * 1.20;

                              return InkWell(
                                onTap: () async {
                                  if (prefManager.serchlist.length >= 3) {
                                    prefManager.serchlist.removeAt(0);
                                  }
                                  var str =
                                      "${buyerHomeController.homeproductlist[index]["gender"]}+${buyerHomeController.homeproductlist[index]["category"]}";

                                  // if (!prefManager.serchlist.contains(str)) {
                                  prefManager.serchlist.add(str);
                                  // }

                                  await prefManager.setlastserch();

                                  buyerHomeController.serchproductlist.clear();
                                  await buyerHomeController.getserchproduct(
                                      prefManager.serchlist.reversed.toList());

                                  Get.to(BuyerHomeCategoryProductDescription(
                                    productdatalist: buyerHomeController
                                        .homeproductlist[index],
                                    //  "${buyerHomeController.productlist[index][]}",
                                  ));
                                },
                                child: Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.20,
                                        width: Get.width,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10)),
                                          child: CachedNetworkImage(
                                            progressIndicatorBuilder:
                                                (context, url, progress) =>
                                                    Center(
                                              child: CircularProgressIndicator(
                                                color: kPrimaryColor,
                                              ),
                                            ),
                                            imageUrl: buyerHomeController
                                                    .homeproductlist[index]
                                                ["imgurl"][0],
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 2),
                                        child: Text(
                                          "${buyerHomeController.homeproductlist[index]["name"]}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              color: Colors.black54
                                                  .withOpacity(0.6)),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(
                                            left: 8,
                                          ),
                                          child: Text(
                                            "₹ ${discountPrice.toStringAsFixed(2)}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                fontSize: 12,
                                                color: Colors.black54
                                                    .withOpacity(0.6)),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                child: Text(
                                              "₹ ${buyerHomeController.homeproductlist[index]["price"]}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14),
                                            )),
                                            Text(
                                              "${buyerHomeController.homeproductlist[index]["stock"]} In Stock",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      )
                    : Center(
                        child: CircularProgressIndicator(
                          color: kPrimaryColor,
                        ),
                      );
              })
            ],
          ),
        ),
      ),
    );
  }
}
