import 'dart:developer';

import 'package:ecommerece/constants.dart';
import 'package:ecommerece/models/user_model.dart';
import 'package:ecommerece/new_architecture/controller/auth_controller.dart';
import 'package:ecommerece/new_architecture/controller/firestore_controller.dart';
import 'package:ecommerece/views/bottom_navigation.dart';
import 'package:ecommerece/views/forgot_password.dart';
import 'package:ecommerece/views/home.dart';
import 'package:ecommerece/widgets/CustomButton.dart';
import 'package:ecommerece/widgets/CustomText.dart';
import 'package:ecommerece/widgets/CustomTextField.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool isEmailError = false;
  bool isPasswordError = false;
  final FocusNode _passwordnode = FocusNode();

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
//    _passwordnode=FocusNode(canRequestFocus: true);
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (context, auth, child) {
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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 50),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //Svg pic
                          Container(
                            decoration: BoxDecoration(),
                            child: SvgPicture.asset(
                              "assets/svg/st_l_app.svg",
                              fit: BoxFit.values.last,
                            ),
                          ),
                          //Email Text Field
                          Padding(
                            padding: const EdgeInsets.only(top: 56),
                            child: CustomTextField(
                              isError: isEmailError,
                              headerText: "Email",
                              hint: "Malikvis@gmail.com",
                              textEditingController: _email,
                              onEditComplete: () {
                                setState(() {
                                  isEmailError = false;
                                  FocusScope.of(context).requestFocus(
                                      _passwordnode);
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          //Password Text Field
                          CustomTextField(
                            isError: isPasswordError,
                            headerText: "Password",
                            hint: "************",
                            isPassword: true,
                            textEditingController: _password,
                            focusNode: _passwordnode,
                            onEditComplete: () {
                              setState(() {
                                isPasswordError = false;
                                FocusScope.of(context).unfocus();
                              });
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ]),
                  ), Padding(padding: EdgeInsets.only(top: 90),
                    child: GestureDetector(onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>Forgot_Password()));
                    },
                      child: CustomText(text: "forgot password?",
                          underline: true,
                          color: ErrorMesseageText,
                          align: Alignment.center),
                    ),),
                  Padding( //todo: add forget password with it functions/edit error for password field
                    padding: const EdgeInsets.only(
                        top: 30, left: 16, right: 16),
                    child: CustomButton(
                      width: double.maxFinite,
                      child: CustomText(
                        text: "Log in",
                        color: Colors.white,
                        align: Alignment.center,
                        size: 15,
                      ),
                      onpress: () async {
                        String email = _email.text;
                        String password = _password.text;
                        Either<String, dynamic> user =
                        await auth.login(email, password);
                        if (user.isLeft) {
                          log(user.left);

                          if (user.left == "invalid-email") {
                            log("triggered");
                            isEmailError = true;
                          } else {
                            isPasswordError = true;
                          }
                        } else {
                          // need to handle if it didn't return user on right but will leave it for now
                          Either<String,MyUser>res=await Provider.of<FireStoreController>(context,listen: false).getUser(user.right);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MainHome(user: res.right)));
                        }
                      },
                      borderColor: Colors.white,
                      color: primaryColor,
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }
}
