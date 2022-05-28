import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:footwearclub/constants/constant.dart';
import 'package:footwearclub/seller/constants/seller_constant.dart';
import 'package:footwearclub/seller/database/readytoship.dart';
import 'package:footwearclub/seller/models/readytoship_model.dart';
import 'package:footwearclub/seller/pages/addproduct/add_product_screen.dart';
import 'package:footwearclub/seller/pages/pdf/invoice.dart';
import 'package:footwearclub/seller/pages/pdf/pdf_api.dart';
import 'package:footwearclub/seller/pages/pdf/pdf_invoice_api.dart';
import 'package:get/get.dart';

class ReadytoshipScreen extends StatefulWidget {
  const ReadytoshipScreen({Key? key}) : super(key: key);

  @override
  State<ReadytoshipScreen> createState() => ReadytoshipScreenState();
}

class ReadytoshipScreenState extends State<ReadytoshipScreen> {
  ReadyToShipHelper readyToShipHelper = ReadyToShipHelper();
  Future<List<ReadyToShipModel>>? readytoshiporderlist;
  List<ReadyToShipModel> currentreadytoshiporder = [];

  @override
  void initState() {
    super.initState();
    readyToShipHelper.initializeDatabase();
    loadOrder();
  }

  String? businesname;

  void loadOrder() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    firestore
        .collection("seller")
        .doc(firebaseAuth.currentUser!.uid)
        .get()
        .then((DocumentSnapshot ds) {
      Map data = ds.data() as Map;
      businesname = data["businessname"];
      print(businesname);
      setState(() {});
    });

    readytoshiporderlist = readyToShipHelper.getReadytoshipList();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    void generatePdf(ReadyToShipModel data, String bname) async {
      final invoice = Invoice(
        supplier: Supplier(
          name: bname,
          paymentInfo: 'Cash on delivery',
        ),
        customer: Customer(
          phone: data.buyerphone,
          name: data.buyername,
          address: data.buyeraddress,
        ),
        info: InvoiceInfo(
          orderid: data.orderid,
          date: data.date,
          number: '${DateTime.now().second}${DateTime.now().year}${DateTime.now().microsecond}',
        ),
        items: [
          InvoiceItem(
            name: data.title,
            date: data.date.toString(),
            quantity: int.parse(data.quantity),
            unitPrice: double.parse(data.price),
          ),
        ],
      );
      final pdfFile = await PdfInvoiceApi.generate(invoice);
      PdfApi.openFile(pdfFile);
    }

    var size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: readytoshiporderlist,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          currentreadytoshiporder = snapshot.data;
          return ListView.builder(
            itemCount: currentreadytoshiporder.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 2, right: 2),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // if you need this
                    side: BorderSide(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Container(
                    height: 265,
                    width: size.width * 0.90,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.1),
                          blurRadius: 40.0, // soften the shadow
                          spreadRadius: 10, //extend the shadow
                          offset: const Offset(
                            5.0, // Move to right 10  horizontally
                            5.0, // Move to bottom 10 Vertically
                          ),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                  "Date: ${currentreadytoshiporder[index].date}"),
                            ),
                            SizedBox(
                              height: 30.0,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.green, // background
                                    onPrimary: Colors.black, // foreground
                                  ),
                                  onPressed: () async {
                                    generatePdf(currentreadytoshiporder[index],
                                        businesname!);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.download,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'LABEL',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ), // Text("17 feb , 2:12 PM")
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            currentreadytoshiporder[index].title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                progressIndicatorBuilder:
                                    (context, url, progress) => Center(
                                  child: CircularProgressIndicator(
                                    color: kSellerPrimaryColor,
                                  ),
                                ),
                                height: 100,
                                width: Get.width * 0.25,
                                imageUrl: currentreadytoshiporder[index].imgurl,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Container(
                              width: size.width * 0.65,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 14),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Order Id"),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Text(
                                            currentreadytoshiporder[index]
                                                .orderid
                                                .toString(),
                                            style: TextStyle(
                                                overflow:
                                                    TextOverflow.ellipsis),
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      height: 3,
                                      color: Colors.grey,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Size"),
                                        Text(currentreadytoshiporder[index]
                                            .size),
                                      ],
                                    ),
                                    const Divider(
                                      height: 3,
                                      color: Colors.grey,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Quantity"),
                                        Text(currentreadytoshiporder[index]
                                            .quantity
                                            .toString()),
                                      ],
                                    ),
                                    const Divider(
                                      height: 3,
                                      color: Colors.grey,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Price"),
                                        Text(
                                            "${currentreadytoshiporder[index].price.toString()} ₹"),
                                      ],
                                    ),
                                    const Divider(
                                      height: 3,
                                      color: Colors.grey,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Total amount",
                                          style:
                                              TextStyle(color: kPrimaryColor),
                                        ),
                                        Text(
                                          "${currentreadytoshiporder[index].totalamt} ₹",
                                          style:
                                              TextStyle(color: kPrimaryColor),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      height: 3,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
        return Center(
            child: CircularProgressIndicator(
          color: kSellerPrimaryColor,
        ));
      },
    );
  }
}
