import 'package:flutter/material.dart';
import 'package:footwearclub/constants/constant.dart';
import 'package:get/route_manager.dart';

class Delivery_Page extends StatefulWidget {
  const Delivery_Page({Key? key}) : super(key: key);

  @override
  _Delivery_PageState createState() => _Delivery_PageState();
}

class _Delivery_PageState extends State<Delivery_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        title: Text("Delivery",style: TextStyle(color: Colors.black),),
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Icon(Icons.arrow_back,color: Colors.black,),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: Get.width,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Home Address",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.black),),
                    SizedBox(height: 7,),
                    Text("demo",style: TextStyle(fontSize: 14),),
                    Text("surat 395011",style: TextStyle(fontSize: 14),),
                    Text("Gujarat",style: TextStyle(fontSize: 14),),
                    Text("1234567890",style: TextStyle(fontSize: 14),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: (){
                            // Get.to(Update_Address(address: "demo", pincode: 395010, city: "Surat", state: "Gujarat", type: "Office", contact: '1234567890',));
                          },
                          child: Text("Change Address",style: TextStyle(color: kPrimaryColor),),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              width: Get.width,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text("Order List",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.black),),
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (BuildContext context,int index){
                        return Cartwidget(index);
                      }
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              width: Get.width,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sub Total",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          "₹ 40.16",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ],
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      color: kPrimaryColor,
                      textColor: Colors.white,
                      child: Text("Pay"),
                      onPressed: () {
                        setState(() {

                        });
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget Cartwidget(int index){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0,left: 14,right: 14,bottom: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://www.imagesource.com/wp-content/uploads/2019/06/Rio.jpg"),
                      fit: BoxFit.fill,
                    )),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width - 120,
                        child: Text(
                          "Bardi Smart Light",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        )),
                    Text("2 items (150 gr)",style: TextStyle(fontSize: 12),),
                    Text(
                      "₹ 8.6",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: 5,),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
