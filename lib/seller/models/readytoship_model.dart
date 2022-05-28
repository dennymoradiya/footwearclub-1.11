import 'dart:convert';

class ReadyToShipModel {
  ReadyToShipModel({
    this.id,
    required this.orderid,
    required this.title,
    required this.quantity,
    required this.price,
    required this.totalamt,
    required this.size,
    required this.imgurl,
    required this.date,
    required this.buyername,
    required this.buyeraddress,
    required this.buyerphone,
  });

  final int? id;
  final String orderid;
  final String title;
  final String quantity;
  final String price;
  final String totalamt;
  final String size;
  final String imgurl;
  final String date;
  final String buyername;
  final String buyeraddress;
  final String buyerphone;

  factory ReadyToShipModel.fromJson(String str) =>
      ReadyToShipModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ReadyToShipModel.fromMap(Map<String, dynamic> json) =>
      ReadyToShipModel(
        id: json["id"],
        orderid: json["orderid"],
        title: json["title"],
        quantity: json["quantity"],
        price: json["price"],
        totalamt: json["totalamt"],
        size: json["size"],
        imgurl: json["imgurl"],
        date: json["date"],
        buyername: json["buyername"],
        buyeraddress: json["buyeraddress"],
        buyerphone: json["buyerphone"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "orderid": orderid,
        "title": title,
        "quantity": quantity,
        "price": price,
        "totalamt": totalamt,
        "size": size,
        "imgurl": imgurl,
        "date": date,
        "buyername": buyername,
        "buyeraddress": buyeraddress,
        "buyerphone": buyerphone,
      };
}