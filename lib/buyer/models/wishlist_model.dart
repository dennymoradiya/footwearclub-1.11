// To parse this JSON data, do
//
//     final wishListModel = wishListModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class WishListModel {
  WishListModel({
    this.id,
     this.title,
     this.price,
     this.color,
     this.stock,
     this.imgurl,
     this.sellerid,
     this.productid,
     this.subtype,
     this.category,
    //  this.productdatalist
  });

  final int? id;
  final String? title;
  final String? price;
  final String? stock;
  final String? color;
  final String? imgurl;
  final String? sellerid;
  final String? productid;
  final String? subtype;
  final String? category;
  // final Map<String, dynamic>? productdatalist;

  factory WishListModel.fromJson(String str) =>
      WishListModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WishListModel.fromMap(Map<String, dynamic> json) => WishListModel(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        color: json["color"],
        stock: json["stock"],
        imgurl: json["imgurl"],
        sellerid: json["sellerid"],
        productid: json["productid"],
        subtype: json["subtype"],
        category: json["category"],
        // productdatalist : json["productdatalist"]
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "price": price,
        "color": color,
        "stock": stock,
        "imgurl": imgurl,
        "sellerid" : sellerid,
        "productid" : productid,
        "subtype" : subtype,
        "category" : category,
        // "productdatalist" :productdatalist
      };
}
