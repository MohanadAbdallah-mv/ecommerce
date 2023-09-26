import 'package:ecommerece/constants.dart';
import 'package:ecommerece/models/user_model.dart';
import 'package:ecommerece/views/onBoarding.dart';
import 'package:ecommerece/widgets/CustomButton.dart';
import 'package:ecommerece/widgets/CustomText.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final MyUser user;

  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("hi"),),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomText(
              text: widget.user.email,color: primaryColor,
            ),
            CustomText(
              text: "name"//widget.user.name,
            ),
            // CustomText(
            //   text: widget.user.phonenumber,
            // ),
            CustomText(
              text: widget.user.id,color: primaryColor,
            ),
            CustomText(
              text: "is logged in ${widget.user.isLogged.toString()}",
            ),
            CustomButton(
                child: Text("sign out"),
                onpress: () {
                  //todo : signout
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>Intro()));
                },borderColor: primaryColor,color: Colors.white,),
          ],
        ),
      ),
    );
  }
}
