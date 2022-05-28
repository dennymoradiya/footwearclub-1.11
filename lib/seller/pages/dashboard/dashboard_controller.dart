import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Dashboardcontroller extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  RxList ratinglist = [].obs;
  RxDouble rating = 0.0.obs;

  Future<void> getrating() async {
    ratinglist = [].obs;

    CollectionReference data = firestore
        .collection("seller")
        .doc(auth.currentUser?.uid)
        .collection("reviews");
    QuerySnapshot datasnapshort = await data.get();
    datasnapshort.docs.map((element) {
      Map ordertdata = element.data() as Map;
      ratinglist.add(ordertdata["rating"]);
    }).toList();

    if (ratinglist.length == 0) {
      rating.value = 0;
    } else {
      rating.value = 0;

      ratinglist.forEach((element) {
        print(element);
        if (rating.value != double.nan) {
          rating.value += double.parse(element.toString());
        } else {
          print("no review");
          rating.value = 0;
        }
      });

      rating.value = (rating / ratinglist.length);
    }
  }
}
