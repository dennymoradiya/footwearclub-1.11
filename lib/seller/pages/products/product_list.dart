import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:footwearclub/authentication/shred_pref.dart';
import 'package:footwearclub/seller/constants/seller_constant.dart';
import 'package:footwearclub/seller/pages/addproduct/edit_product.dart';
import 'package:footwearclub/seller/pages/products/products_controller.dart';
import 'package:get/get.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}


class _ProductListState extends State<ProductList> {
  ProductController productController = Get.put(ProductController());
  @override
  void initState() {
    super.initState();
  }

  var collection = FirebaseFirestore.instance.collection('seller');
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void deleteProduct(data) async {
    var gender = data["gender"];
    var category = data["category"];
    var productId = data["productid"];

    collection
        .doc(firebaseAuth.currentUser!.uid)
        .collection("product")
        .doc(gender)
        .collection(category)
        .doc(productId)
        .delete()
        .whenComplete(() {
      Get.back();
      scafoldmessage(context, "Product Deleted Successfully! ");
    });
  }

  @override
  Widget build(BuildContext context) {
    //show productlist
    return Obx(
      () => productController.productData.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: productController.productData.length,
              itemBuilder: (BuildContext context, int index) {
                var data = productController.productData[index];
                // print(data);
                return Container(
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
                            height: 60,
                            width: Get.width * 0.2,
                            imageUrl: data["imgurl"][0].toString(),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 10),
                        child: Container(
                          width: Get.width * 0.65,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  productController.productData[index]["name"],
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Text("Rs: ${data['price']}"),
                              Text("Category: ${data['subtype']}"),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Stock: ${data['stock']}"),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.to(EditProduct(data: data));
                                        },
                                        child: Icon(
                                          Icons.edit,
                                          size: 23,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                    content: Text(
                                                        "Are You Sure Want to Delete Product?"),
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
                                                          deleteProduct(data);
                                                          productController
                                                              .productData
                                                              .removeAt(index);
                                                        },
                                                      )
                                                    ],
                                                  ));

                                          // getProduct();
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          size: 23,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          : Center(child: Text("No Poducts")),
    );
  }
}
