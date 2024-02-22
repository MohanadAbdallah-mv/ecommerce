import 'dart:developer';

import 'package:ecommerece/constants.dart';
import 'package:ecommerece/models/user_model.dart';
import 'package:ecommerece/views/product_detailed.dart';
import 'package:ecommerece/widgets/CustomButton.dart';
import 'package:ecommerece/widgets/CustomText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'package:ecommerece/models/product.dart';
import '../new_architecture/controller/firestore_controller.dart';

class ProductCard extends StatefulWidget {
  int index;
  Product product;
  MyUser user;
  bool isLiked;
  late bool isDiscount;

  ProductCard(
      {super.key,
      required this.index,
      required this.product,
      this.isLiked = false,
      this.isDiscount = false,
      required this.user});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
@override
  void initState() {
  log("checking in product card ${Provider.of<FireStoreController>(context, listen: false).likedListIds}");
  log("${widget.user.wishList}");
  // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(Provider.of<FireStoreController>(context, listen: false).likedListIds.contains(widget.product.id)){
      widget.isLiked=true;
    };
    widget.isDiscount = widget.product.discount_price! > 0 ? true : false;
    print(
        "${widget.product.name} and discount price is ${widget.product.discount_price} and for the widget${widget.isDiscount}");
    return Consumer<FireStoreController>(
      builder: (context, fire, child) {
        return Container(
            margin: EdgeInsets.only(right: 12.w),
            height: 250.h,
            width: 150.w,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey, blurRadius: 10, offset: Offset(0, 3)),
              ],
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //image and Like button
                Container(
                  height: 100.h,
                  child: Stack(
                    children: [
                      Positioned(
                          left: 40.w,
                          child: Container(
                              height: 100.h,
                              width: 64.w,
                              child: Image(
                                image: NetworkImage(widget.product.image!),
                                fit: BoxFit.fill,
                              ))),
                      Positioned(
                          right: 4.w,
                          top: 4.h,
                          child: GestureDetector(
                            onTap: () async{
                              await Provider.of<FireStoreController>(context, listen: false).likeItem(widget.product, widget.user);
                              setState(() {
                                widget.isLiked = !widget.isLiked;
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
                              width: 32.w,
                              height: 32.h,
                            ),
                          )),
                    ],
                  ),
                ),
                //Author name and product name
                Container(
                  padding: EdgeInsets.only(left: 8.w, right: 4.w),
                  width: double.maxFinite,
                  height: 63.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomText(
                        height: widget.product.name!.length >= 19 ? 42.h : 24.h,
                        text: widget.product.name!,
                        textalign: TextAlign.left,
                        trim: widget.product.name!.length >= 20 ? true : false,
                        color: AppTitleColor,
                        fontfamily: "ReadexPro",
                        fontWeight: FontWeight.w400,
                        size: 14.sp,
                      ),
                      CustomText(
                        text: widget.product.Author_name!,
                        color: AuthorColor,
                        textalign: TextAlign.left,
                        size: 12.sp,
                      ),
                    ],
                  ),
                ),
                //price and stars
                Container(padding: EdgeInsets.only(left: 8.w,right: 4.w),
                  height: 50.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      widget.isDiscount
                          ? Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: "EGP ${widget.product.discount_price}",
                                  color: AppTitleColor,
                                  fontfamily: "ReadexPro",
                                  fontWeight: FontWeight.w400,
                                  size: 16.sp,
                                ),
                                CustomText(
                                  text: "EGP ${widget.product.price}",
                                  color: TypingColor,
                                  fontfamily: "ReadexPro",
                                  fontWeight: FontWeight.w400,
                                  size: 13.sp,
                                  linethrough: true,
                                )
                              ],
                            )
                          : Column(
                              children: [
                                SizedBox(
                                  height: 12.h,
                                ),
                                CustomText(
                                  text: "EGP ${widget.product.price}",
                                  color: AppTitleColor,
                                  fontfamily: "ReadexPro",
                                  fontWeight: FontWeight.w400,
                                  size: 16.sp,
                                ),
                              ],
                            ),
                      widget.isDiscount
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: widget.product.stars.toString(),
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
                            )
                          : Column(
                              children: [
                                SizedBox(height: 12.h,),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: widget.product.stars.toString(),
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
                              ],
                            ),
                    ],
                  ),
                ),
                //Add to cart button
                Container(
                  height: 36.h,
                  padding: EdgeInsets.only(bottom: 8.h,left: 4.w,right: 4.w),
                  child: CustomButton(
                    child: CustomText(
                      text: "Add to Cart",
                      size: 12.sp,
                      color: Colors.white,
                      align: Alignment.center,
                    ),
                    onpress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetailed(
                                  product: widget.product, user: widget.user)));
                    },
                    borderColor: Colors.white,
                    color: primaryColor,
                  ),
                ),
                // SizedBox(
                //   height: 3,
                // )
              ],
            ));
      },
    );
  }
}
