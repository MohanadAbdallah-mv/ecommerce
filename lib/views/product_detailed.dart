import 'package:ecommerece/models/product.dart';
import 'package:ecommerece/models/user_model.dart';
import 'package:ecommerece/views/bottom_navigation.dart';
import 'package:ecommerece/widgets/CustomButton.dart';
import 'package:ecommerece/widgets/CustomText.dart';
import 'package:ecommerece/widgets/Product_card.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../new_architecture/controller/firestore_controller.dart';
class ProductDetailed extends StatefulWidget {
  Product product;
  MyUser user;
  bool isLiked;
  ProductDetailed(
      {super.key,
      required this.product,
      required this.user,
      this.isLiked = false});

  @override
  State<ProductDetailed> createState() => _ProductDetailedState();
}
late bool isDiscount;
class _ProductDetailedState extends State<ProductDetailed> {
  Future<List<Product>> MyFutureSimilar() async {
    Either<String, List<Product>> myfuture =
        await Provider.of<FireStoreController>(context)
            .getSimilarFrom(widget.product.sub_category?[0]);
//todo : implement either left and put it down to show error if it is left,null loading and right is data
    return myfuture.right;
  }

  @override
  Widget build(BuildContext context) {
    if(Provider.of<FireStoreController>(context, listen: false).likedListIds.contains(widget.product.id)){
      widget.isLiked=true;
    };
    isDiscount=widget.product.discount_price!>0?true:false;
    return Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false,
          title: Center(
            child: Text(
              "Shoppie",
              style: GoogleFonts.sarina(
                  textStyle: TextStyle(
                      color: AppTitleColor, fontWeight: FontWeight.w400,fontSize: 34.sp)),
            ),
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CustomText(
                  text: widget.product.name!,
                  color: AppTitleColor,
                  size: 22,
                  fontfamily: "ReadexPro",
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                    height: 300,
                    width: double.maxFinite,
                    child: Stack(
                      children: [
                        Positioned(
                            left: 100,
                            child: SizedBox(
                              height: 300,
                              child: Image(
                                image: NetworkImage(widget.product.image!),
                                fit: BoxFit.fill,
                              ),
                            )),
                        Positioned(
                            right: 1,
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
                                    ? "assets/svg/like button=large liked.svg"
                                    : "assets/svg/like button=large def.svg",
                                fit: BoxFit.values.last,
                                width: 32,
                                height: 32,
                              ),
                            )),
                        Positioned(
                            bottom: 1,
                            right: 1,
                            child: Container(
                              height: 28,
                              width: 76,
                              child: CustomButton(
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: widget.product.stars.toString(),
                                          color: primaryColor,
                                          size: 15,
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
                                  ),
                                  onpress: () {},
                                  borderColor: primaryColor,
                                  color: Colors.white),
                            ))
                      ],
                    )),
                SizedBox(
                  height: 40,
                ),
                CustomText(
                  text: "Description ",
                  color: Colors.black,
                  fontfamily: "ReadexPro",
                  fontWeight: FontWeight.w400,
                  size: 22,
                  textalign: TextAlign.left,
                ),
                SizedBox(
                  height: 8,
                ),
                CustomText(
                  text: widget.product.Description!,
                  color: TypingColor,
                  textalign: TextAlign.left,
                ),
                SizedBox(
                  height: 80,
                ),
                CustomText(
                  text: "Specifications",
                  color: Colors.black,
                  fontfamily: "ReadexPro",
                  fontWeight: FontWeight.w400,
                  size: 22,
                  textalign: TextAlign.left,
                ),
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                  height: 68,
                  child: ListView.builder(
                      itemCount: widget.product.Specifications!.length,
                      itemBuilder: (context, index) => CustomText(
                            text: "• ${widget.product.Specifications![index]}",
                            color: TypingColor,
                            textalign: TextAlign.left,
                          )),
                ),
                SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Similar from",
                      color: Colors.black,
                      fontfamily: "ReadexPro",
                      fontWeight: FontWeight.w400,
                      size: 22,
                      textalign: TextAlign.left,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 100,
                      height: 36,
                      child: CustomButton(
                          child: CustomText(
                            text: widget.product.sub_category![0],
                            color: primaryColor,
                            align: Alignment.center,
                          ),
                          onpress: () {},
                          borderColor: primaryColor,
                          color: Colors.white),
                    )
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  width: double.maxFinite,
                  child: CustomText(
                    text: "seemore",
                    color: TypingColor,textalign: TextAlign.right,align: Alignment.centerRight,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                  height: 249,
                  child: FutureBuilder(
                      future: MyFutureSimilar(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          //handle snapshot with loading indicator /not found indicator will be no internet connection
                          return CircularProgressIndicator(); //Text("error");
                        } else {
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => ProductCard(
                                    index: index,
                                    product: snapshot.data![index],
                                    user: widget.user,
                                  ));
                        }
                      }),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(width: 390.w,
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [isDiscount?
                    SizedBox(height: 56,
                      child: Column(
                        children: [
                          CustomText(
                            text: "EGP ${widget.product.discount_price}",
                            color: AppTitleColor,
                            fontfamily: "ReadexPro",
                            fontWeight: FontWeight.w400,size: 16.sp,)
                          ,SizedBox(height: 1,),
                          CustomText(
                            text: "EGP ${widget.product.price}",
                            color: TypingColor,
                            fontfamily: "ReadexPro",
                            fontWeight: FontWeight.w400,size: 13.sp,linethrough: true,)
                        ],
                      ),
                    ):CustomText(
                      text: "EGP ${widget.product.price}",
                      color: AppTitleColor,
                      fontfamily: "ReadexPro",
                      fontWeight: FontWeight.w400,size: 22,),SizedBox(width: 4,),Expanded(
                        child: CustomButton(
                        //width: 288,
                        height: 50.h,
                        child: CustomText(
                          text: "Add to Cart",
                          size: 12,
                          color: Colors.white,
                          align: Alignment.center,
                        ),
                        onpress: () async{
                          String res=await Provider.of<FireStoreController>(context,listen: false).addItem(widget.product,widget.user);
                          if(res=="success"){
                            Fluttertoast.showToast(
                                msg:
                                "Item added to Cart",
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                timeInSecForIosWeb: 5);
                            Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => new MainHome(user: widget.user)),
                                (route) => false,);
                          }
                          else{Fluttertoast.showToast(
                              msg:
                              "Item already exist,Check your Cart",
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              timeInSecForIosWeb: 5);}
                        },
                        borderColor: Colors.white,
                        color: primaryColor,
                    ),
                      )],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
