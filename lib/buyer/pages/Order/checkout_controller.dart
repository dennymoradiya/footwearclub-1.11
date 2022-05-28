import 'package:footwearclub/buyer/models/cart_model.dart';
import 'package:get/get.dart';

class  CheckOutController extends GetxController{
  RxString payOption = "".obs;
  RxList<CartModel> cartItem = <CartModel>[].obs;
}