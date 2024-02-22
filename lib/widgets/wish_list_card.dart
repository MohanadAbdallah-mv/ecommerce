import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'package:ecommerece/models/product.dart';
import 'package:ecommerece/models/user_model.dart';
import '../new_architecture/controller/firestore_controller.dart';
import '../views/product_detailed.dart';
import 'CustomText.dart';

class WishListCard extends StatefulWidget {
  int index;
  String productid;
  late bool isDiscount;
  bool isLiked;
  MyUser user;

  //late bool isDiscount;
  WishListCard(
      {super.key,
      required this.index,
      required this.productid,
      required this.user,
      this.isDiscount = false,
      this.isLiked = false});

  @override
  State<WishListCard> createState() => _WishListCardState();
}

class _WishListCardState extends State<WishListCard> {
late Product product;
  @override
Future<Product> getProduct(String id) async {
  var res =await Provider.of<FireStoreController>(context).getItemById(id);
  if(res.isRight){
    return res.right;
  }else{
    throw "error at wishlist card";
  }
}
void initState() async{
    product= await getProduct(widget.productid);// TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(Provider.of<FireStoreController>(context, listen: false).likedListIds.contains(product.id)){
      widget.isLiked=true;
    };
    widget.isDiscount = product.discount_price! > 0 ? true : false;
    return Container(
      margin: EdgeInsets.only(top: 0),
      height: 176.h,
      width: double.maxFinite,
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
                    left: 44.w,
                    top: 36.h,
                    child: Container(
                      width: 64.w,
                      height: 100.h,
                      color: Colors.white,
                      child: Image(
                        image: NetworkImage(product.image!),
                        fit: BoxFit.fill,
                      ),
                    )),
                Positioned(
                    right: 8.w,
                    top: 12.h,
                    child: GestureDetector(
                      onTap: () async{
                        await Provider.of<FireStoreController>(context, listen: false).likeItem(product, widget.user);
                        setState(() {
                          widget.isLiked = !widget.isLiked;
                          if(Provider.of<FireStoreController>(context, listen: false).likedListIds.contains(product.id)){
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
                Positioned(
                    bottom: 3,
                    right: 1,
                    child: Container(
                      alignment: Alignment.center,
                      height: 28.h,
                      width: 72.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomText(
                            text: product.stars.toString(),
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
            width: 240.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  height: product.name!.length >= 19 ? 44.h : 24.h,
                  width: 180.w,
                  text: product.name!,
                  textalign: TextAlign.left,
                   trim: product.name!.length >= 40 ? true : false,
                  color: AppTitleColor,
                  fontfamily: "ReadexPro",
                  fontWeight: FontWeight.w400,
                  size: 16.sp,
                ),
                CustomText(
                  height: 24.h,
                  text: product.Author_name!,
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
                            text: "EGP ${product.discount_price}",
                            color: AppTitleColor,
                            fontfamily: "ReadexPro",
                            fontWeight: FontWeight.w400,
                            size: 15.sp,
                          ),
                          CustomText(
                            text: "EGP ${product.price}",
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
                            text: "EGP ${product.price}",
                            color: AppTitleColor,
                            fontfamily: "ReadexPro",
                            fontWeight: FontWeight.w400,
                            size: 15.sp,
                          ),
                        ],
                      ),
                Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(

                      width: 192.w,
                      height: 48.h,
                      //alignment: Alignment.bottomLeft,
                      padding: EdgeInsets.only(left: 14.w, bottom: 8),
                      child: ListView.builder(
                        reverse: true,
                        scrollDirection: Axis.vertical,
                        itemCount:
                            product.sub_category!.length > 1 ? 2 : 1,
                        itemBuilder: (context, index) => CustomText(
                          align: Alignment.bottomLeft,
                          height: 24.h,
                          text: product.sub_category![index].toString(),
                          fontfamily: "ReadexPro",
                          fontWeight: FontWeight.w400,
                          color: primaryColor,
                          size: 15,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetailed(
                                    product:product, user: widget.user)));
                      },
                      child: SvgPicture.asset(
                        "assets/svg/add_to_cart.svg",
                        fit: BoxFit.values.last,
                        width: 20.w,
                        height: 20.h,
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
