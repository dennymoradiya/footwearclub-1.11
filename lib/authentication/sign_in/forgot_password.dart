import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:footwearclub/authentication/sign_in/loginform.dart';
import 'package:footwearclub/constants/constant.dart';
import 'package:footwearclub/constants/size_mediaquery.dart';

import '../shred_pref.dart';

class ForegetPassword extends StatefulWidget {
  const ForegetPassword({Key? key}) : super(key: key);

  @override
  _ForegetPasswordState createState() => _ForegetPasswordState();
}

class _ForegetPasswordState extends State<ForegetPassword> {
  TextEditingController emailController = TextEditingController();
  String errorText = "";
  bool isForget=false;
  final _formKey = GlobalKey<FormState>();

  checkEmailValidation(String email) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String mail = email.trim();
    try {
      final list = await auth.fetchSignInMethodsForEmail(mail);
      if (list.isEmpty) {
        scafoldmessage(context, "Your Email is not registered");
      } else {
        await auth.sendPasswordResetEmail(email: mail);
        scafoldmessage(context, "Reset password link is send to your email");
      }
    } on FirebaseException catch (e) {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Forget password'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: getProportionateScreenHeight(200),
            ),
            Text(
              "Reset your password",
              style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
            ),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  cursorColor: kPrimaryColor,
                  validator: (value) {
                    if (!emailValidatorRegExp.hasMatch(value??"")) {
                     return "Please enter valid email";
                    }
                  },
                  decoration: const InputDecoration(
                      labelText: "Email",
                      hintText: "Enter your email",
                      labelStyle: TextStyle(color: kPrimaryColor),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIconColor: kPrimaryColor),
                ),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(errorText),
            ),
            SizedBox(
              height: getProportionateScreenHeight(25),
            ),
            DefaultButton(
              text: "Forget password",
              press: () {
                print("data");
                if (_formKey.currentState?.validate()==true) {
                  checkEmailValidation(emailController.text);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
