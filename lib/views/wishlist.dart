import 'package:ecommerece/views/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/user_model.dart';
import '../new_architecture/controller/firestore_controller.dart';
import '../widgets/CustomText.dart';
import '../widgets/product_card_horizontal.dart';
class WishList extends StatefulWidget {
  MyUser user;
  WishList({super.key,required this.user});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
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
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    children: [

                      CustomText(
                        text: "Your WishList",
                        color: AppTitleColor,
                        fontWeight: FontWeight.w700,
                        size: 28,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Consumer<FireStoreController>(
                    builder: (context, firestore, child) {
                      if(firestore.likedList.isEmpty){
                        return CustomText(
                          text: "no items",
                          color: Colors.black,
                        );
                      }else{return ListView.builder(
                        shrinkWrap: true,
                        itemCount: firestore.likedList.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          if (index >= firestore.likedList.length) {
                            // Handle the case where the index is out of range
                            return CustomText(
                              text: "no items",
                              color: Colors.black,
                            );
                          } else {return Container(color: Colors.black,width: 100,height: 100,);
                          //   return ProductCardHorizontal(
                          //       index: index,
                          //       product: firestore.likedList[index].product!,
                          //       user: widget.user);
                           }
                        },
                      );}

                    },
                  ),
                ),

              ],
            ),
          ),
        ));
  }
}
