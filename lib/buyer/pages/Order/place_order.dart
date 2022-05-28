import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:footwearclub/buyer/database/cart_db.dart';
import 'package:footwearclub/buyer/models/cart_model.dart';
import 'package:footwearclub/buyer/pages/Cart/update_address_controller.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
CartHelper cartHelper = CartHelper();
UpdateAddressController updateAddressController =
    Get.put(UpdateAddressController());
FirebaseAuth firebaseAuth = FirebaseAuth.instance;


Future loadOrder() async {
  cartHelper.initializeDatabase();
  cartHelper.getCartList().then((element) {
    element.forEach((cartitem) async {
      String uniqueId = Uuid().v1();
      String trimmedString = uniqueId.split("-").join("");
      var orderid = trimmedString.substring(0, 11);
      setOrder(cartitem, orderid);
    });
  });
}

void setOrder(CartModel cartitem, orderid) async {
  var totalamt = int.parse(cartitem.price.toString()) *
      int.parse(cartitem.quantity.toString());
  var data = await _firestore
      .collection("buyer")
      .doc(firebaseAuth.currentUser!.uid)
      .get();
  // print(data["name"]);

  var email = firebaseAuth.currentUser!.email;
  var name = data["name"];
  var phone = updateAddressController.number.value;
  var address = updateAddressController.address.value;
  var city = updateAddressController.city.value;
  var state = updateAddressController.state.value;
  var pincode = updateAddressController.pincode.value;


  Map<String, dynamic> buyerDetail = {
    "name": name,
    "email": email,
    "phone": phone,
    "address": address,
    "city": city,
    "state": state,
    "pincode": pincode,
  };

  // await getUid().then((uid) {
  _firestore
      .collection("buyer")
      .doc(firebaseAuth.currentUser!.uid)
      .collection("orders")
      .doc(orderid)
      .set({
    "orderid": orderid,
    "sellerid": cartitem.sellerid,
    "productid": cartitem.productid,
    "name": cartitem.title,
    "price": cartitem.price,
    "size": cartitem.size,
    "quantity": cartitem.quantity,
    "imgurl": cartitem.imgurl,
    "totalamt": totalamt,
    "rating": "",
    "time": FieldValue.serverTimestamp()
    // });
  });

  _firestore
      .collection("seller")
      .doc(cartitem.sellerid)
      .collection("orders")
      .doc(orderid)
      .set({
    "orderid": orderid,
    "sellerid": cartitem.sellerid,
    "productid": cartitem.productid,
    "name": cartitem.title,
    "price": cartitem.price,
    "size": cartitem.size,
    "quantity": cartitem.quantity,
    "imgurl": cartitem.imgurl,
    "totalamt": totalamt,
    "buyerdeatil": FieldValue.arrayUnion([buyerDetail]),
    "time": FieldValue.serverTimestamp()
  });
  print("order place");
}
