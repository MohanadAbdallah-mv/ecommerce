import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/product.dart';
import '../models/user_model.dart';
import '../new_architecture/controller/firestore_controller.dart';
import '../views/product_detailed.dart';
import 'CustomButton.dart';
import 'CustomText.dart';
import 'RoundIconButton.dart';

class CartItemCard extends StatefulWidget {
  int index;
  Product product;
  late bool isDiscount;
  bool isLiked;
  MyUser user;

  //late bool isDiscount;
  CartItemCard(
      {super.key,
      required this.index,
      required this.product,
      required this.user,
      this.isDiscount = false,
      this.isLiked = false});

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  @override
  Widget build(BuildContext context) {
    print(widget.product.sub_category);
    widget.isDiscount = widget.product.discount_price! > 0 ? true : false;
    return Container(
      margin: EdgeInsets.only(top: 0),
      height: 176,
      width: double.maxFinite,
      //color: Colors.red,
      child: Row(
        children: [
          Container(
            //color: Colors.blue,
            width: 150,
            height: 172,
            child: Stack(
              children: [
                Positioned(
                    left: 44,
                    top: 36,
                    child: Container(
                      width: 64,
                      height: 100,
                      color: Colors.white,
                      child: Image(
                        image: NetworkImage(widget.product.image!),
                        fit: BoxFit.fill,
                      ),
                    )),
                Positioned(
                    right: 8,
                    top: 12,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.isLiked = !widget.isLiked;
                          //todo : create global is Liked for that user with product controller
                        });
                      },
                      child: SvgPicture.asset(
                        widget.isLiked
                            ? "assets/svg/like button=liked.svg"
                            : "assets/svg/like button=defult.svg",
                        fit: BoxFit.values.last,
                        width: 32,
                        height: 32,
                      ),
                    )),
                Positioned(
                    bottom: 3,
                    right: 1,
                    child: Container(
                      alignment: Alignment.center,
                      height: 28,
                      width: 72,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomText(
                            text: widget.product.stars.toString(),
                            align: Alignment.center,
                            color: primaryColor,
                            size: 12,
                            fontfamily: "ReadexPro",
                            fontWeight: FontWeight.w400,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellowAccent,
                            size: 20,
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
          Container(
            height: 172,
            //color: Colors.red,
            padding: EdgeInsets.only(left: 12, top: 20),
            width: 240,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  height: widget.product.name!.length >= 19 ? 44 : 24,
                  width: 180,
                  text: widget.product.name!,
                  textalign: TextAlign.left,
                  trim: widget.product.name!.length >= 40 ? true : false,
                  color: AppTitleColor,
                  fontfamily: "ReadexPro",
                  fontWeight: FontWeight.w400,
                  size: 16,
                ),
                CustomText(
                  height: 24,
                  text: widget.product.Author_name!,
                  color: AuthorColor,
                  textalign: TextAlign.left,
                  size: 15,
                ),
                widget.isDiscount
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "EGP ${widget.product.discount_price}",
                            color: AppTitleColor,
                            fontfamily: "ReadexPro",
                            fontWeight: FontWeight.w400,
                            size: 15,
                          ),
                          CustomText(
                            text: "EGP ${widget.product.price}",
                            color: TypingColor,
                            fontfamily: "ReadexPro",
                            fontWeight: FontWeight.w400,
                            size: 12,
                            linethrough: true,
                          )
                        ],
                      )
                    : Column(
                        children: [
                          CustomText(
                            text: "EGP ${widget.product.price}",
                            color: AppTitleColor,
                            fontfamily: "ReadexPro",
                            fontWeight: FontWeight.w400,
                            size: 15,
                          ),
                        ],
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 115,
                      height: 48,
                      //alignment: Alignment.topRight,
                      //padding: EdgeInsets.only(right: , bottom: 8),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RoundIconButton(
                            svgPath: "assets/svg/minus.svg",
                            onPress: () {
                              Provider.of<FireStoreController>(context, listen: false).setQuantity(widget.product, widget.user,widget.index, false);
                            },
                          ),
                          Text(
                            Provider.of<FireStoreController>(context, listen: false).cartItems[widget.index].quantity.toString(),
                            style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.w500,color: CartItemCounterColor),
                          ),
                          RoundIconButton(
                            svgPath: "assets/svg/plus.svg",
                            onPress: () {
                              Provider.of<FireStoreController>(context, listen: false).setQuantity(widget.product, widget.user,widget.index, true);
                            },
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                         setState(() {
                           Provider.of<FireStoreController>(context, listen: false).deleteItem(widget.product,widget.user,widget.index);
                         });
                          },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: SvgPicture.asset(
                          "assets/svg/delete_item.svg",
                          fit: BoxFit.values.last,
                          width: 20,
                          height: 20,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
