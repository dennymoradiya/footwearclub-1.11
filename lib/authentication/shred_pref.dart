import 'package:flutter/material.dart';
import 'package:footwearclub/constants/constant.dart';
import 'package:footwearclub/splashscreen/buyorsell.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefManager extends GetxController {
  //  late SharedPreferences prefs;
  RxString name = "".obs;
  RxString email = "".obs;
  RxString imageUrl = "".obs;
  RxString uid = "".obs;
  RxString phone = "".obs;
  RxMap userMap = {}.obs;
  RxList<String>? userList;
  RxList<String> serchlist = [
    "Man+Shoes",
    "Woman+Shoes",
    "Children+Shoes",
  ].obs;

  RxMap dashboard = {
    "rating": 0,
    "sales": 0,
    "order": 0,
    "revenue": 0,
  }.obs;

  // RxList wishlist = [].obs;

  Future setuserlist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("userlist", userList!);
    return prefs;
  }

  //search for recommandation
  Future<void> getlastserch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getStringList("serchlist") != null) {
      serchlist.value = prefs.getStringList("serchlist")!;
    }
    print("set serch set");
    print(serchlist);
  }

  Future<void> setlastserch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("serchlist", serchlist);
    print("last serch set");
    print(serchlist);
  }

  Future<void> getAccountObject() async {
    name.value = (await getName())!;
    email.value = (await getEmail())!;
    imageUrl.value = (await getImageURL())!;
    uid.value = (await getUid())!;
    phone.value = (await getphone())!;
  }

  Future<Map> getUserData() async {
    userMap.value = {
      "name": (await getName())!,
      "email": (await getEmail())!,
      "imageUrl": (await getImageURL())!,
      "uid": (await getUid())!,
    };
    return userMap;
  }
  Future<void> setdashbord(Map data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('revenue', data["revenue"]);
    prefs.setInt('sales', data["sales"]);
  }

  Future<void> getdashbord() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getInt('revenue') == null) {
      prefs.setInt('revenue', 0);
    } else {
      dashboard["revenue"] = prefs.getInt('revenue');
    }

    if (prefs.getInt('sales') == null) {
      prefs.setInt('sales', 0);
    } else {
      dashboard["sales"] = prefs.getInt('sales');
    }    
  }
}





Future<void> setLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('logged_in', true);
}

Future<void> setEmail(email) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('email', email);
}

Future<void> setUid(uid) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('uid', uid);
}
Future<void> setUsertype(usertype) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('usertype', usertype);
}

Future<bool?> getLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool("logged_in");
}

Future<void> removeLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove("logged_in");
  prefs.remove("name");
  prefs.remove("email");
  prefs.remove("uid");
  prefs.remove("imageURL");
  prefs.remove("phone");
  Get.offAll(Buyorsale());
}

Future<void> setAccountObject(
    {uid, name, email, phone, imageURL, usertype}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('name', name ?? "");
  prefs.setString('email', email);
  prefs.setString('uid', uid);
  prefs.setString('imageURL', imageURL);
  prefs.setString("usertype", usertype);
  if (phone == null) {
    prefs.setString("phone", "");
  } else {
    prefs.setString("phone", phone);
  }
}

Future<String?> getName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? name = prefs.getString("name");
  return name;
}

Future<String?> getEmail() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("email");
}

Future<String?> getUid() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("uid");
}

Future<String?> getImageURL() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("imageURL");
}

Future<String?> getUsertype() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("usertype");
}

Future<String?> getphone() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("phone");
}

void scafoldmessage(context, value) {
  final snackBar = SnackBar(
      backgroundColor: kPrimaryColor,
      duration: const Duration(seconds: 1),
      content: Text(value));

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
