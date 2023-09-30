import 'package:ecommerece/constants.dart';
import 'package:ecommerece/models/user_model.dart';
import 'package:ecommerece/new_architecture/controller/auth_controller.dart';
import 'package:ecommerece/new_architecture/controller/firestore_controller.dart';
import 'package:ecommerece/views/onBoarding.dart';
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

  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
//var myfuture;

  Future<List<String>> MyFutureCategory() async {
    var myfuture =
        await Provider.of<FireStoreController>(context).getCategory();
//todo : implement either left and put it down to show error if it is left,null loading and right is data
    return myfuture.right;
  }

  Future<List<Product>> MyFutureBestSeller() async {
    var myfuture =
        await Provider.of<FireStoreController>(context).getBestSeller();
//todo : implement either left and put it down to show error if it is left,null loading and right is data

    return myfuture.right;
  }
  Future<List<Product>> MyFutureDontMiss() async {
    var myfuture =
    await Provider.of<FireStoreController>(context).getDontMiss();
//todo : implement either left and put it down to show error if it is left,null loading and right is data

    return myfuture.right;
  }

  @override
  Widget build(BuildContext context) {
    //dynamic user=Provider.of<AuthController>(context).getCurrentUser();
    // print(user);
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Provider.of<AuthController>(context, listen: false)
                  .logout(widget.user);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Intro()),
                  (route) => false);
            },
            child: Icon(
              Icons.arrow_back_outlined,
              color: Colors.black,
            )),
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
      ),bottomNavigationBar: BottomNavigationBar(type:BottomNavigationBarType.fixed,items:[
      BottomNavigationBarItem(icon: Icon(Icons.home),label: "home"),
      BottomNavigationBarItem(icon: Icon(Icons.person),label: "profile")
    ]),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
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
                    future: MyFutureCategory(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        //handle snapshot with loading indicator /not found indicator will be no internet connection
                        return CircularProgressIndicator(); //Text("error");
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => CategoryCard(
                                  index: index,
                                  name: snapshot.data![index],
                                  isSelected:
                                      Provider.of<FireStoreController>(context)
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
                      SizedBox(
                        height: 20,
                      ),
                      CustomText(
                        text: "see more",
                        color: TypingColor,
                        align: Alignment.bottomCenter,
                        size: 15,
                      ),
                    ],
                  )
                ],
              ),
              //Best Seller scroll Listview
              SizedBox(
                height: 240,
                child: FutureBuilder(
                    future: MyFutureBestSeller(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        //handle snapshot with loading indicator /not found indicator will be no internet connection
                        return CircularProgressIndicator(); //Text("error");
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => ProductCard(
                                index: index, product: snapshot.data![index],user: widget.user,));
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
                      ),SvgPicture.asset(
                        "assets/svg/sale.svg",
                        fit: BoxFit.values.last,
                      width:32 ,height: 32,)
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      CustomText(
                        text: "see more",
                        color: TypingColor,
                        align: Alignment.bottomCenter,
                        size: 15,
                      ),
                    ],
                  )
                ],
              ),
              //Best Seller scroll Listview
              SizedBox(
                height: 240,
                child: FutureBuilder(
                    future: MyFutureDontMiss(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        //handle snapshot with loading indicator /not found indicator will be no internet connection
                        return CircularProgressIndicator(); //Text("error");
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => ProductCard(
                                index: index, product: snapshot.data![index],isDiscount: true,user: widget.user,));
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
