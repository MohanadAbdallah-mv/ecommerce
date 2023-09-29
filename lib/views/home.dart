import 'package:ecommerece/constants.dart';
import 'package:ecommerece/models/user_model.dart';
import 'package:ecommerece/new_architecture/controller/auth_controller.dart';
import 'package:ecommerece/new_architecture/controller/firestore_controller.dart';
import 'package:ecommerece/views/onBoarding.dart';
import 'package:ecommerece/widgets/Category_card.dart';
import 'package:ecommerece/widgets/CustomButton.dart';
import 'package:ecommerece/widgets/CustomText.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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

  Future<List<String>>MyFuture()async{
    var myfuture= await Provider.of<FireStoreController>(context).getCategory();
    
    return myfuture.right;
}
  @override
  Widget build(BuildContext context) {
    int SelectedCategory = 0;
    //dynamic user=Provider.of<AuthController>(context).getCurrentUser();
    // print(user);
    return Scaffold(
      appBar: AppBar(
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SearchBarfor(),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 40,
                child: FutureBuilder(
                    future:
                        MyFuture(),
                    builder: (context,snapshot) {
                    if(snapshot.data==null){
                      return Text("error");
                    }else{return ListView.builder(
                        itemCount: snapshot.data!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => CategoryCard(
                          index: index,
                          name: snapshot.data![index],isSelected: Provider.of<FireStoreController>(context).categorySelectedindex==index?true:false,
                        ));}
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
                    children: [SizedBox(height:20 ,),
                      CustomText(
                        text: "see more",
                        color: textFieldColor,
                        align: Alignment.bottomCenter,
                        size: 15,
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
