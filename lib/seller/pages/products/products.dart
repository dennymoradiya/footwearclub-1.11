import 'package:flutter/material.dart';
import 'package:footwearclub/seller/constants/seller_constant.dart';
import 'package:footwearclub/seller/pages/addproduct/add_product_screen.dart';
import 'package:get/get.dart';
import 'product_list.dart';

class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSellerPrimaryColor,
        title: const Text('All Products'),
        centerTitle: true,
      ),
      // drawer: SellerDrawer(),
      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 10,
          ),
          ProductList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Get.to(Addproduct());
     
        },
        backgroundColor: kSellerPrimaryColor,
        child: Icon(Icons.add),
      ),
    );
  }
}
