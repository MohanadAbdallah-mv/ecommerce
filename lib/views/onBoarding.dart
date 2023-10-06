
import 'package:ecommerece/constants.dart';
import 'package:ecommerece/views/Login.dart';
import 'package:ecommerece/views/Signup.dart';
import 'package:ecommerece/widgets/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:ecommerece/widgets/CustomText.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "Shoppie",
          style: GoogleFonts.sarina(
              textStyle:
                  TextStyle(color: AppTitleColor, fontWeight: FontWeight.w400)),
        )),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(scrollDirection: Axis.vertical,
        child: Container(height: 755,
          child: Stack(children: [
            Positioned(
              top: 250,
              right: 0,
              left: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 130),
                    CustomText(
                      text: "Welcome!",
                      color: Colors.white,
                      size: 34,
                      align: Alignment.center,
                      fontWeight: FontWeight.bold,
                      fontfamily: "ReadexPro-Bold",
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: CustomText(
                        text:
                            "Where online shopping is much easier all you need in one place",
                        size: 19,
                        color: Colors.white,
                        align: Alignment.center,
                      ),
                    ),
                    SizedBox(height: 110),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: CustomButton(
                        child: CustomText(
                          text: "Log in",
                          color: primaryColor,
                          align: Alignment.center,
                          size: 15,
                        ),
                        onpress: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        borderColor: Colors.white,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 12),
                    CustomText(
                      text: "or",
                      color: Colors.white,
                      align: Alignment.center,
                      size: 16,
                    ),
                    SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: CustomButton(
                        child: CustomText(
                          text: "Sign Up",
                          color: Colors.white,
                          align: Alignment.center,
                          fontWeight: FontWeight.bold,
                          size: 15,
                        ),
                        onpress: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Signup()));
                        },
                        borderColor: Colors.white,
                        color: primaryColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 77,
              child: Container(
                child: SvgPicture.asset("assets/svg/st_l_app.svg"),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
