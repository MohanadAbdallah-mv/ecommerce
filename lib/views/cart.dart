import 'package:ecommerece/models/cart_item.dart';
import 'package:ecommerece/new_architecture/controller/firestore_controller.dart';
import 'package:ecommerece/views/map_page.dart';
import 'package:ecommerece/views/payment_page.dart';
import 'package:ecommerece/widgets/Cart_Item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'package:ecommerece/models/user_model.dart';
import '../widgets/CustomButton.dart';
import '../widgets/CustomText.dart';

class CartPage extends StatefulWidget {
  MyUser user;

  CartPage({super.key, required this.user});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<List<CartItem>> cartItemsList;
  bool checkoutButton = false;

  // late List<CartItem> cart;
  Future<List<CartItem>> MyFutureCartItems() async {
    List<CartItem> myfuture =
        await Provider.of<FireStoreController>(context, listen: false)
            .getItemsList(widget.user);
    return myfuture;
  }

  @override
  void initState() {
    cartItemsList = MyFutureCartItems();
    // cart=Provider.of<FireStoreController>(context,listen: false).cartItems;
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
                      color: AppTitleColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 30)),
            ),
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(right: 10, left: 10),
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
                      if (firestore.cartItems.isEmpty) {
                        checkoutButton = false;
                        return CustomText(
                          text: "no items",
                          color: Colors.black,
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: firestore.cartItems.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            if (index >= firestore.cartItems.length) {

                              return CustomText(
                                text: "no items ",
                                color: Colors.black,
                              );
                            } else {
                              return CartItemCard(
                                index: index,
                                product: firestore.cartItems[index].product!,
                                user: widget.user,
                              );
                            }
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Consumer<FireStoreController>(
          builder: (context, firestore, child){
            return Visibility(visible:firestore.cartItems.isEmpty?false:true ,
              child: SizedBox(
                height: 70,
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  color: Colors.white,
                  child: CustomButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomText(
                          text: "CheckOut",
                          size: 15,
                          color: Colors.white,
                          align: Alignment.center,
                          fontfamily: "ReadexPro",
                          fontWeight: FontWeight.w500,
                        ),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                        )
                      ],
                    ),
                    onpress: () {
                      if (Provider.of<FireStoreController>(context,listen: false)
                          .cartItems
                          .isEmpty) {
                      } else {
                        Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(builder: (context) =>  paymentPage(user: widget.user)));

                      }
                    },
                    height: 50,
                    borderColor: Colors.white,
                    color: primaryColor,
                  ),
                ),
              ),
            );
          },

        ));
  }
}

// Padding(
// padding: EdgeInsets.only(top: 12),
// child: FutureBuilder(
// future: cartItemsList,
// builder: (context, snapshot) {
// if (snapshot.hasError) {
// log("snapshot has error" + snapshot.error.toString());
// return CustomText(
// text: snapshot.error.toString(),
// color: Colors.black,
// );
// } else if (snapshot.connectionState == ConnectionState.waiting) {
// return CircularProgressIndicator();
// } else if (snapshot.data!.isEmpty) {
// print("no items");
// print(snapshot.data);
// return CustomText(
// text: "no items",
// color: Colors.black,
// );
// } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
// print("snapshot.hasData");
// print(snapshot.data!.length);
// print(widget.user.cart.items);
// print(snapshot.data![0].product!.name);
// //  print(cart);
// return ListView.builder(
// shrinkWrap: true,
// itemCount: snapshot.data!.length,
// scrollDirection: Axis.vertical,
// itemBuilder: (context, index) {
// if (index >= snapshot.data!.length) {
// // Handle the case where the index is out of range
// return Container();
// } else {
// return CartItemCard(
// index: index,
// product: snapshot.data![index].product!,
// user: widget.user,
// );
// }
// },
// );
// }
// return CircularProgressIndicator();
// },
// ),
// ),
