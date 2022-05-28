import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:footwearclub/authentication/sign_in/loginform.dart';
import 'package:footwearclub/constants/constant.dart';
import 'package:footwearclub/constants/size_mediaquery.dart';
import 'package:footwearclub/seller/constants/seller_constant.dart';
import 'package:footwearclub/seller/pages/addproduct/add_product_screen.dart';
import 'package:footwearclub/seller/pages/products/get_product.dart';
import 'package:footwearclub/seller/pages/products/products_controller.dart';
import 'package:get/get.dart';

TextEditingController namecontroller = TextEditingController();
TextEditingController desccontroller = TextEditingController();
TextEditingController prisecontroller = TextEditingController();
TextEditingController colorcontroller = TextEditingController();
TextEditingController stockcontroller = TextEditingController();
TextEditingController weightcontroller = TextEditingController();

class EditProduct extends StatefulWidget {
  final Map data;
  EditProduct({Key? key, required this.data}) : super(key: key);

  @override
  State<EditProduct> createState() => EditProductState();
}

class EditProductState extends State<EditProduct> {
  final List<String?> errors = [];
  FirebaseAuth firebaseAuth =FirebaseAuth.instance;

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  @override
  void initState() {
    super.initState();

    namecontroller.text = widget.data["name"];
    desccontroller.text = widget.data["desc"];
    prisecontroller.text = widget.data["price"];
    colorcontroller.text = widget.data["color"];
    stockcontroller.text = widget.data["stock"];
    weightcontroller.text = widget.data["weight"];
  }

  void updatestock() async {
    var newgender = addproductcontroller.selectgender.value;
    var newtype = addproductcontroller.type.value;
    var newsubtype = addproductcontroller.subtype.value;
    var gender = widget.data["gender"];
    var category = widget.data["category"];
    var productId = widget.data["productid"];
    EasyLoading.show(status: 'Updating...');
    print(namecontroller.text);
    var collection = FirebaseFirestore.instance.collection('seller');

    // await getUid().then((uid) {
      collection
          .doc(firebaseAuth.currentUser!.uid)
          .collection("product")
          .doc(gender)
          .collection(category)
          .doc(productId)
          .update({
        "stock": stockcontroller.text,
        "name": namecontroller.text,
        "desc": desccontroller.text,
        "price": prisecontroller.text,
        "color": colorcontroller.text,
        "weight": weightcontroller.text,
        "gender": newgender,
        "category": newtype,
        "subtype": newsubtype,
      }).whenComplete(() async {
      print("update success");
      ProductController productController = Get.put(ProductController());
      productController.productData.clear();
      await getProduct().whenComplete(() {
        EasyLoading.showSuccess('Update Successfully!');
        EasyLoading.dismiss();
        Get.back();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().initsize(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Update Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              buildNAmeFormField(),
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              builddescFormField(),
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              buildpriseFormField(),
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              buildcolorFormField(),
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              buildstockFormField(),
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              buildWeightFormField(),
              SizedBox(height: SizeConfig.screenHeight * 0.03),


              SizedBox(height: getProportionateScreenHeight(20)),
              FormError(errors: errors),

              DefaultButton(
                text: "Update",
                press: () async {
                  KeyboardUtil.hideKeyboard(context);
                  if (namecontroller.text.isEmpty) {
                    addError(error: Enterproductname);
                  }
                  if (colorcontroller.text.isEmpty) {
                    addError(error: Enterproductcolor);
                  }
                  if (desccontroller.text.isEmpty) {
                    addError(error: Enterproductdesc);
                  }
                  if (prisecontroller.text.isEmpty) {
                    addError(error: Enterproductprise);
                  }
                  if (stockcontroller.text.isEmpty) {
                    addError(error: Enterproductstock);
                  }
                  if (weightcontroller.text.isEmpty) {
                    addError(error: Enterproductweight);
                  }
                  if (namecontroller.text.isNotEmpty &&
                      desccontroller.text.isNotEmpty &&
                      prisecontroller.text.isNotEmpty &&
                      stockcontroller.text.isNotEmpty &&
                      colorcontroller.text.isNotEmpty &&
                      weightcontroller.text.isNotEmpty) {
                    updatestock();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

TextFormField buildNAmeFormField() {
  return TextFormField(
    controller: namecontroller,
    cursorColor: kPrimaryColor,
    keyboardType: TextInputType.name,
    onSaved: (newValue) => ProductName = newValue,
    decoration: const InputDecoration(
        labelText: "Product Name",
        labelStyle: TextStyle(color: kPrimaryColor),
        hintText: "Enter Product Name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIconColor: kPrimaryColor),
  );
}

TextFormField builddescFormField() {
  return TextFormField(
    controller: desccontroller,
    cursorColor: kPrimaryColor,
    keyboardType: TextInputType.text,
    onSaved: (newValue) => ProductDesc = newValue,
    decoration: const InputDecoration(
        labelText: "Product description",
        labelStyle: TextStyle(color: kPrimaryColor),
        hintText: "Enter Product description",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIconColor: kPrimaryColor),
  );
}

TextFormField buildpriseFormField() {
  return TextFormField(
    controller: prisecontroller,
    cursorColor: kPrimaryColor,
    keyboardType: TextInputType.number,
    onSaved: (newValue) => ProductPrise = newValue,
    decoration: const InputDecoration(
        labelText: "Product Price",
        labelStyle: TextStyle(color: kPrimaryColor),
        hintText: "Enter Product Price",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIconColor: kPrimaryColor),
  );
}

TextFormField buildcolorFormField() {
  return TextFormField(
    controller: colorcontroller,
    cursorColor: kPrimaryColor,
    keyboardType: TextInputType.text,
    onSaved: (newValue) => ProductColor = newValue,
    decoration: const InputDecoration(
        labelText: "Product Color",
        labelStyle: TextStyle(color: kPrimaryColor),
        hintText: "Enter Product Color",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIconColor: kPrimaryColor),
  );
}

TextFormField buildstockFormField() {
  return TextFormField(
    controller: stockcontroller,
    cursorColor: kPrimaryColor,
    keyboardType: TextInputType.number,
    onSaved: (newValue) => Productstock = newValue,
    decoration: const InputDecoration(
        labelText: "Product Stock",
        labelStyle: TextStyle(color: kPrimaryColor),
        hintText: "Enter Product Stock",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIconColor: kPrimaryColor),
  );
}

TextFormField buildWeightFormField() {
  return TextFormField(
    controller: weightcontroller,
    cursorColor: kPrimaryColor,
    keyboardType: TextInputType.number,
    onSaved: (newValue) => ProductWeight = newValue,
    decoration: const InputDecoration(
        labelText: "Product Weight",
        labelStyle: TextStyle(color: kPrimaryColor),
        hintText: "Ex: 100 Grams",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIconColor: kPrimaryColor),
  );
}
