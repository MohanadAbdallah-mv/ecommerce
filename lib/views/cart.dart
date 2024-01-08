import 'dart:developer';

import 'package:ecommerece/models/cart_item.dart';
import 'package:ecommerece/models/product.dart';
import 'package:ecommerece/new_architecture/controller/firestore_controller.dart';
import 'package:ecommerece/widgets/Cart_Item.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/user_model.dart';
import '../new_architecture/controller/cart_controller.dart';
import '../widgets/CustomText.dart';
import '../widgets/product_card_horizontal.dart';

class CartPage extends StatefulWidget {
  MyUser user;

  CartPage({super.key, required this.user});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<List<CartItem>> cartItemsList;

  Future<List<CartItem>> MyFutureCartItems() async {
    List<CartItem> myfuture =
        await Provider.of<FireStoreController>(context, listen: false)
            .getItemsList(widget.user);
//todo : implement either left and put it down to show error if it is left,null loading and right is data
    return myfuture;
  }

  @override
  void initState() {
    cartItemsList = MyFutureCartItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Provider.of<FireStoreController>(context,listen: false).getItemsList(widget.user);
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: FutureBuilder(
                    future: cartItemsList,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        log("snapshot has error" + snapshot.error.toString());
                        return CustomText(
                          text: snapshot.error.toString(),
                          color: Colors.black,
                        );
                      } else if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.data!.isEmpty) {
                        print("no items");
                        print(snapshot.data);
                        return CustomText(
                          text: "no items",
                          color: Colors.black,
                        );
                      } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        print("snapshot.hasData");
                        print(snapshot.data!.length);
                        print(widget.user.cart.items);
                        print(snapshot.data![0].product!.name);

                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            if (index >= snapshot.data!.length) {
                              // Handle the case where the index is out of range
                              return Container();
                            } else {
                              return CartItemCard(
                                index: index,
                                product: snapshot.data![index].product!,
                                user: widget.user,
                              );
                            }
                          },
                        );
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
// ProductCardHorizontal(
// index: index,
// product: snapshot
//     .data!.right[index].product!,
// user: widget.user)

// Builder(
// builder: (context) {
// if (cart != null ? true : false) {
// return ;
// } else {
// Provider.of<FireStoreController>(context, listen: false)
//     .getItemsList(widget.user);
// return Text(
// "data",
// style: TextStyle(color: Colors.black),
// );
// }
// },
// )
