import 'package:get/get.dart';

class CartController extends GetxController {
  RxList cartlist = [].obs;

  void addItems(cartitem) {
    cartlist.add(cartitem);
    print("cartlist ${cartlist}");
  }
  // RxInt quantity = 1.obs;

  int increaseQuantity(quantity) {
    var value = int.parse(quantity.toString());
    value++;
    return value;
  }
}
