import 'package:ecommerece/constants.dart';
import 'package:ecommerece/widgets/CustomButton.dart';
import 'package:ecommerece/widgets/CustomText.dart';
import 'package:ecommerece/widgets/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(left: 80),
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 50),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(),
                      child: SvgPicture.asset(
                        "assets/svg/st_l_app.svg",
                        fit: BoxFit.values.last,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 56),
                      child: CustomTextField(
                        headerText: "Email",
                        hint: "Malikvis@gmail.com",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextField(headerText: "Password", hint: "************"),
                    SizedBox(
                      height: 15,
                    ),

                  ]
                ),Padding(
                  padding: const EdgeInsets.only(top: 160),
                  child: CustomButton(
                    child: CustomText(
                      text: "Log in",
                      color: Colors.white,
                      align: Alignment.center,
                      size: 15,
                    ),
                    onpress: () {
                    },
                    borderColor: Colors.white,
                    color: primaryColor,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
