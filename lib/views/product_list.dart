import 'dart:developer';

import 'package:ecommerece/models/user_model.dart';
import 'package:ecommerece/new_architecture/controller/firestore_controller.dart';
import 'package:ecommerece/widgets/SearchBar.dart';
import 'package:ecommerece/widgets/product_card_horizontal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/product.dart';

import '../widgets/CustomText.dart';

class ProductList extends StatefulWidget {
  MyUser user;
  String? title;
  String category;

  ProductList(
      {super.key, required this.user, this.title = "", required this.category});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late Future<List<Product>?> products;
  Future<List<Product>?> MyFutureBestSeller(String category) async {
    var myfuture =
        await Provider.of<FireStoreController>(context, listen: false)
            .getBestSeller(category);

//todo : implement either left and put it down to show error if it is left,null loading and right is data

    return myfuture.right;
  }
  Future<List<Product>?> MyFutureDontMiss(String category) async {
    log('fuck');
    var myfuture =
    await Provider.of<FireStoreController>(context, listen: false)
        .getDontMiss(category);
//todo : implement either left and put it down to show error if it is left,null loading and right is data

    return myfuture.right;
  }
@override
  void initState() {
    switch(widget.title){
      case "BestSeller":
        products=MyFutureBestSeller(widget.category);
        break;
      case "DontMiss":
        products=MyFutureDontMiss(widget.category);
        break;
      default:
        //product category in general
    }

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "Shoppie",
              style: GoogleFonts.sarina(
                  textStyle: TextStyle(
                      color: AppTitleColor, fontWeight: FontWeight.w400)),
            ),
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),

        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(mainAxisSize: MainAxisSize.min,
              children: [
                SearchBarfor(),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    children: [
                      widget.title == ""
                          ? CustomText(
                              text: widget.title!,
                              color: AppTitleColor,
                              fontWeight: FontWeight.w700,
                              size: 28,
                            )
                          : CustomText(
                              text: widget.title!,
                              color: AppTitleColor,
                              fontWeight: FontWeight.w700,
                              size: 28,
                            ),
                      Container(
                          margin: EdgeInsets.only(left: 8),
                          height: 40,
                          width: 108,
                          child: Center(
                              child: Text(
                            widget.category,
                            style: TextStyle(
                                fontFamily: "Readex",
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          )),
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.white)))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: FutureBuilder(
                      future:products ,
                      builder: (context, snapshot) {
                        if (snapshot.hasData ) {
                          return ListView.builder(
                            shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) =>
                                  ProductCardHorizontal(
                                      index: index,
                                      product: snapshot.data![index],
                                      user: widget.user));
                        } else {

                          return CircularProgressIndicator();
                        }
                      }),
                ),

              ],
            ),
          ),
        ));
  }
}
