// Id= rzp_test_cdY41lm0zqTgFN
// Secret =bcN9U6DDQjTsOHyABJzGh9lG
import 'package:flutter/material.dart';
import 'package:footwearclub/authentication/shred_pref.dart';
import 'package:footwearclub/buyer/pages/Cart/update_address_controller.dart';
import 'package:footwearclub/buyer/pages/Order/place_order.dart';
import 'package:footwearclub/buyer/pages/Order/sucess_order.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPayGateway extends StatefulWidget {
  final total;
  RazorPayGateway({
    Key? key,
    this.total,
  }) : super(key: key);
  @override
  _RazorPayGatewayState createState() => _RazorPayGatewayState();
}

class _RazorPayGatewayState extends State<RazorPayGateway> {
  late Razorpay _razorpay;

  UpdateAddressController updateAddressController =
      Get.put(UpdateAddressController());

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  @override
  void initState() {
    super.initState();

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    openCheckout();
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var email = await getEmail();

    var options = {
      'key': 'rzp_test_cdY41lm0zqTgFN',
      'amount': widget.total *100,
      'name': 'Footwear Club',
      'description': 'Payment',
      'retry': {'enabled': true, 'max_count': 1},
      // 'send_sms_hash': true,
      'prefill': {
        'contact': updateAddressController.number.value,
        'email': email
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    loadOrder().then((value) {
      Get.offAll(OrderSuccess());
    });
    Get.back();
   
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Get.back();
    scafoldmessage(context, "Error: payment failed! Please try again");
    
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    loadOrder().then((value) {
      Get.offAll(OrderSuccess());
    });
    Get.back();
    scafoldmessage(context, "Successfully Payment");
  }
}
