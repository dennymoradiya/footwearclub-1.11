import 'package:flutter/material.dart';
import 'package:footwearclub/authentication/shred_pref.dart';
import 'package:footwearclub/authentication/sign_in/loginform.dart';
import 'package:footwearclub/constants/constant.dart';
import 'package:get/route_manager.dart';

import 'delivery_page.dart';

class Add_Adress extends StatefulWidget {
  const Add_Adress({Key? key}) : super(key: key);

  @override
  _Add_AdressState createState() => _Add_AdressState();
}

class _Add_AdressState extends State<Add_Adress> {
  TextEditingController addcontroller = TextEditingController();
  TextEditingController pincodecontroller = TextEditingController();
  TextEditingController citycontroller = TextEditingController();
  TextEditingController statecontroller = TextEditingController();
  TextEditingController contactcontroller = TextEditingController();

  var type = "Home";

  var items = [
    'Home',
    'Office',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Add Address",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
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
                controller: addcontroller,
                cursorColor: kPrimaryColor,
                keyboardType: TextInputType.number,
                //onSaved: (newValue) => ProductPrise = newValue,
                onChanged: (value) {},
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
                controller: pincodecontroller,
                cursorColor: kPrimaryColor,
                keyboardType: TextInputType.number,
                //onSaved: (newValue) => ProductPrise = newValue,
                onChanged: (value) {},
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
                controller: citycontroller,
                cursorColor: kPrimaryColor,
                keyboardType: TextInputType.number,
                //onSaved: (newValue) => ProductPrise = newValue,
                onChanged: (value) {},
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
                controller: statecontroller,
                cursorColor: kPrimaryColor,
                keyboardType: TextInputType.number,
                //onSaved: (newValue) => ProductPrise = newValue,
                onChanged: (value) {},
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
                controller: contactcontroller,
                cursorColor: kPrimaryColor,
                keyboardType: TextInputType.number,
                //onSaved: (newValue) => ProductPrise = newValue,
                onChanged: (value) {},
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
                      value: type,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          type = newValue!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
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
                      setState(() {
                        if (addcontroller.value.text == "" &&
                            pincodecontroller.value.text == "" &&
                            citycontroller.value.text == "" &&
                            statecontroller.value.text == "" &&
                            contactcontroller.value.text == "") {
                          scafoldmessage(context, "Please fill all fields");
                        } else {
                          KeyboardUtil.hideKeyboard(context);
                          Get.to(Delivery_Page());
                        }
                      });
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
