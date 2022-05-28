import 'package:flutter/material.dart';
import 'package:footwearclub/buyer/pages/Order/checkout_controller.dart';
import 'package:footwearclub/constants/constant.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ChoosePaymentScreen extends StatefulWidget {
  const ChoosePaymentScreen({Key? key}) : super(key: key);

  @override
  _ChoosePaymentScreenState createState() => _ChoosePaymentScreenState();
}

class _ChoosePaymentScreenState extends State<ChoosePaymentScreen> {
  CheckOutController checkOutController = Get.put(CheckOutController());
  String? selectedVal;

  setSelect(String val) {
    setState(() {
      selectedVal = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Payment Method"),
          backgroundColor: kPrimaryLightColor,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              size: 28,
            ),
          )),
      body: Column(
        children: [
          Expanded(
              child: Column(
            children: [
              Container(
                height: 60,
                width: double.infinity,
                margin: EdgeInsets.all(15),
                child: Card(
                    elevation: 5,
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Radio(
                                activeColor: kPrimaryLightColor,
                                value: "NET BANKING",
                                groupValue: selectedVal,
                                onChanged: (String? val) {
                                  setState(() {
                                    setSelect(val!);
                                  });
                                },
                              ),
                              Text(
                                "NET BANKING",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            width: 80,
                            child: Image.network(
                              "https://s3.ap-south-1.amazonaws.com/rzp-prod-merchant-assets/payment-link/description/paymentlogo123_Cnyouf21KOzj0Z.png",
                              fit: BoxFit.cover,
                            ))
                      ],
                    )),
              ),
              Container(
                height: 60,
                width: double.infinity,
                margin: EdgeInsets.all(15),
                child: Card(
                    elevation: 5,
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Radio(
                                activeColor: kPrimaryLightColor,
                                value: "COD",
                                groupValue: selectedVal,
                                onChanged: (String? val) {
                                  setState(() {
                                    setSelect(val!);
                                  });
                                },
                              ),
                              Text(
                                "Cash on Delivery",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(
                              MdiIcons.cash,
                              size: 40,
                              color: Colors.green,
                            )),
                      ],
                    )),
              ),
            ],
          )),
          selectedVal != null
              ? InkWell(
                  onTap: () {
                    checkOutController.payOption.value = selectedVal!;
                    print(selectedVal);
                    Get.back();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Confirm",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    height: Get.height * 0.07,
                    width: double.infinity,
                    margin: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: kPrimaryLightColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                )
              : Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Confirm",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  height: Get.height * 0.07,
                  width: double.infinity,
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10)),
                )
        ],
      ),
    );
  }
}
