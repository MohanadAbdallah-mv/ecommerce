import 'package:ecommerece/views/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import '../models/user_model.dart';
import '../widgets/CustomText.dart';
class CartPage extends StatefulWidget {
  MyUser user;
  CartPage({super.key,required this.user});

  @override
  State<CartPage> createState() => _CartPageState();
}
class _CartPageState extends State<CartPage> {
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
                        text: "Your Cart Items",
                        color: AppTitleColor,
                        fontWeight: FontWeight.w700,
                        size: 28,
                      ),
                    ],
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(top: 12),
                //   child: FutureBuilder(
                //       future:products ,
                //       builder: (context, snapshot) {
                //         if (snapshot.hasData ) {
                //           return ListView.builder(
                //               shrinkWrap: true,
                //               itemCount: snapshot.data!.length,
                //               scrollDirection: Axis.vertical,
                //               itemBuilder: (context, index) =>
                //                   ProductCardHorizontal(
                //                       index: index,
                //                       product: snapshot.data![index],
                //                       user: widget.user));
                //         } else {
                //
                //           return CircularProgressIndicator();
                //         }
                //       }),
                // ),

              ],
            ),
          ),
        ));
  }
}
