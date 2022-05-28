import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:footwearclub/authentication/sign_in/loginform.dart';
import 'package:footwearclub/constants/constant.dart';
import 'package:footwearclub/constants/size_mediaquery.dart';
import 'package:footwearclub/seller/constants/seller_constant.dart';
import 'package:footwearclub/seller/pages/addproduct/add_product_controller.dart';
import 'package:footwearclub/seller/pages/products/get_product.dart';
import 'package:footwearclub/seller/pages/products/products_controller.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class Addproduct extends StatefulWidget {
  Addproduct({Key? key}) : super(key: key);

  @override
  State<Addproduct> createState() => _AddproductState();
}

String? ProductName;
String? ProductDesc;
String? ProductPrise;
String? ProductColor;
String? Productstock;
String? ProductWeight;

List<Asset> images = <Asset>[];
String _error = 'No Error Dectected';
FirebaseAuth firebaseAuth = FirebaseAuth.instance;

Addproductcontroller addproductcontroller = Addproductcontroller();
ProductController productController = Get.put(ProductController());
FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseStorage firebaseStorage = FirebaseStorage.instance;

class _AddproductState extends State<Addproduct> {
  final List<String?> errors = [];
  List imgfiletype = [];
  List<String> imagesUrls = [];
  Timer? _timer;

  TextEditingController namecontroller = TextEditingController(text: "");
  TextEditingController desccontroller = TextEditingController();
  TextEditingController prisecontroller = TextEditingController();
  TextEditingController colorcontroller = TextEditingController();
  TextEditingController stockcontroller = TextEditingController();
  TextEditingController weightcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    images = <Asset>[];
    imagesUrls = [];
    imgfiletype = [];
    addproductcontroller.selectgender.value = "Man";
    addproductcontroller.type.value = "Shoes";
    addproductcontroller.subtype.value = "Loafers";
    addproductcontroller.imagelength.value = 0;

    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 4,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: const CupertinoOptions(
          takePhotoIcon: "chat",
          doneButtonTitle: "Fatto",
        ),
        materialOptions: const MaterialOptions(
          statusBarColor: "#FF7643",
          actionBarColor: "#FF7643",
          actionBarTitle: "Footwear Club",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#FF7643",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    if (!mounted) return;

    setState(() {
      images = resultList;
      addproductcontroller.imagelength.value = images.length;
      _error = error;
    });

    images.forEach((assetImage) {
      getImageFileFromAssets(assetImage);
    });
  }

  Future<File> getImageFileFromAssets(Asset asset) async {
    final byteData = await asset.getByteData();
    final tempFile =
        File("${(await getTemporaryDirectory()).path}/${asset.name}");
    final file = await tempFile.writeAsBytes(
      byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
    );
    imgfiletype.add(file);
    return file;
  }

  Future uploadFiles(List _images) async {
    EasyLoading.show(status: 'uploading...');

    //generate product id
    String uniqueId = Uuid().v1();
    String productId = uniqueId.split("-").join("");
    var productName = namecontroller.text;
    var productprice = prisecontroller.text;
    var productDesc = desccontroller.text;
    var productColor = colorcontroller.text;
    var productStock = stockcontroller.text;
    var productWeight = weightcontroller.text;
    print("gender : ${addproductcontroller.selectgender.value}");
    print("type : ${addproductcontroller.type.value}");
    print("subtype : ${addproductcontroller.subtype.value}");
    print("Success");
    var gender = addproductcontroller.selectgender.value;
    var type = addproductcontroller.type.value;
    var subtype = addproductcontroller.subtype.value;
    var userId = firebaseAuth.currentUser!.uid;

    _images.forEach((_image) async {
      var imgname = _image.path.split("/").last;
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('Product/${productId}/${imgname}');
      UploadTask uploadTask = storageReference.putFile(_image);

      await uploadTask.then((TaskSnapshot taskSnapshot) async {
        await storageReference.getDownloadURL().then((urls) {
          imagesUrls.add(urls);
          // print("imgurls === $imagesUrls");
        });

        if (imagesUrls.length == 4) {
          print("img upload done");
          firestore
              .collection("seller")
              .doc(userId)
              .collection("product")
              .doc(gender)
              .collection(type)
              .doc(productId)
              .set({
            "productid": productId,
            "sellerid": userId,
            "name": productName,
            "desc": productDesc,
            "price": productprice,
            "color": productColor,
            "stock": productStock,
            "weight": productWeight,
            "gender": gender,
            "category": type,
            "subtype": subtype,
            "imgurl": imagesUrls
          }).whenComplete(() {
            EasyLoading.showSuccess('Added Successfully!');
            getProduct();
            productController.productData.clear();
            Get.back();
            EasyLoading.dismiss();
          });
        }
      });
    });
  }

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().initsize(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Add Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              buildNAmeFormField(),
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              builddescFormField(),
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              buildpriseFormField(),
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              buildcolorFormField(),
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              buildstockFormField(),
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              buildWeightFormField(),
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              //select man woman child
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "For  ",
                        style: TextStyle(fontSize: 20),
                      ),
                      Container(
                        width: Get.width * 0.65,
                        padding: EdgeInsets.only(left: 30),
                        height: 60,
                        decoration: BoxDecoration(
                            border: Border.all(color: kSecondaryColor),
                            borderRadius: BorderRadius.circular(24)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            icon: Icon(
                              Icons.arrow_drop_down,
                              size: 35,
                            ),
                            isExpanded: true,
                            value: addproductcontroller.selectgender.value,
                            style: TextStyle(color: Colors.black, fontSize: 19),
                            items: <String>[
                              'Man',
                              'Woman',
                              'Children',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              addproductcontroller.selectgender.value = value!;
                              print(addproductcontroller.selectgender.value);
                            },
                          ),
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              // gender wise
              Obx(() {
                return addproductcontroller.selectgender.value == "Man"
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Type  ",
                            style: TextStyle(fontSize: 20),
                          ),
                          Container(
                            width: Get.width * 0.65,
                            padding: EdgeInsets.only(left: 30),
                            height: 60,
                            decoration: BoxDecoration(
                                border: Border.all(color: kSecondaryColor),
                                borderRadius: BorderRadius.circular(24)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  size: 35,
                                ),
                                isExpanded: true,
                                value: addproductcontroller.ifmantype.value,
                                elevation: 5,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 19),
                                items: <String>[
                                  'Shoes',
                                  'Sandals',
                                  'Slippers',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  addproductcontroller.ifmantype.value = value!;
                                  addproductcontroller.type.value = value;
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    : addproductcontroller.selectgender.value == "Woman"
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Type  ",
                                style: TextStyle(fontSize: 20),
                              ),
                              Container(
                                width: Get.width * 0.65,
                                padding: EdgeInsets.only(left: 30),
                                height: 60,
                                decoration: BoxDecoration(
                                    border: Border.all(color: kSecondaryColor),
                                    borderRadius: BorderRadius.circular(24)),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      size: 35,
                                    ),
                                    isExpanded: true,
                                    value:
                                        addproductcontroller.ifWomantype.value,
                                    elevation: 5,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 19),
                                    items: <String>[
                                      'Shoes',
                                      'Sandals',
                                      'Heels',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      addproductcontroller.ifWomantype.value =
                                          value!;
                                      addproductcontroller.type.value = value;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )
                        : addproductcontroller.selectgender.value == "Children"
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Type  ",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Container(
                                    width: Get.width * 0.65,
                                    padding: EdgeInsets.only(left: 30),
                                    height: 60,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: kSecondaryColor),
                                        borderRadius:
                                            BorderRadius.circular(24)),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          size: 35,
                                        ),
                                        isExpanded: true,
                                        value: addproductcontroller
                                            .ifChildrentype.value,
                                        elevation: 5,
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 19),
                                        items: <String>[
                                          'Shoes',
                                          'Sandals',
                                          'Boot',
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          addproductcontroller
                                              .ifChildrentype.value = value!;
                                          addproductcontroller.type.value =
                                              value;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container();
              }),
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              //if man
              Obx(() {
                return addproductcontroller.ifmantype.value == "Shoes" &&
                        addproductcontroller.selectgender.value == "Man"
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Subtype",
                            style: TextStyle(fontSize: 20),
                          ),
                          Container(
                            width: Get.width * 0.65,
                            padding: EdgeInsets.only(left: 30),
                            height: 60,
                            decoration: BoxDecoration(
                                border: Border.all(color: kSecondaryColor),
                                borderRadius: BorderRadius.circular(24)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  size: 35,
                                ),
                                isExpanded: true,
                                value: addproductcontroller.ifShoes.value,
                                elevation: 5,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 19),
                                items: <String>[
                                  'Loafers',
                                  'Moccasin',
                                  'Sneakers',
                                  'Boots',
                                  'Monk Strap',
                                  'Chelsea',
                                  'Running'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  addproductcontroller.ifShoes.value = value!;
                                  addproductcontroller.subtype.value = value;
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    : addproductcontroller.ifmantype.value == "Sandals" &&
                            addproductcontroller.selectgender.value == "Man"
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "SubType  ",
                                style: TextStyle(fontSize: 20),
                              ),
                              Container(
                                width: Get.width * 0.65,
                                padding: EdgeInsets.only(left: 30),
                                height: 60,
                                decoration: BoxDecoration(
                                    border: Border.all(color: kSecondaryColor),
                                    borderRadius: BorderRadius.circular(24)),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      size: 35,
                                    ),
                                    isExpanded: true,
                                    value: addproductcontroller.ifSandals.value,
                                    elevation: 5,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 19),
                                    items: <String>[
                                      'Hiking',
                                      'Running',
                                      'Water Sandals',
                                      'Leather Sandals',
                                      'Luna',
                                      'Dress',
                                      'Teva',
                                      'Birkenstock',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      addproductcontroller.subtype.value =
                                          value!;
                                      addproductcontroller.ifSandals.value =
                                          value;
                                      print(addproductcontroller.subtype.value);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )
                        : addproductcontroller.ifmantype.value == "Slippers" &&
                                addproductcontroller.selectgender.value == "Man"
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    "SubType  ",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Container(
                                    width: Get.width * 0.65,
                                    padding: EdgeInsets.only(left: 30),
                                    height: 60,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: kSecondaryColor),
                                        borderRadius:
                                            BorderRadius.circular(24)),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          size: 35,
                                        ),
                                        isExpanded: true,
                                        value: addproductcontroller
                                            .ifSlippers.value,
                                        elevation: 5,
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 19),
                                        items: <String>[
                                          'Memory-foam',
                                          'Canvas',
                                          'Sheepskin moccasin',
                                          'Wide',
                                          'Odor-free'
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          addproductcontroller.subtype.value =
                                              value!;
                                          addproductcontroller
                                              .ifSlippers.value = value;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container();
              }),
              //if woman
              Obx(() {
                return addproductcontroller.ifWomantype.value == "Shoes" &&
                        addproductcontroller.selectgender.value == "Woman"
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "SubType  ",
                            style: TextStyle(fontSize: 20),
                          ),
                          Container(
                            width: Get.width * 0.65,
                            padding: EdgeInsets.only(left: 30),
                            height: 60,
                            decoration: BoxDecoration(
                                border: Border.all(color: kSecondaryColor),
                                borderRadius: BorderRadius.circular(24)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  size: 35,
                                ),
                                isExpanded: true,
                                value: addproductcontroller.ifwomanShoes.value,
                                elevation: 5,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 19),
                                items: <String>[
                                  'Oxfords',
                                  'Thigh High',
                                  'Loafer',
                                  'Fantasy',
                                  'Sports',
                                  'Slip-on Sneakers'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  addproductcontroller.subtype.value = value!;
                                  addproductcontroller.ifwomanShoes.value =
                                      value;
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    : addproductcontroller.ifWomantype.value == "Sandals" &&
                            addproductcontroller.selectgender.value == "Woman"
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "SubType  ",
                                style: TextStyle(fontSize: 20),
                              ),
                              Container(
                                width: Get.width * 0.65,
                                padding: EdgeInsets.only(left: 30),
                                height: 60,
                                decoration: BoxDecoration(
                                    border: Border.all(color: kSecondaryColor),
                                    borderRadius: BorderRadius.circular(24)),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      size: 35,
                                    ),
                                    isExpanded: true,
                                    value: addproductcontroller
                                        .ifwomanSandals.value,
                                    elevation: 5,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 19),
                                    items: <String>[
                                      'Gladiator',
                                      'Open Toe',
                                      'Jelly',
                                      'Thong',
                                      'Saltwater',
                                      'Chunky'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      addproductcontroller.subtype.value =
                                          value!;
                                      addproductcontroller
                                          .ifwomanSandals.value = value;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )
                        : addproductcontroller.ifWomantype.value == "Heels" &&
                                addproductcontroller.selectgender.value ==
                                    "Woman"
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    "SubType  ",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Container(
                                    width: Get.width * 0.65,
                                    padding: EdgeInsets.only(left: 30),
                                    height: 60,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: kSecondaryColor),
                                        borderRadius:
                                            BorderRadius.circular(24)),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          size: 35,
                                        ),
                                        isExpanded: true,
                                        value: addproductcontroller
                                            .ifwomanheels.value,
                                        elevation: 5,
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 19),
                                        items: <String>[
                                          'Pumps',
                                          'Stilettos',
                                          'Kitten',
                                          'Sling back',
                                          'Peep-Toe',
                                          'Cork High'
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          addproductcontroller.subtype.value =
                                              value!;
                                          addproductcontroller
                                              .ifwomanheels.value = value;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container();
              }),

              Obx(() {
                return addproductcontroller.ifChildrentype.value == "Shoes" &&
                        addproductcontroller.selectgender.value == "Children"
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "SubType  ",
                            style: TextStyle(fontSize: 20),
                          ),
                          Container(
                            width: Get.width * 0.65,
                            padding: EdgeInsets.only(left: 30),
                            height: 60,
                            decoration: BoxDecoration(
                                border: Border.all(color: kSecondaryColor),
                                borderRadius: BorderRadius.circular(24)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  size: 35,
                                ),
                                isExpanded: true,
                                value:
                                    addproductcontroller.ifChildrenShoes.value,
                                elevation: 5,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 19),
                                items: <String>[
                                  'School',
                                  'Athletic',
                                  'High Tops',
                                  'Sport',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  addproductcontroller.subtype.value = value!;
                                  addproductcontroller.ifChildrenShoes.value =
                                      value;
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    : addproductcontroller.ifChildrentype.value == "Sandals" &&
                            addproductcontroller.selectgender.value ==
                                "Children"
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                "SubType  ",
                                style: TextStyle(fontSize: 20),
                              ),
                              Container(
                                width: Get.width * 0.65,
                                padding: EdgeInsets.only(left: 30),
                                height: 60,
                                decoration: BoxDecoration(
                                    border: Border.all(color: kSecondaryColor),
                                    borderRadius: BorderRadius.circular(24)),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      size: 35,
                                    ),
                                    isExpanded: true,
                                    value: addproductcontroller
                                        .ifChildrenSandals.value,
                                    elevation: 5,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 18),
                                    items: <String>[
                                      'Flip Flops',
                                      'Crocs',
                                      'Bellies For Little'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      addproductcontroller.subtype.value =
                                          value!;
                                      addproductcontroller
                                          .ifChildrenSandals.value = value;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )
                        : addproductcontroller.ifChildrentype.value == "Boot" &&
                                addproductcontroller.selectgender.value ==
                                    "Children"
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    "SubType  ",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Container(
                                    width: Get.width * 0.65,
                                    padding: EdgeInsets.only(left: 30),
                                    height: 60,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: kSecondaryColor),
                                        borderRadius:
                                            BorderRadius.circular(24)),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          size: 35,
                                        ),
                                        isExpanded: true,
                                        value: addproductcontroller
                                            .ifChildrenboot.value,
                                        elevation: 5,
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 19),
                                        items: <String>[
                                          'Snow',
                                          'Rain',
                                          'Hiking',
                                          'Rubber',
                                          'Work',
                                          'Cowboy',
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          addproductcontroller.subtype.value =
                                              value!;
                                          addproductcontroller
                                              .ifChildrenboot.value = value;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container();
              }),
              SizedBox(height: SizeConfig.screenHeight * 0.03),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Pick Image   ",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .35,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        elevation: 9,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        primary: Colors.white,
                        backgroundColor: kPrimaryColor,
                      ),
                      child: const Text("Pick images"),
                      onPressed: loadAssets,
                    ),
                  ),
                ],
              ),

              Obx(() {
                return addproductcontroller.imagelength.value > 0
                    ? Wrap(children: [
                        GridView.count(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          crossAxisCount: 3,
                          children: List.generate(images.length, (index) {
                            Asset asset = images[index];
                            // print(images.length);
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AssetThumb(
                                asset: asset,
                                width: 300,
                                height: 300,
                              ),
                            );
                          }),
                        ),
                      ])
                    : SizedBox();
              }),

              FormError(errors: errors),
              SizedBox(height: getProportionateScreenHeight(20)),

              Container(
                margin: EdgeInsets.only(left: 20),
                child: DefaultButton(
                  text: "Submit",
                  press: () async {
                    KeyboardUtil.hideKeyboard(context);

                    if (namecontroller.text.isEmpty) {
                      addError(error: Enterproductname);
                    }
                    if (colorcontroller.text.isEmpty) {
                      addError(error: Enterproductcolor);
                    }
                    if (desccontroller.text.isEmpty) {
                      addError(error: Enterproductdesc);
                    }
                    if (prisecontroller.text.isEmpty) {
                      addError(error: Enterproductprise);
                    }
                    if (stockcontroller.text.isEmpty) {
                      addError(error: Enterproductstock);
                    }
                    if (weightcontroller.text.isEmpty) {
                      addError(error: Enterproductweight);
                    }
                    if (addproductcontroller.imagelength.value < 4) {
                      addError(error: imageerror);
                    } else {
                      removeError(error: imageerror);
                    }
                    if (namecontroller.text.isNotEmpty &&
                        desccontroller.text.isNotEmpty &&
                        prisecontroller.text.isNotEmpty &&
                        stockcontroller.text.isNotEmpty &&
                        colorcontroller.text.isNotEmpty &&
                        weightcontroller.text.isNotEmpty &&
                        addproductcontroller.imagelength.value == 4) {
                      uploadFiles(imgfiletype);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildNAmeFormField() {
    return TextFormField(
      controller: namecontroller,
      cursorColor: kPrimaryColor,
      keyboardType: TextInputType.name,
      onSaved: (newValue) => ProductName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: Enterproductname);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: Enterproductname);
          return "";
        }

        return null;
      },
      decoration: const InputDecoration(
          labelText: "Product Name",
          labelStyle: TextStyle(color: kPrimaryColor),
          hintText: "Enter Product Name",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIconColor: kPrimaryColor),
    );
  }

  TextFormField builddescFormField() {
    return TextFormField(
      controller: desccontroller,
      cursorColor: kPrimaryColor,
      keyboardType: TextInputType.text,
      onSaved: (newValue) => ProductDesc = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: Enterproductdesc);
        }

        return;
      },
      validator: (value) {
        if (desccontroller.text.isEmpty) {
          addError(error: Enterproductdesc);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
          labelText: "Product description",
          labelStyle: TextStyle(color: kPrimaryColor),
          hintText: "Enter Product description",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIconColor: kPrimaryColor),
    );
  }

  TextFormField buildpriseFormField() {
    return TextFormField(
      controller: prisecontroller,
      cursorColor: kPrimaryColor,
      keyboardType: TextInputType.number,
      onSaved: (newValue) => ProductPrise = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: Enterproductprise);
        }
        return;
      },
      validator: (value) {
        if (prisecontroller.text.isEmpty) {
          addError(error: Enterproductprise);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
          labelText: "Product Price",
          labelStyle: TextStyle(color: kPrimaryColor),
          hintText: "Enter Product Price",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIconColor: kPrimaryColor),
    );
  }

  TextFormField buildcolorFormField() {
    return TextFormField(
      controller: colorcontroller,
      cursorColor: kPrimaryColor,
      keyboardType: TextInputType.text,
      onSaved: (newValue) => ProductColor = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: Enterproductcolor);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: Enterproductcolor);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
          labelText: "Product Color",
          labelStyle: TextStyle(color: kPrimaryColor),
          hintText: "Enter Product Color",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIconColor: kPrimaryColor),
    );
  }

  TextFormField buildstockFormField() {
    return TextFormField(
      controller: stockcontroller,
      cursorColor: kPrimaryColor,
      keyboardType: TextInputType.number,
      onSaved: (newValue) => Productstock = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: Enterproductstock);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: Enterproductstock);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
          labelText: "Product Stock",
          labelStyle: TextStyle(color: kPrimaryColor),
          hintText: "Enter Product Stock",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIconColor: kPrimaryColor),
    );
  }

  TextFormField buildWeightFormField() {
    return TextFormField(
      controller: weightcontroller,
      cursorColor: kPrimaryColor,
      keyboardType: TextInputType.number,
      onSaved: (newValue) => ProductWeight = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: Enterproductweight);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: Enterproductweight);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
          labelText: "Product Weight",
          labelStyle: TextStyle(color: kPrimaryColor),
          hintText: "Ex: 100 Grams",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIconColor: kPrimaryColor),
    );
  }
}
