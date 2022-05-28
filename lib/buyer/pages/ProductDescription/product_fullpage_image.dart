import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:footwearclub/buyer/pages/ProductDescription/product_description.dart';
import 'package:footwearclub/constants/constant.dart';
import 'package:footwearclub/seller/pages/addproduct/add_product_screen.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class ProductFullPageImage extends StatefulWidget {
  final List? imgList;

  const ProductFullPageImage({Key? key, this.imgList}) : super(key: key);

  @override
  _ProductFullPageImageState createState() => _ProductFullPageImageState();
}

class _ProductFullPageImageState extends State<ProductFullPageImage> {
  int curIndex = 0;
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              size: 28,
            )),
        backgroundColor: kPrimaryColor,
        title: Text(
          "Photos",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.73,
            width: double.infinity,
            child: PageView.builder(
                onPageChanged: (index) {
                  setState(() {
                    curIndex = index;
                  });
                },
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                itemCount: widget.imgList?.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Padding(
                      padding: EdgeInsets.all(25),
                      child: PinchZoom(
                        child: CachedNetworkImage(
                          imageUrl: widget.imgList![index],
                          placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(
                            color: kPrimaryColor,
                          )),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, left: 20),
            height: MediaQuery.of(context).size.width * 0.22,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: widget.imgList?.length,
                itemBuilder: (context, index) => curIndex == index
                    ? Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: kPrimaryColor, width: 3),
                            borderRadius: BorderRadius.circular(10)),
                        height: MediaQuery.of(context).size.width * 0.22,
                        margin: EdgeInsets.only(right: 10),
                        width: MediaQuery.of(context).size.width * 0.22,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: CachedNetworkImage(
                            imageUrl: widget.imgList![index],
                            fit: BoxFit.fill,
                            placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(
                              color: kPrimaryColor,
                            )),
                          ),
                        ))
                    : InkWell(
                        onTap: () {
                          setState(() {
                            _pageController.animateToPage(index,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          });
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: kPrimaryColor),
                                borderRadius: BorderRadius.circular(10)),
                            height: MediaQuery.of(context).size.width * 0.21,
                            margin: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width * 0.22,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: CachedNetworkImage(
                                imageUrl: widget.imgList![index],
                                fit: BoxFit.fill,
                                placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(
                                  color: kPrimaryColor,
                                )),
                              ),
                            )),
                      )),
          )
        ],
      ),
    );
  }
}
