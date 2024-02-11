import 'package:flutter/material.dart';
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
                        image: NetworkImage(product.image!),
                        fit: BoxFit.fill,
                      ),
                    )),
                Positioned(
                    right: 8,
                    top: 12,
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
                            text: product.stars.toString(),
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
                  height: product.name!.length >= 19 ? 44 : 24,
                  width: 180,
                  text: product.name!,
                  textalign: TextAlign.left,
                   trim: product.name!.length >= 40 ? true : false,
                  color: AppTitleColor,
                  fontfamily: "ReadexPro",
                  fontWeight: FontWeight.w400,
                  size: 16,
                ),
                CustomText(
                  height: 24,
                  text: product.Author_name!,
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
                            text: "EGP ${product.discount_price}",
                            color: AppTitleColor,
                            fontfamily: "ReadexPro",
                            fontWeight: FontWeight.w400,
                            size: 15,
                          ),
                          CustomText(
                            text: "EGP ${product.price}",
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
                            text: "EGP ${product.price}",
                            color: AppTitleColor,
                            fontfamily: "ReadexPro",
                            fontWeight: FontWeight.w400,
                            size: 15,
                          ),
                        ],
                      ),
                Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(

                      width: 192,
                      height: 48,
                      //alignment: Alignment.bottomLeft,
                      padding: EdgeInsets.only(left: 14, bottom: 8),
                      child: ListView.builder(
                        reverse: true,
                        scrollDirection: Axis.vertical,
                        itemCount:
                            product.sub_category!.length > 1 ? 2 : 1,
                        itemBuilder: (context, index) => CustomText(
                          align: Alignment.bottomLeft,
                          height: 24,
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
                        width: 20,
                        height: 20,
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
