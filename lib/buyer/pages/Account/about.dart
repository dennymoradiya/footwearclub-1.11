import 'package:flutter/material.dart';
import 'package:footwearclub/constants/constant.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
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
