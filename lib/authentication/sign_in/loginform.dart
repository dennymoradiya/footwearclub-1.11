import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:footwearclub/authentication/shred_pref.dart';
import 'package:footwearclub/authentication/sign_in/forgot_password.dart';
import 'package:footwearclub/authentication/sign_in/logincontroller.dart';
import 'package:footwearclub/authentication/sign_in/signin_with_email.dart';
import 'package:footwearclub/constants/constant.dart';
import 'package:footwearclub/constants/size_mediaquery.dart';
import 'package:footwearclub/seller/seller_main.dart';
import 'package:get/get.dart';

import 'loginsucces.dart';
import 'bussinessname_dialog.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;

  Googlecontroller googlecontroller = Get.put(Googlecontroller());

  late TextEditingController emailcontroller;
  late TextEditingController passcontroller;

  var collection = FirebaseFirestore.instance.collection('seller');
  FirebaseAuth _auth = FirebaseAuth.instance;
  String businesname = "";
  

  @override
  void initState() {
    super.initState();
    emailcontroller = TextEditingController(text: '');
    passcontroller = TextEditingController(text: '');
  }

  bool? remember = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    void getBusinessname() {
    collection.doc(_auth.currentUser!.uid).get().then((DocumentSnapshot ds) {
      Map data = ds.data() as Map;
      setState(() {
        businesname = data["businessname"];
      });
    });
  }
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Login",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen
                KeyboardUtil.hideKeyboard(context);
                signInwithEmail(emailcontroller.text, passcontroller.text)
                    .then((value) {
                  if (value == "User Not Registered") {
                    scafoldmessage(context, value);
                  } else if (value == "Your password is wrong") {
                    scafoldmessage(context, value);
                  } else {
                    setLoggedIn();
                    googlecontroller.usertype.value == "seller"
                        ? getBusinessname()
                        : null;
                    setEmail(_auth.currentUser?.email);
                    setUid(_auth.currentUser?.uid);
                    setUsertype(googlecontroller.usertype.value);
                    googlecontroller.usertype.value == "buyer"
                        ? Get.offAll(Login_succes())
                        : businesname == ""
                            ? bussinessNameDialog(context)
                            : Get.offAll(SellerMainScreen());
                  }
                });
              }
            },
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          InkWell(
              onTap: () {
                Get.to(ForegetPassword());
              },
              child: Text(
                "Forget password?",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              )),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: passcontroller,
      cursorColor: kPrimaryColor,
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
          labelText: "Password",
          hintText: "Enter your password",
          labelStyle: TextStyle(color: kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
          suffixIconColor: kPrimaryColor),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: emailcontroller,
      cursorColor: kPrimaryColor,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
          labelText: "Email",
          labelStyle: TextStyle(color: kPrimaryColor),
          hintText: "Enter your email",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
          suffixIconColor: kPrimaryColor),
    );
  }
}

class FormError extends StatelessWidget {
  const FormError({
    Key? key,
    required this.errors,
  }) : super(key: key);

  final List<String?> errors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          errors.length, (index) => formErrorText(error: errors[index]!)),
    );
  }

  Row formErrorText({required String error}) {
    return Row(
      children: [
        SvgPicture.asset(
          "assets/icons/Error.svg",
          height: getProportionateScreenWidth(14),
          width: getProportionateScreenWidth(14),
        ),
        SizedBox(
          width: getProportionateScreenWidth(10),
        ),
        Text(error),
      ],
    );
  }
}

class KeyboardUtil {
  static void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}

class CustomSurffixIcon extends StatelessWidget {
  const CustomSurffixIcon({
    Key? key,
    required this.svgIcon,
  }) : super(key: key);

  final String svgIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        getProportionateScreenWidth(20),
        getProportionateScreenWidth(20),
        getProportionateScreenWidth(20),
      ),
      child: SvgPicture.asset(
        svgIcon,
        height: getProportionateScreenWidth(18),
      ),
    );
  }
}
