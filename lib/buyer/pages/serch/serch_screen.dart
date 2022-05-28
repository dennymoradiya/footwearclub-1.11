// import 'package:flutter/material.dart';
// import 'package:footwearclub/buyer/pages/home/buyer_home_controller.dart';
// import 'package:get/get.dart';
// import 'package:material_floating_search_bar/material_floating_search_bar.dart';

// class Serchscreen extends StatefulWidget {
//   Serchscreen({Key? key}) : super(key: key);

//   @override
//   State<Serchscreen> createState() => _SerchscreenState();
// }

// BuyerHomeController buyerHomeController = Get.put(BuyerHomeController());

// class _SerchscreenState extends State<Serchscreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           buildFloatingSearchBar(),
//         ],
//       ),
//     );
//   }

//   Widget buildFloatingSearchBar() {
//     final isPortrait =
//         MediaQuery.of(context).orientation == Orientation.portrait;

//     return FloatingSearchBar(
//       hint: 'Search...',
//       scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
//       transitionDuration: const Duration(milliseconds: 800),
//       transitionCurve: Curves.easeInOut,
//       physics: const BouncingScrollPhysics(),
//       axisAlignment: isPortrait ? 0.0 : -1.0,
//       openAxisAlignment: 0.0,
//       width: isPortrait ? 600 : 500,
//       debounceDelay: const Duration(milliseconds: 500),
//       onQueryChanged: (query) {
//          buyerHomeController.productlist.where((data) {
           
//          });
//         print("dmd");
//       },
//       transition: CircularFloatingSearchBarTransition(),
//       actions: [
//         FloatingSearchBarAction(
//           showIfOpened: false,
//           child: CircularButton(
//             icon: const Icon(Icons.search),
//             onPressed: () {},
//           ),
//         ),
//         FloatingSearchBarAction.searchToClear(
//           showIfClosed: false,
//         ),
//       ],
//       builder: (context, transition) {
//        return SizedBox();
//       },
//     );
//   }
// }
