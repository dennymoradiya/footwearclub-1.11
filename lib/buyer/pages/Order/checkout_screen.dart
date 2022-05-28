import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:footwearclub/authentication/shred_pref.dart';
import 'package:footwearclub/buyer/database/cart_db.dart';
import 'package:footwearclub/buyer/pages/Cart/cart_controller.dart';
import 'package:footwearclub/buyer/pages/Cart/update_address.dart';
import 'package:footwearclub/buyer/pages/Cart/update_address_controller.dart';
import 'package:footwearclub/buyer/pages/Order/checkout_controller.dart';
import 'package:footwearclub/buyer/pages/Payment/razor_pay.dart';
import 'package:footwearclub/constants/constant.dart';
import 'package:footwearclub/constants/light_color.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'place_order.dart';
import 'choose_payment_screen.dart';
import 'sucess_order.dart';

class CheckOutScreen extends StatefulWidget {
  CheckOutScreen({
    Key? key,
  }) : super(key: key);
  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  CheckOutController checkOutController = Get.put(CheckOutController());
  CartHelper cartHelper = CartHelper();

  int merchantTotal = 0;
  int shippingTotal = 60;
  var totalamt = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    cartHelper.initializeDatabase();
    cartHelper.getCartList().then((element) {
      totalamt = 0;
      checkOutController.cartItem.clear();
      element.forEach((cartitem) async {
        checkOutController.cartItem.add(cartitem);
        totalamt += int.parse(cartitem.price.toString()) *
            int.parse(cartitem.quantity.toString());
      });
      setState(() {
        merchantTotal = totalamt;
      });
    });
    UpdateAddressController updateAddressController =
        Get.put(UpdateAddressController());

    var jiffy1 = Jiffy().add(duration: Duration(days: 7));
    var jiffy2 = Jiffy().add(duration: Duration(days: 11));

    var deliverystartdt = jiffy1.MMMd;
    var deliveryenddt = jiffy2.MMMd;

    return Scaffold(
      appBar: AppBar(
          title: Text("Checkout"),
          backgroundColor: kPrimaryLightColor,
          elevation: 2,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              size: 28,
            ),
          )),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Get.width,
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                  child: Obx(() => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Address",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.to(Update_Address());
                                },
                                child: Icon(
                                  Icons.edit,
                                  color: kPrimaryColor,
                                  size: 25,
                                ),
                              )
                            ],
                          ),
                          Text(
                            updateAddressController.address.value,
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            "${updateAddressController.city.value} ${updateAddressController.pincode.value}",
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            updateAddressController.state.value,
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            updateAddressController.number.value,
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      )),
                ),
              ),
              Divider(
                height: 15,
                color: Colors.grey,
              ),
              Obx(
                () => checkOutController.cartItem.length != 0
                    ? ListView.separated(
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: checkOutController.cartItem.length,
                        itemBuilder: (BuildContext context, int index) {
                          var myItem = checkOutController.cartItem[index];

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: CachedNetworkImage(
                                      progressIndicatorBuilder:
                                          (context, url, progress) => Center(
                                        child: CircularProgressIndicator(
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                      imageUrl: myItem.imgurl.toString(),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: Container(
                                    height: 85,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          myItem.title.toString(),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Category : ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(myItem.category.toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600))
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "₹ ${myItem.price.toString()}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.close,
                                                  size: 14,
                                                  color: Colors.grey,
                                                ),
                                                Text(myItem.quantity.toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600))
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      )
                    : Divider(
                        height: 15,
                        color: Colors.grey,
                      ),
              ),
              Divider(
                height: 40,
                color: LightColor.grey.withOpacity(0.2),
                thickness: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Delivery",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Recived by $deliverystartdt - $deliveryenddt",
                        ),
                      ),
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Text(
                        "₹ $shippingTotal",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ))
                ],
              ),
              Divider(
                height: 30,
                color: Colors.grey,
                thickness: 0.7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Sub Total",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 16),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Text(
                        "₹ $merchantTotal",
                        style: TextStyle(
                            color: kPrimaryLightColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ))
                ],
              ),
              Divider(
                height: 40,
                color: LightColor.grey.withOpacity(0.2),
                thickness: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Payment Option",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: Colors.black87),
                    ),
                  ),
                  Row(
                    children: [
                      Obx(() => Text(
                            checkOutController.payOption.value,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          )),
                      Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: InkWell(
                              onTap: () {
                                Get.to(ChoosePaymentScreen());
                              },
                              child: Icon(Icons.arrow_forward_ios_rounded)))
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Merchandise Subtotal",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                      "₹ $merchantTotal",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Shipping Subtotal",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                      "₹ $shippingTotal",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Your Payment",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                      "₹ ${merchantTotal + shippingTotal}",
                      style: TextStyle(
                          color: kPrimaryLightColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: Get.height * 0.08,
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
                child: Container(
              alignment: Alignment.center,
              color: Colors.grey.withOpacity(0.1),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Total Payment",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                    Text(
                      "₹ ${merchantTotal + shippingTotal}",
                      style: TextStyle(
                          color: kPrimaryLightColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
            )),
            Expanded(
                child: InkWell(
              onTap: () {
                if (checkOutController.payOption.value == "") {
                  scafoldmessage(context, "Please select payment option");
                } else if (checkOutController.payOption.value == "COD") {
                  loadOrder().then((value) {
                    Get.off(OrderSuccess());
                  });
                } else {
                  Get.to(RazorPayGateway(total: merchantTotal));
                }
              },
              child: Container(
                alignment: Alignment.center,
                color: kPrimaryLightColor,
                child: Text(
                  "Place Order",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
