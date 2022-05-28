import 'package:flutter/material.dart';
import 'package:footwearclub/constants/constant.dart';

class SellerAboutPage extends StatefulWidget {
  const SellerAboutPage({Key? key}) : super(key: key);

  @override
  _SellerAboutPageState createState() => _SellerAboutPageState();
}

class _SellerAboutPageState extends State<SellerAboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("About",style: TextStyle(color: Colors.black),),
        
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Footwear Club",style: TextStyle(fontSize: 30,color: kPrimaryColor),),
            SizedBox(
              height: 30,
            ),
            Text("App Version",style: TextStyle(fontSize: 17,color: Colors.grey[800]),),
            Text("1.0.0",style: TextStyle(fontSize: 17,color: Colors.grey[800]),)
          ],
        ),
      ),
    );
  }
}
