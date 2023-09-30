import 'dart:developer';

import 'package:ecommerece/constants.dart';
import 'package:ecommerece/models/user_model.dart';
import 'package:ecommerece/views/product_detailed.dart';
import 'package:ecommerece/widgets/CustomButton.dart';
import 'package:ecommerece/widgets/CustomText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../new_architecture/controller/firestore_controller.dart';

class ProductCard extends StatefulWidget {
  int index;
  Product product;
  MyUser user;
  bool isLiked;
  late bool isDiscount;

  ProductCard({super.key, required this.index, required this.product,this.isLiked=false,this.isDiscount=false,required this.user});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
@override
  void initState() {
    widget.product.discount_price!>0?widget.isDiscount=true:widget.isDiscount=false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    isDiscount=widget.product.discount_price!>0?true:false;
    return Consumer<FireStoreController>(
      builder: (context, fire, child) {
        return GestureDetector(
          onTap: () {
            setState(() {
              //widget.isSelected=!widget.isSelected;
            });
            print(widget.index);
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
                height: 280,
                width: 150,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10,
                        offset: Offset(0, 3)),
                  ],
                  color: Colors.white,
                ),
                child: Stack(
                  children: [
                    Positioned(
                        left: 40,
                        child: Container(
                            height: 105,
                            width: 64,
                            child: Image(
                              image: NetworkImage(widget.product.image!),
                              fit: BoxFit.fill,
                            ))),
                    Positioned(right: 8,top: 16,
                        child: GestureDetector(onTap: (){setState(() {
                          widget.isLiked=!widget.isLiked;
                          //todo : create global is Liked for that user with product controller
                        });},
                          child: SvgPicture.asset(
                            widget.isLiked?"assets/svg/like button=liked.svg":"assets/svg/like button=defult.svg",
                            fit: BoxFit.values.last,
                            width:32 ,height: 32,),
                        )),
                    Positioned(
                        top: 113,
                        left: 8,
                        child: Container(
                          width: 136,
                          height: 120,
                          child: Column(
                            children: [
                              Expanded(
                                child: CustomText(
                                  text: widget.product.name!,
                                  textalign: TextAlign.left,
                                  trim: widget.product.name!.length >= 20
                                      ? true
                                      : false,
                                  color: AppTitleColor,
                                  fontfamily: "ReadexPro",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Expanded(
                                child: CustomText(
                                  text: widget.product.Author_name!,
                                  color: AuthorColor,
                                  size: 12,
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    widget.isDiscount?SizedBox(height: 30,
                                      child: Column(
                                        children: [
                                          CustomText(
                                            text: "EGP ${widget.product.discount_price}",
                                            color: AppTitleColor,
                                            fontfamily: "ReadexPro",
                                            fontWeight: FontWeight.w400,size: 14,),
                                          CustomText(
                                            text: "EGP ${widget.product.price}",
                                            color: TypingColor,
                                            fontfamily: "ReadexPro",
                                            fontWeight: FontWeight.w400,size: 8,linethrough: true,)
                                        ],
                                      ),
                                    ):CustomText(
                                      text: "EGP ${widget.product.price}",
                                      color: AppTitleColor,
                                      fontfamily: "ReadexPro",
                                      fontWeight: FontWeight.w400,size: 16,),
                                    Row(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: widget.product.stars.toString(),
                                          color: primaryColor,
                                          size: 12,
                                          fontfamily: "ReadexPro",
                                          fontWeight: FontWeight.w400,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellowAccent,size: 20,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),Expanded(
                                child: CustomButton(
                                  width: 132,
                                  height: 32,
                                  child: CustomText(
                                    text: "Add to Cart",
                                    size: 12,
                                    color: Colors.white,
                                    align: Alignment.center,
                                  ),
                                  onpress: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailed(product: widget.product, user: widget.user)));
                                    //todo : navigate to product detailed screen
                                  },
                                  borderColor: Colors.white,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                )),
          ),
        );
      },
    );
  }
}


