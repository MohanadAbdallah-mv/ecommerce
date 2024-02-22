import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'package:ecommerece/models/product.dart';
import 'package:ecommerece/models/user_model.dart';
import '../new_architecture/controller/firestore_controller.dart';
import '../views/product_detailed.dart';
import 'CustomButton.dart';
import 'CustomText.dart';
import 'RoundIconButton.dart';
import 'dart:developer';

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
    if(Provider.of<FireStoreController>(context, listen: false).likedListIds.contains(widget.product.id)){
      widget.isLiked=true;
    };
    widget.isDiscount = widget.product.discount_price! > 0 ? true : false;
    return Container(
      margin: EdgeInsets.only(top: 0),
      height: 172.h,
      width: 390.w,
      //color: Colors.red,
      child: Row(
        children: [
          Container(
            //color: Colors.blue,
            width: 150.w,
            height: 172.h,
            child: Stack(
              children: [
                Positioned(
                    left: 43.w,
                    top: 36.h,
                    child: Container(
                      width: 64.w,
                      height: 100.h,
                      color: Colors.white,
                      child: Image(
                        image: NetworkImage(widget.product.image!),
                        fit: BoxFit.fill,
                      ),
                    )),
                Positioned(
                    right: 0,
                    top: 0,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.isLiked = !widget.isLiked;
                          Provider.of<FireStoreController>(context, listen: false).likeItem(widget.product, widget.user);
                          if(Provider.of<FireStoreController>(context, listen: false).likedListIds.contains(widget.product.id)){
                            widget.isLiked=true;
                          };
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
                    right: 0,
                    child: Container(
                      alignment: Alignment.center,
                      height: 28.h,
                      width: 72.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomText(
                            text: widget.product.stars.toString(),
                            align: Alignment.center,
                            color: primaryColor,
                            size: 12.sp,
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
            height: 172.h,
            //color: Colors.red,
            padding: EdgeInsets.only(left: 12.w, top: 20.h),
            width: 220.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  height: widget.product.name!.length >= 19 ? 44.h : 24.h,
                  width: 180.w,
                  text: widget.product.name!,
                  textalign: TextAlign.left,
                  trim: widget.product.name!.length >= 40 ? true : false,
                  color: AppTitleColor,
                  fontfamily: "ReadexPro",
                  fontWeight: FontWeight.w400,
                  size: 16,
                ),
                CustomText(
                  height: 24.h,
                  text: widget.product.Author_name!,
                  color: AuthorColor,
                  textalign: TextAlign.left,
                  size: 15.sp,
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
                            size: 15.sp,
                          ),
                          CustomText(
                            text: "EGP ${widget.product.price}",
                            color: TypingColor,
                            fontfamily: "ReadexPro",
                            fontWeight: FontWeight.w400,
                            size: 12.sp,
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
                            size: 15.sp,
                          ),
                        ],
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 115.w,
                      height: 48.h,
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
                          width: 20.w,
                          height: 20.h,
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
