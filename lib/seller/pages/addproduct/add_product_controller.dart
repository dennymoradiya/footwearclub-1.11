import 'package:get/get.dart';

class Addproductcontroller extends GetxController {
  RxString selectgender = "Man".obs;
  RxString type = "Shoes".obs;
  RxString subtype = "Loafers".obs;
  RxInt imagelength = 0.obs;
  //man
  RxString ifmantype = "Shoes".obs;
  RxString ifShoes = "Loafers".obs;
  RxString ifSandals = "Hiking".obs;
  RxString ifSlippers = "Memory-foam".obs;

  // woman
  RxString ifWomantype = "Shoes".obs;
  RxString ifwomanShoes = "Oxfords".obs;
  RxString ifwomanSandals = "Gladiator".obs;
  RxString ifwomanheels = "Pumps".obs;

  //children
  RxString ifChildrentype = "Shoes".obs;
  RxString ifChildrenShoes = "School".obs;
  RxString ifChildrenSandals = "Flip Flops".obs;
  RxString ifChildrenboot = "Snow".obs;
}
