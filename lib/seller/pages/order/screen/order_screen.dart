import 'package:flutter/material.dart';
import 'package:footwearclub/seller/constants/seller_constant.dart'; 
import 'package:footwearclub/seller/pages/order/screen/pendingorder_screen.dart';
import 'readytoship_screen.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}



class _OrderScreenState extends State<OrderScreen> {


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: kSellerPrimaryColor,
            toolbarHeight: 5,
            bottom: const TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                    icon: Text(
                  "Pending Order",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                )),
                Tab(
                    icon: Text(
                  "Ready To Ship",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                )),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              PendingOrder(),
              ReadytoshipScreen(),
            ],
          )),
    );
  }
}
