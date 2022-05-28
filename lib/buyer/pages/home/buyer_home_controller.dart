import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BuyerHomeController extends GetxController {
  RxBool addToCart = false.obs;
  RxBool addToWishList = false.obs;
  RxString selectedSize = "".obs;
  RxList homeproductlist = [].obs;

  //data
  RxList productlist = [].obs;
  RxBool isdataload = false.obs;

  //serch
  RxList serchproductlist = [].obs;
  RxBool isserchdataload = false.obs;

  //price
  RxList priceproductlist = [].obs;
  //bytype
  RxList typeproductlist = [].obs;
  //subbytype
  RxList subtypeproductlist = [].obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List alldata = [];
  Future<void> getproduct() async {
    productlist.clear();
    CollectionReference data = firestore.collection("seller");
    QuerySnapshot datasnapshort = await data.get();
    List ids = datasnapshort.docs.map((doc) => doc.data()).toList();

    //man
    ids.forEach((element) async {
      // print(element["uid"]);
      CollectionReference sandalsdata = firestore
          .collection("seller")
          .doc(element["uid"])
          .collection("product")
          .doc("Man")
          .collection("Sandals");

      QuerySnapshot datasnapshort = await sandalsdata.get();

      datasnapshort.docs.map((sandals) {
        Map productdata = sandals.data() as Map;
        productlist.add(productdata);
      }).toList();
      CollectionReference Shoesdata = firestore
          .collection("seller")
          .doc(element["uid"])
          .collection("product")
          .doc("Man")
          .collection("Shoes");

      QuerySnapshot datasnapshort2 = await Shoesdata.get();

      datasnapshort2.docs.map((sandals) {
        Map productdata = sandals.data() as Map;
        productlist.add(productdata);
      }).toList();
      CollectionReference Slippersdata = firestore
          .collection("seller")
          .doc(element["uid"])
          .collection("product")
          .doc("Man")
          .collection("Slippers");

      QuerySnapshot datasnapshort3 = await Slippersdata.get();

      datasnapshort3.docs.map((sandals) {
        Map productdata = sandals.data() as Map;
        productlist.add(productdata);
      }).toList();

      //woman
      CollectionReference womansandalsdata = firestore
          .collection("seller")
          .doc(element["uid"])
          .collection("product")
          .doc("Woman")
          .collection("Sandals");

      QuerySnapshot womandatasnapshort = await womansandalsdata.get();

      womandatasnapshort.docs.map((sandals) {
        Map productdata = sandals.data() as Map;
        productlist.add(productdata);
      }).toList();
      CollectionReference womanheelsdata = firestore
          .collection("seller")
          .doc(element["uid"])
          .collection("product")
          .doc("Woman")
          .collection("Heels");

      QuerySnapshot womandatasnapshort2 = await womanheelsdata.get();

      womandatasnapshort2.docs.map((sandals) {
        Map productdata = sandals.data() as Map;
        productlist.add(productdata);
      }).toList();
      CollectionReference womanshoesdata = firestore
          .collection("seller")
          .doc(element["uid"])
          .collection("product")
          .doc("Woman")
          .collection("Shoes");

      QuerySnapshot womandatasnapshort3 = await womanshoesdata.get();

      womandatasnapshort3.docs.map((sandals) {
        Map productdata = sandals.data() as Map;
        productlist.add(productdata);
      }).toList();
      CollectionReference childshoesdata = firestore
          .collection("seller")
          .doc(element["uid"])
          .collection("product")
          .doc("Children")
          .collection("Shoes");

      QuerySnapshot childdatasnapshort = await childshoesdata.get();

      childdatasnapshort.docs.map((sandals) {
        Map productdata = sandals.data() as Map;
        productlist.add(productdata);
      }).toList();
      CollectionReference childsandalsdata = firestore
          .collection("seller")
          .doc(element["uid"])
          .collection("product")
          .doc("Children")
          .collection("Sandals");

      QuerySnapshot childatasnapshort2 = await childsandalsdata.get();

      childatasnapshort2.docs.map((sandals) {
        Map productdata = sandals.data() as Map;
        productlist.add(productdata);
      }).toList();

      CollectionReference childbootdata = firestore
          .collection("seller")
          .doc(element["uid"])
          .collection("product")
          .doc("Children")
          .collection("Boot");

      QuerySnapshot childdatasnapshort3 = await childbootdata.get();

      childdatasnapshort3.docs.map((sandals) {
        Map productdata = sandals.data() as Map;
        productlist.add(productdata);
      }).toList();
    });
  }

  Future<void> getserchproduct(List serchlist) async {
    CollectionReference data = firestore.collection("seller");
    QuerySnapshot datasnapshort = await data.get();
    List ids = datasnapshort.docs.map((doc) => doc.data()).toList();

    ids.forEach((element) async {
      // print(element["uid"]);
      CollectionReference sandalsdata = firestore
          .collection("seller")
          .doc(element["uid"])
          .collection("product")
          .doc(serchlist[0].toString().split("+")[0])
          .collection(serchlist[0].toString().split("+")[1]);

      QuerySnapshot datasnapshort = await sandalsdata.get();

      datasnapshort.docs.map((sandals) {
        Map productdata = sandals.data() as Map;
        serchproductlist.add(productdata);
      }).toList();
      CollectionReference Shoesdata = firestore
          .collection("seller")
          .doc(element["uid"])
          .collection("product")
          .doc(serchlist[1].toString().split("+")[0])
          .collection(serchlist[1].toString().split("+")[1]);

      QuerySnapshot datasnapshort2 = await Shoesdata.get();

      datasnapshort2.docs.map((sandals) {
        Map productdata = sandals.data() as Map;
        serchproductlist.add(productdata);
      }).toList();
      CollectionReference Slippersdata = firestore
          .collection("seller")
          .doc(element["uid"])
          .collection("product")
          .doc(serchlist[2].toString().split("+")[0])
          .collection(serchlist[2].toString().split("+")[1]);

      QuerySnapshot datasnapshort3 = await Slippersdata.get();
      datasnapshort3.docs.map((sandals) {
        Map productdata = sandals.data() as Map;
        serchproductlist.add(productdata);
      }).toList();
    });
    isserchdataload.value = true;
    serchproductlist.shuffle();
  }

  Future<void> getbyprice(int price) async {
    priceproductlist.clear();
    productlist.forEach((element) {
      if (int.parse(element["price"]) < price) {
        priceproductlist.add(element);
      }
    });
  }

  Future<void> getbytype(String type) async {
    typeproductlist.clear();
    productlist.forEach((element) {
      if (element["category"] == type) {
        typeproductlist.add(element);
      }
    });
  }

  Future<void> getbysubtype(String subtype) async {
    subtypeproductlist.clear();
    productlist.forEach((element) {
      if (element["subtype"] == subtype) {
        subtypeproductlist.add(element);
      }
    });
  }

  Future<void> get30product() async {
    homeproductlist.clear();
    CollectionReference data = firestore.collection("seller");
    QuerySnapshot datasnapshort = await data.get();
    List ids = datasnapshort.docs.map((doc) => doc.data()).toList();
    ids.forEach((element) async {
      CollectionReference sandalsdata = firestore
          .collection("seller")
          .doc(element["uid"])
          .collection("product")
          .doc("Man")
          .collection("Sandals");

      QuerySnapshot datasnapshort = await sandalsdata.get();
      datasnapshort.docs.map((sandals) {
        Map productdata = sandals.data() as Map;
        homeproductlist.add(productdata);
      }).toList();

      CollectionReference womanheelsdata = firestore
          .collection("seller")
          .doc(element["uid"])
          .collection("product")
          .doc("Woman")
          .collection("Heels");

      QuerySnapshot womandatasnapshort2 = await womanheelsdata.get();

      womandatasnapshort2.docs.map((sandals) {
        Map productdata = sandals.data() as Map;
        homeproductlist.add(productdata);
      }).toList();

      CollectionReference childbootdata = firestore
          .collection("seller")
          .doc(element["uid"])
          .collection("product")
          .doc("Children")
          .collection("Boot");

      QuerySnapshot childdatasnapshort3 = await childbootdata.get();

      childdatasnapshort3.docs.map((sandals) {
        Map productdata = sandals.data() as Map;
        homeproductlist.add(productdata);
      }).toList();

      homeproductlist.shuffle();
    });
  }
}
