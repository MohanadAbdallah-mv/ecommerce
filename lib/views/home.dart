import 'dart:developer';

import 'package:ecommerece/constants.dart';
import 'package:ecommerece/main.dart';
import 'package:ecommerece/models/bottom_navigation_item.dart';
import 'package:ecommerece/models/user_model.dart';
import 'package:ecommerece/new_architecture/controller/auth_controller.dart';
import 'package:ecommerece/new_architecture/controller/firestore_controller.dart';
import 'package:ecommerece/views/onBoarding.dart';
import 'package:ecommerece/views/product_list.dart';
import 'package:ecommerece/widgets/Category_card.dart';
import 'package:ecommerece/widgets/CustomText.dart';
import 'package:ecommerece/widgets/Product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../widgets/SearchBar.dart';

class HomePage extends StatefulWidget {
  final MyUser user;

  HomePage({
    super.key,
    required this.user,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
//var myfuture;
  late Future<List<String>> categroyList;
  late String category;
  late int categoryindex;

  Future<List<String>> MyFutureCategory() async {
    var myfuture =
        await Provider.of<FireStoreController>(context, listen: false)
            .getCategory();
//todo : implement either left and put it down to show error if it is left,null loading and right is data
    return myfuture.right;
  }

  Future<List<Product>?> MyFutureBestSeller(String category) async {
    log("entering myfuture best seller");
    // String category=await Provider.of<FireStoreController>(context).categorySelected;
    //log(category.toString());
    log("entering best seller from view");
    var myfuture =
        await Provider.of<FireStoreController>(context, listen: false)
            .getBestSeller(category);

//todo : implement either left and put it down to show error if it is left,null loading and right is data

    return myfuture.right;
  }

  Future<List<Product>> MyFutureDontMiss(String category) async {
    log('fuck');
    var myfuture =
        await Provider.of<FireStoreController>(context, listen: false)
            .getDontMiss(category);
//todo : implement either left and put it down to show error if it is left,null loading and right is data

    return myfuture.right;
  }

  @override
  void initState() {
    categroyList = MyFutureCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //dynamic user=Provider.of<AuthController>(context).getCurrentUser();
    // print(user);
    //widget.bestseller=MyFutureBestSeller();
    categoryindex =
        Provider.of<FireStoreController>(context).categorySelectedindex;
    category = Provider.of<FireStoreController>(context).categorySelected;
    print(categoryindex);
    print(widget.user);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true
        ,
        // leading: GestureDetector(
        //     onTap: () {
        //       Provider.of<AuthController>(context, listen: false)
        //           .logout(widget.user);
        //       Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        //         MaterialPageRoute(builder: (context) => new MyApp()),
        //             (route) => false,);
        //     },
        //     child: Icon(
        //       Icons.arrow_back_outlined,
        //       color: Colors.black,
        //     )),
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
      // bottomNavigationBar: BottomNavigationBar(
      //     currentIndex: index,
      //     type: BottomNavigationBarType.fixed,
      //     items: MenuItemList.map((MenuItem menuItem) =>
      //         BottomNavigationBarItem(
      //             icon: Icon(menuItem.iconData),
      //             label: menuItem.label,
      //             backgroundColor: primaryColor)).toList()),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SearchBarfor(),
              SizedBox(
                height: 16,
              ),
              //Category scroll Listview
              SizedBox(
                height: 40,
                child: FutureBuilder(
                    future: categroyList,
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        print(snapshot.connectionState);
                        //handle snapshot with loading indicator /not found indicator will be no internet connection
                        return CircularProgressIndicator(); //Text("error");
                      } else {
                        print(snapshot.connectionState);
                        //widget.bestseller=MyFutureBestSeller();
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => CategoryCard(
                                  index: index,
                                  name: snapshot.data![index],
                                  category: categroyList,
                                  isSelected: Provider.of<FireStoreController>(
                                                  context,
                                                  listen: false)
                                              .categorySelectedindex ==
                                          index
                                      ? true
                                      : false,
                                ));
                      }
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "BestSeller",
                    color: AppTitleColor,
                    fontWeight: FontWeight.w700,
                    size: 28,
                  ),
                  Column(
                    children: [
                      Container(
                        height: 56,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductList(
                                          user: widget.user,
                                          title: "BestSeller",
                                          category: category,
                                        )));
                          },
                          child: CustomText(
                            text: "see more",
                            color: TypingColor,
                            align: Alignment.center,
                            size: 15,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              //Best Seller scroll Listview
              SizedBox(
                height: 265,
                child: FutureBuilder(
                    future: MyFutureBestSeller(category),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        //handle snapshot with loading indicator /not found indicator will be no internet connection
                        return CircularProgressIndicator(); //Text("error");
                      } else if (snapshot.hasError == true) {
                        log(snapshot.error.toString());
                        return Text(snapshot.error.toString());
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

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CustomText(
                        text: "Do not miss",
                        color: AppTitleColor,
                        fontWeight: FontWeight.w700,
                        size: 28,
                      ),
                      SvgPicture.asset(
                        "assets/svg/sale.svg",
                        fit: BoxFit.values.last,
                        width: 32,
                        height: 32,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 56,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductList(
                                          user: widget.user,
                                          title: "DontMiss",
                                          category: category,
                                        )));
                          },
                          child: CustomText(
                            text: "see more",
                            color: TypingColor,
                            align: Alignment.center,
                            size: 15,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              //Best Seller scroll Listview
              SizedBox(
                height: 265,
                child: FutureBuilder(
                    future: MyFutureDontMiss(category),
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
                                  isDiscount: true,
                                  user: widget.user,
                                ));
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
