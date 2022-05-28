import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:footwearclub/buyer/pages/home/buyer_home_controller.dart';
import 'package:footwearclub/constants/constant.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'buyer_all_category_screen.dart';

class BuyerCategory extends StatefulWidget {
  const BuyerCategory({Key? key}) : super(key: key);

  @override
  _BuyerCategoryState createState() => _BuyerCategoryState();
}

RxBool serchon = true.obs;
//man
List<Map> Manshoes = [
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fman%2Fman_shoes_Loafers.png?alt=media&token=0825c4f1-5e2a-4d25-bcac-309ea3ef0e26",
    "type": "Loafers"
  },
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fman%2Fman_shoes_Moccasin.png?alt=media&token=a7f89ca8-23b3-4d6b-9309-e7884f6f2eeb",
    "type": "Moccasin"
  },
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fman%2Fman_shoes_Sneakers.png?alt=media&token=40d7a679-ff71-4a6d-a744-0a2cd994e4e2",
    "type": "Sneakers"
  },
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fman%2Fman_shoes_Boots.png?alt=media&token=8141ba6d-78de-458e-b63e-1ea427d16e0f",
    "type": "Boots"
  },
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fman%2Fman_shoes_Monk%20Strap.png?alt=media&token=3625acbb-ec95-4baf-9ab1-155424d16ab8",
    "type": "Monk Strap"
  },
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fman%2Fman_shoes_Chelsea.png?alt=media&token=fb851346-7fdb-43ee-b6e1-3c4ae59a020d",
    "type": "Chelsea"
  },
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fman%2Fman_shoes_Running.png?alt=media&token=672db59d-0cfa-4a75-88a1-38f953cd97b5",
    "type": "Running"
  },
];
List<Map> Mansandals = [
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fman%2Fman_sandals_Hiking.png?alt=media&token=26b43283-ba3a-4c84-8c28-ea3d5e6ca077",
    "type": 'Hiking'
  },
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fman%2Fman_sandals_Running.png?alt=media&token=5619d965-70e2-4247-b369-0fe6be94d545",
    "type": 'Running'
  },
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fman%2Fman_sandals_Water%20Sandals.png?alt=media&token=9b5c7dd5-c99d-46b2-acb6-6cf7fa64d773",
    "type": 'Water'
  },
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fman%2Fman_snadals_Leather%20Sandals.png?alt=media&token=dec5ed61-66dd-44bb-b50b-ddf7f887725d",
    "type": 'Leather'
  },
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fman%2Fman_sandals_Luna.png?alt=media&token=45868ef4-9e53-4c85-a85c-086f44b55c5f",
    "type": 'Luna'
  },
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fman%2Fman_sandals_Dress.png?alt=media&token=64c3c669-ba84-462d-9cbf-586cea477936",
    "type": 'Dress'
  },
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fman%2Fman_sandals_Teva.png?alt=media&token=a7da44c2-7766-4a24-bc68-dc34a673ffd3",
    "type": 'Teva'
  },
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fman%2Fman_sandals_Birkenstock.png?alt=media&token=867ca1c3-4401-4383-ac19-658d8eb7dfd1",
    "type": 'Birkenstock'
  },
];
List<Map> Manslippers = [
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fman%2Fman_slipper_Memory-foam.png?alt=media&token=1b9a0e33-6d64-42df-b316-228c2bdd2d7b",
    "type": 'Memory-foam'
  },
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fman%2Fman_sliper_Canvas.png?alt=media&token=e62c3f13-a04b-40c5-aab7-754d5b784e58",
    "type": 'Canvas'
  },
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fman%2Fman_sliper_Sheepskin%20moccasin.png?alt=media&token=9fc86665-86bd-4b4e-9725-7963ee76e023",
    "type": 'Sheepskin moccasin'
  },
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fman%2Fman_sliper_Wide.png?alt=media&token=a266de33-bf8c-4977-a425-79b055341931",
    "type": 'Wide'
  },
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fman%2Fman_sliper_Odor-free.png?alt=media&token=05e3de80-4a38-4b65-8c50-453ca1c2f7ed",
    "type": 'Odor-free'
  },
];
//woman
List<Map> Womanshoes = [
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fwomen%2Foxford-removebg-preview.png?alt=media&token=cb3f90a0-d4da-4a4f-a921-0f910d2e5f24",
    "type": 'Oxfords'
  },
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fwomen%2Fwoman_shoes_Thigh%20High.png?alt=media&token=95423675-27a6-4147-ad27-cdc86e9538c3",
    "type": 'Thigh High'
  },
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fwomen%2Fwoman_shoes_Loafer.png?alt=media&token=151a42c5-4b9f-4774-b5c1-0558df62b84a",
    "type": 'Loafer'
  },
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fwomen%2Fwoman_shoes_Fantasy.png?alt=media&token=56c9e6b6-29ba-470d-a810-7403e1d2748b",
    "type": 'Fantasy'
  },
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fwomen%2Fwoman_shoes_Sports.png?alt=media&token=64b7ff75-1b78-49fb-a377-1f86729365f8",
    "type": 'Sports'
  },
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fwomen%2Fwoman_shoes_Slip-on%20Sneakers.png?alt=media&token=9b3ee49a-933e-416d-8457-67a548fba76e",
    "type": 'Slip-on Sneakers'
  },
];
List<Map> Womansandals = [
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fwomen%2Fgladiur-removebg-preview.png?alt=media&token=445da9e7-ff07-4674-ab64-a78e3573a393",
    "type": 'Gladiator'
  },
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fwomen%2Fwoman_sandals_Open%20Toe.png?alt=media&token=c29305a9-a2a0-4612-80ab-a68ed0191bb5",
    "type": 'Open Toe'
  },
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fwomen%2Fwoman_sandlas_Jelly.png?alt=media&token=ebae3238-bb8a-4c65-ac00-51b9cf3a1c55",
    "type": 'Jelly'
  },
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fwomen%2Fwoman_sandals_Thong.png?alt=media&token=c50c41cd-139e-4970-b526-b59081217ddd",
    "type": 'Thong'
  },
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fwomen%2Fwoman_sandals_Saltwater.png?alt=media&token=f788ee54-6cef-477a-8a0c-d68601c470cb",
    "type": 'Saltwater'
  },
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fwomen%2Fwoman_sandals_Chunky.png?alt=media&token=a8115ec3-887d-4b99-81ed-a57eabecf0ae",
    "type": 'Chunky'
  },
];
List<Map> Womanheels = [
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fwomen%2Fwoman_heel__pumps.png?alt=media&token=83302fda-e905-460b-a8a4-149fec065925",
    "type": 'Pumps'
  },
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fwomen%2Fwoman_heel_'Stilettos'%2C.png?alt=media&token=d0f04b89-a7c5-48ec-a3ca-17c8a9f6cfbb",
    "type": 'Stilettos'
  },
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fwomen%2Fwoman_heel_Kitten.png?alt=media&token=917bfc04-5c19-48ce-9305-68d1725cb9bb",
    "type": 'Kitten'
  },
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fwomen%2Fwoman_heels_Sling%20back.png?alt=media&token=b6f50a03-30a3-4340-ace7-2a102601514a",
    "type": 'Sling back'
  },
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fwomen%2Fwoma_heels_Peep-Toe.png?alt=media&token=a6850574-fef3-475a-bcf0-a8d6bdcd785c",
    "type": 'Peep-Toe'
  },
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fwomen%2Fwoman_heels_Cork%20High.png?alt=media&token=e347a945-0c4d-43ce-bacc-b23650579487",
    "type": 'Cork High'
  },
];

//children
List<Map> Childrenshoes = [
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fchildren%2Fchild_shoes_School.png?alt=media&token=281dee8d-c4a1-4aab-92d9-c62d2c63b031",
    "type": 'School'
  },
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fchildren%2Fchild_shoes_Athletic.png?alt=media&token=989d2981-9e64-498d-9f3f-32cb8ee2fef5",
    "type": 'Athletic'
  },
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fchildren%2Fchild_shoes_High%20Tops.png?alt=media&token=dc86d27b-d8cb-4159-ac69-28e372fe5551",
    "type": 'High Tops'
  },
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fchildren%2Fchild_shoes_Sport.png?alt=media&token=c3801952-9c9b-48fa-84ef-bcea26cca88c",
    "type": 'Sport'
  },
];
List<Map> Childrensandals = [
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fchildren%2Fchild_sandals_Flip%20Flops.png?alt=media&token=675ede31-bc60-4153-bca8-eaf9cc61b891",
    "type": 'Flip Flops'
  },
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fchildren%2Fchild_sandals_Crocs.png?alt=media&token=bfb0eb25-22ff-456f-b85c-ae398064b41d",
    "type": 'Crocs'
  },
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fchildren%2Fchild_sandals_Bellies%20For%20Little.png?alt=media&token=8372ca8d-87a1-4f28-bc2a-e10ca305e5fb",
    "type": 'Bellies For Little'
  },
];
List<Map> Childrenboot = [
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fchildren%2Fchild_boot_Snow.png?alt=media&token=6299e2df-cacf-492e-aa52-817955cb809d",
    "type": 'Snow'
  },
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fchildren%2Fchild_boot_Rain.png?alt=media&token=0ba09893-6b4a-4786-89c1-eb9aa14df95e",
    "type": 'Rain'
  },
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fchildren%2Fchild_boot_Hikingl.png?alt=media&token=ad1e4377-b6fe-44bd-87f4-b6fbf6cbaf0e",
    "type": 'Hiking'
  },
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fchildren%2Fchild_boot_Rubber.png?alt=media&token=3d6329cb-2c9e-430f-98d3-40818310ba54",
    "type": 'Rubber'
  },
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fchildren%2Fchild_boot_Work.png?alt=media&token=e7b12be9-becd-4c2a-88db-d5dc40bad1b9",
    "type": 'Work'
  },
  {
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/foot-wear-club.appspot.com/o/Categories%2Fchildren%2Fchild_boot_Cowboy.png?alt=media&token=901ba8c6-956e-4525-a7d7-dc6b24386ed7",
    "type": 'Cowboy'
  },
];

List<Map> alllist = Manshoes +
    Mansandals +
    Manslippers +
    Womanshoes +
    Womansandals +
    Womanheels +
    Childrenshoes +
    Childrensandals +
    Childrenboot;

List<Map> serchedlist = [];

TextEditingController serchcontroller = TextEditingController();

class _BuyerCategoryState extends State<BuyerCategory> {
  @override
  void initState() {
    super.initState();
    serchon.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: InkWell(
                    onTap: () {
                      serchon.value = !serchon.value;

                      setState(() {});
                    },
                    child: Obx(() => Icon(
                          serchon.value ? Icons.search : Icons.cancel_outlined,
                          color: kPrimaryColor,
                          size: 30,
                        ))),
              )
            ],
            elevation: 0.5,
            backgroundColor: Colors.white,
            title: Obx(() {
              return serchon.value
                  ? Text(
                      "Categories",
                      style: TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.bold),
                    )
                  : Container(
                      height: 45,
                      child: TextField(
                        controller: serchcontroller,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: 'Serch Product by category',
                        ),
                        onSubmitted: (data) {
                          setState(() {});
                        },
                        onChanged: (text) {
                          serchedlist.clear();
                          alllist.forEach((element) {
                            element["type"]
                                    .toString()
                                    .toLowerCase()
                                    .contains(text.toLowerCase())
                                ? serchedlist.add(element)
                                : null;
                          });
                          //  print(serchedlist.length);
                          //  print(serchedlist);
                        },
                      ),
                    );
            }),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize:
                  serchon.value ? Size.fromHeight(50.0) : Size.fromHeight(0),
              child: Obx(() {
                return serchon.value
                    ? Column(
                        children: [
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 6.0),
                            child: ColoredBox(
                              color: Colors.white,
                              child: Container(
                                  height: 35,
                                  child: TabBar(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      unselectedLabelColor: Colors.black87,
                                      indicatorSize: TabBarIndicatorSize.tab,
                                      labelColor: Colors.white,
                                      indicator: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(35),
                                          color: kPrimaryColor),
                                      tabs: [
                                        Tab(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 3.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(35),
                                                  border: Border.all(
                                                      color: kPrimaryLightColor,
                                                      width: 2)),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text("MAN"),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Tab(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 3.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(35),
                                                  border: Border.all(
                                                      color: kPrimaryLightColor,
                                                      width: 2)),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text("WOMAN"),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Tab(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 3.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(35),
                                                  border: Border.all(
                                                      color: kPrimaryLightColor,
                                                      width: 2)),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text("KIDS"),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ])),
                            ),
                          ),
                        ],
                      )
                    : Container();
              }),
            ),
          ),
          body: Obx(() {
            return serchon.value
                ? TabBarView(children: [
                    Mantab(),
                    WoMantab(),
                    Childrentab(),
                  ])
                : SingleChildScrollView(
                    child: Makegridview(
                      data: serchedlist,
                      gender: '',
                      maintype: '',
                    ),
                  );
          })),
    );
  }
}

class Mantab extends StatelessWidget {
  const Mantab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Man's Shoes",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Makegridview(
              data: Manshoes,
              gender: "Man",
              maintype: "Shoes",
            ),
            Text("Man's Sandals",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            Makegridview(
              data: Mansandals,
              gender: "Man",
              maintype: "Sandals",
            ),
            Text("Man's Slippers",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            Makegridview(
              data: Manslippers,
              gender: "Man",
              maintype: "Slippers",
            ),
          ],
        ),
      ),
    );
  }
}

class WoMantab extends StatelessWidget {
  const WoMantab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Woman's Shoes",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            Makegridview(
              data: Womanshoes,
              gender: "Woman",
              maintype: "Shoes",
            ),
            Text("Woman's Sandals",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            Makegridview(
              data: Womansandals,
              gender: "Woman",
              maintype: "Sandals",
            ),
            Text("Woman's Heels",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            Makegridview(
              data: Womanheels,
              gender: "Woman",
              maintype: "Heels",
            ),
          ],
        ),
      ),
    );
  }
}

class Childrentab extends StatelessWidget {
  const Childrentab({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Kid's Shoes",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            Makegridview(
              data: Childrenshoes,
              gender: "Children",
              maintype: "Shoes",
            ),
            Text("Kid's Sandals",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            Makegridview(
              data: Childrensandals,
              gender: "Children",
              maintype: "Sandals",
            ),
            Text("Kid's Boot",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            Makegridview(
              data: Childrenboot,
              gender: "Children",
              maintype: "Boot",
            ),
          ],
        ),
      ),
    );
  }
}

class Makegridview extends StatelessWidget {
  final List<Map> data;
  final String gender;
  final String maintype;
  const Makegridview(
      {Key? key,
      required this.data,
      required this.gender,
      required this.maintype})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 15),
        child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: data.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 100, crossAxisCount: 3),
            itemBuilder: (BuildContext context, index) {
              return InkWell(
                onTap: () async {
                  buyerHomeController.subtypeproductlist.clear();
                  await buyerHomeController.getbysubtype(data[index]["type"]);

                  Get.to(ViewallcategoryScreen(
                    gender: gender,
                    maintype: maintype,
                    subtype: data[index]["type"].toString(),
                    screentitle: "${data[index]["type"]} For $gender",
                  ));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // CircleAvatar(
                    //   radius: 35,
                    //   backgroundImage: NetworkImage(
                    //     data[index]["imageUrl"],
                    //   ),
                    // ),
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        border: Border.all(color: kSecondaryColor, width: 1),
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: CachedNetworkImage(
                            progressIndicatorBuilder:
                                (context, url, progress) => Center(
                              child: CircularProgressIndicator(
                                color: kPrimaryColor,
                              ),
                            ),
                            imageUrl: data[index]["imageUrl"],
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      data[index]["type"],
                      maxLines: 1,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              );
            }));
  }
}
