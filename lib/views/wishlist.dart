import 'dart:developer';

import 'package:ecommerece/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'package:ecommerece/models/user_model.dart';
import '../new_architecture/controller/firestore_controller.dart';
import '../widgets/CustomText.dart';
import '../widgets/product_card_horizontal.dart';

class WishList extends StatefulWidget {
  MyUser user;

  WishList({super.key, required this.user});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  //Stream? dataList;
  late Future<List<Product>> likedItemsFuture;
  Future<List<Product>> MyFutureLikedItems() async {
    List<Product> myfuture =
    await Provider.of<FireStoreController>(context, listen: false)
        .myLikedItems();
    return myfuture;
  }
  @override
  void initState() {
    likedItemsFuture = MyFutureLikedItems(); // TODO: implement initState
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
                      color: AppTitleColor, fontWeight: FontWeight.w400,fontSize: 34.sp)),
            ),
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(right: 10,left: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    children: [
                      CustomText(
                        text: "Your WishList",
                        color: AppTitleColor,
                        fontWeight: FontWeight.w400,
                        size: 24,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Consumer<FireStoreController>(
                    builder: (context, firestore, child) {
                        if (firestore.likedList.isEmpty){
                          return CustomText(
                            text: "no items",
                            color: Colors.black,
                          );
                        } else  {
                          log("entering listview builder in wish list ${firestore.likedList}");
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: firestore.likedList.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              if(index >= firestore.likedList.length){
                                return CustomText(
                                text: "no items",
                                color: Colors.black,
                              );}
                              else{

                                return ProductCardHorizontal(
                                  index: index,
                                  product: firestore.likedList[index],
                                  user: widget.user);}
                            },
                          );
                        }
                    },
                  ),
                ),

              ],
            ),
          ),
        ));
  }
}

//
// child: StreamBuilder(
// stream: dataList,
// builder: (context, asyncSnapshot) {
// if (asyncSnapshot.hasError) {
// return Text('Error: ${asyncSnapshot.error}');
// }
// else {
// switch (asyncSnapshot.connectionState) {
// case ConnectionState.none:
// return Text('No data');
// case ConnectionState.waiting:
// return Text('Awaiting...');
// case ConnectionState.active:
// print(ConnectionState.active);
// return ListView.builder(
// shrinkWrap: true,
// itemCount: Provider
//     .of<FireStoreController>(
// context, listen: false)
//     .likedList
//     .length,
// scrollDirection: Axis.vertical,
// itemBuilder: (context, index) {
// if (index >= Provider
//     .of<FireStoreController>(
// context, listen: false)
//     .likedList
//     .length) {
// // Handle the case where the index is out of range
// log("inside list view builder");
// return CustomText(
// text: "no items inside stream",
// color: Colors.black,
// );
// } else { //return Container(color: Colors.black,width: 100,height: 100,);
// log(asyncSnapshot.hasData.toString());
// return ProductCardHorizontal(index: index,
// product: Product.fromJson(
// asyncSnapshot.data),
// user: widget.user);
// }
// },
// );
// case ConnectionState.done:
// print(ConnectionState.done);
// return ListView(
// children: asyncSnapshot.data.data().map((
// document) => Text(document.toString())),
// );
// }
// // return null;
//
// }
// })
