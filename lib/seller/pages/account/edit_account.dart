import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:footwearclub/constants/constant.dart';
import 'package:footwearclub/seller/pages/account/account_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class SellerAccountDetail extends StatefulWidget {
  const SellerAccountDetail({Key? key}) : super(key: key);

  @override
  _SellerAccountDetailState createState() => _SellerAccountDetailState();
}

class _SellerAccountDetailState extends State<SellerAccountDetail> {
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Timer? _timer;
  File? imgfile;

  SellerAccountController selleraccountController =
      Get.put(SellerAccountController());
  @override
  void initState() {
    super.initState();
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
  }

  void getImage() async {
    ImagePicker imagePicker = ImagePicker();
    await imagePicker.pickImage(source: ImageSource.gallery).then((file) {
      if (file != null) {
        imgfile = File(file.path);
        uploadImage();
      }
    });
  }

  void uploadImage() async {
    Get.back();
    EasyLoading.show(status: 'updating...');
    String fileName = const Uuid().v1();
    var ref =
        firebaseStorage.ref().child('ProfileImages').child("$fileName.jpg");
    var uploadTask = await ref.putFile(imgfile!);

    await uploadTask.ref.getDownloadURL().then((imgUrl) async {
      await firestore
          .collection("seller")
          .doc(firebaseAuth.currentUser!.uid)
          .update({"imageUrl": imgUrl});
      EasyLoading.showSuccess('Added Successfully!');
      selleraccountController.myImgUrl.value = imgUrl.toString();
      EasyLoading.dismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Account Information",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Obx(() => (Container(
              width: Get.width,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Obx(() => Container(
                        height: 140,
                        width: 140,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                            progressIndicatorBuilder:
                                (context, url, progress) => Center(
                              child: CircularProgressIndicator(
                                color: kPrimaryColor,
                              ),
                            ),
                            imageUrl:
                                selleraccountController.myImgUrl.toString(),
                            fit: BoxFit.fill,
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      edit_image(context);
                    },
                    child: Text(
                      "Edit profile picture",
                      style: TextStyle(color: kPrimaryColor, fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name",
                                    style: TextStyle(
                                      fontSize: 15,
                                      // color: Colors.black
                                    ),
                                  ),
                                  Text(
                                    selleraccountController.myname.value
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    edit_name(
                                      context,
                                    );
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: kPrimaryColor,
                                  ))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Email",
                                    style: TextStyle(
                                      fontSize: 15,
                                      //  color: Colors.black
                                    ),
                                  ),
                                  Text(
                                    selleraccountController.myemail.value
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Phone",
                                    style: TextStyle(
                                      fontSize: 15,
                                      // color: Colors.black
                                    ),
                                  ),
                                  Text(
                                    selleraccountController.myphone.value
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    edit_phone(
                                      context,
                                    );
                                  },
                                  icon: Icon(Icons.edit, color: kPrimaryColor))
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ))),
      ),
    );
  }

  Future<void> edit_image(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Text('Edit Profile Picture',
                style: TextStyle(color: Colors.black)),
            content: Text("Do you want to edit profile Picture ?",
                style: TextStyle(color: Colors.grey)),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  child: Text("No", style: TextStyle(color: kPrimaryColor))),
              TextButton(
                  onPressed: () {
                    getImage();
                    // setState(() {});
                  },
                  child: Text(
                    "Yes",
                    style: TextStyle(color: kPrimaryColor),
                  )),
            ],
          );
        });
  }

  Future<void> edit_imagetype(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Text('Choose Image', style: TextStyle(color: Colors.black)),
            content: Container(
              height: 90,
              child: Column(
                children: [
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      ImagePicker _picker = ImagePicker();
                      XFile? image =
                          await _picker.pickImage(source: ImageSource.gallery);
                      if (image != null) {
                        // upload(File(image.path));
                      }
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.add_photo_alternate,
                          color: Colors.grey,
                          size: 35,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Gallary",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 22)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      ImagePicker _picker = ImagePicker();
                      XFile? image = await _picker.pickImage(
                          source: ImageSource.camera, imageQuality: 100);
                      if (image != null) {
                        // upload(File(image.path));
                      }
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.add_a_photo,
                          color: Colors.grey,
                          size: 35,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Camera",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 22)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> edit_name(BuildContext context) async {
    String textvalue = "";
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Text('Edit Name'),
            content: TextFormField(
              cursorColor: kPrimaryColor,
              onChanged: (value) {
                textvalue = value;
              },
              decoration: const InputDecoration(
                  labelText: "Name",
                  labelStyle: TextStyle(color: kPrimaryColor),
                  hintText: "Enter profile name",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIconColor: kPrimaryColor),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  child:
                      Text("Cancel", style: TextStyle(color: kPrimaryColor))),
              TextButton(
                  onPressed: () {
                    if (textvalue != "") {
                      selleraccountController.myname.value = textvalue;
                      setname(textvalue);
                      setState(() {
                        Navigator.pop(context);
                      });
                    }
                    // setState(() {});
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(color: kPrimaryColor),
                  )),
            ],
          );
        });
  }

  Future<void> edit_email(BuildContext context) async {
    String textvalue = "";
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Text('Edit Email'),
            content: TextFormField(
              cursorColor: kPrimaryColor,
              // keyboardType: TextInputType.number,
              onChanged: (value) {
                textvalue = value;
              },
              decoration: const InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(color: kPrimaryColor),
                  hintText: "Enter email",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIconColor: kPrimaryColor),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  child:
                      Text("Cancel", style: TextStyle(color: kPrimaryColor))),
              TextButton(
                  onPressed: () {
                    if (textvalue != "") {
                      selleraccountController.myemail.value = textvalue;
                      setemail(textvalue);
                      setState(() {
                        Navigator.pop(context);
                      });
                    }
                    setState(() {});
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(color: kPrimaryColor),
                  )),
            ],
          );
        });
  }

  Future<void> edit_phone(BuildContext context) async {
    String textvalue = "";
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Text('Edit Phone'),
            content: TextFormField(
              cursorColor: kPrimaryColor,
              maxLength: 10,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                textvalue = value;
              },
              decoration: const InputDecoration(
                  labelText: "Phone no.",
                  labelStyle: TextStyle(color: kPrimaryColor),
                  hintText: "Enter your phon no.e",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIconColor: kPrimaryColor),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  child:
                      Text("Cancel", style: TextStyle(color: kPrimaryColor))),
              TextButton(
                  onPressed: () {
                    if (textvalue != "") {
                      selleraccountController.myphone.value = textvalue;
                      setphone(textvalue);
                      setState(() {
                        Navigator.pop(context);
                      });
                    }
                    setState(() {});
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(color: kPrimaryColor),
                  )),
            ],
          );
        });
  }
}
