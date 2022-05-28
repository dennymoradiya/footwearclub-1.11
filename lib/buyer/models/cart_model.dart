// To parse this JSON data, do
//
//     final cartModel = cartModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class CartModel {
    CartModel({
         this.id,
         this.title,
         this.price,
         this.color,
         this.stock,
         this.imgurl,
         this.sellerid,
         this.productid,
         this.category,
         this.subtype,
         this.size,
         this.quantity,
    });

    final int? id;
    final String? title;
     String? price;
    final String? color;
    final String? stock;
    final String? imgurl;
    final String? sellerid;
    final String? productid;
    final String? category;
    final String? subtype;
    final String? size;
     String? quantity;

    factory CartModel.fromJson(String str) => CartModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CartModel.fromMap(Map<String, dynamic> json) => CartModel(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        color: json["color"],
        stock: json["stock"],
        imgurl: json["imgurl"],
        sellerid: json["sellerid"],
        productid: json["productid"],
        category: json["category"],
        subtype: json["subtype"],
        size: json["size"],
        quantity: json["quantity"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "price": price,
        "color": color,
        "stock": stock,
        "imgurl": imgurl,
        "sellerid": sellerid,
        "productid": productid,
        "category": category,
        "subtype": subtype,
        "size": size,
        "quantity" :quantity
    };
}
