import 'package:flutter/material.dart';
import 'package:footwearclub/authentication/shred_pref.dart';
import 'package:footwearclub/authentication/sign_in/loginform.dart';
import 'package:footwearclub/buyer/pages/Cart/update_address_controller.dart';
import 'package:footwearclub/buyer/pages/Order/checkout_screen.dart';
import 'package:footwearclub/constants/constant.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';

class Update_Address extends StatefulWidget {
  const Update_Address({
    Key? key,
  }) : super(key: key);

  @override
  _Update_AddressState createState() => _Update_AddressState();
}

class _Update_AddressState extends State<Update_Address> {
  UpdateAddressController updateAddressController =
      Get.put(UpdateAddressController());

  var items = [
    'Home',
    'Office',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Edit Address",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Get.off(CheckOutScreen());
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: updateAddressController.address.value,
                cursorColor: kPrimaryColor,
                onChanged: (value) {
                  updateAddressController.address.value = value;
                },
                decoration: const InputDecoration(
                    labelText: "Address",
                    labelStyle: TextStyle(color: kPrimaryColor),
                    hintText: "Enter your address",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIconColor: kPrimaryColor),
              ),
              SizedBox(
                height: 14,
              ),
              TextFormField(
                initialValue: updateAddressController.pincode.value,
                maxLength: 6,
                cursorColor: kPrimaryColor,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  updateAddressController.pincode.value = value;
                },
                decoration: const InputDecoration(
                    labelText: "Pincode",
                    labelStyle: TextStyle(color: kPrimaryColor),
                    hintText: "Enter pincode",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIconColor: kPrimaryColor),
              ),
              SizedBox(
                height: 14,
              ),
              TextFormField(
                initialValue: updateAddressController.city.value.toString(),
                cursorColor: kPrimaryColor,
                onChanged: (value) {
                  updateAddressController.city.value = value;
                },
                decoration: const InputDecoration(
                    labelText: "City",
                    labelStyle: TextStyle(color: kPrimaryColor),
                    hintText: "Enter city",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIconColor: kPrimaryColor),
              ),
              SizedBox(
                height: 14,
              ),
              TextFormField(
                initialValue: updateAddressController.state.value,
                cursorColor: kPrimaryColor,
                onChanged: (value) {
                  updateAddressController.state.value = value;
                },
                decoration: const InputDecoration(
                    labelText: "State",
                    labelStyle: TextStyle(color: kPrimaryColor),
                    hintText: "Enter state",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIconColor: kPrimaryColor),
              ),
              SizedBox(
                height: 14,
              ),
              TextFormField(
                initialValue: updateAddressController.number.value,
                cursorColor: kPrimaryColor,
                maxLength: 10,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  updateAddressController.number.value = value;
                },
                decoration: const InputDecoration(
                    labelText: "Contact",
                    labelStyle: TextStyle(color: kPrimaryColor),
                    hintText: "Enter contact number",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIconColor: kPrimaryColor),
              ),
              SizedBox(
                height: 14,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "Address Type :",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 16),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    DropdownButton(
                      value: updateAddressController.type.value,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          updateAddressController.type.value = newValue!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    height: 50,
                    minWidth: 150,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    color: kPrimaryColor,
                    textColor: Colors.white,
                    child: Text(
                      'Save',
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      if (updateAddressController.address.value == "" ||
                          updateAddressController.pincode.value == "" ||
                          updateAddressController.city.value == "" ||
                          updateAddressController.state.value == "" ||
                          updateAddressController.number.value == "") {
                        scafoldmessage(context, "Please fill all fields");
                      } else {
                        print(updateAddressController.address.value);
                        print(updateAddressController.pincode.value);
                        print(updateAddressController.number.value);
                        print(updateAddressController.state.value);
                        print(updateAddressController.city.value);
                        KeyboardUtil.hideKeyboard(context);
                        Get.to(CheckOutScreen());
                      }
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
