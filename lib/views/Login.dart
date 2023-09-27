import 'package:ecommerece/constants.dart';
import 'package:ecommerece/new_architecture/controller/auth_controller.dart';
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
  bool isError=false;
  final FocusNode _passwordnode=FocusNode();
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
                    padding: const EdgeInsets.only(left:20,right:50),
                    child: Column(
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
                            child: CustomTextField(isError: isError,
                              headerText: "Email",
                              hint: "Malikvis@gmail.com",
                              textEditingController: _email,onEditComplete: (){FocusScope.of(context).requestFocus(_passwordnode);},
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextField(isError: isError,
                            headerText: "Password",
                            hint: "************",
                            textEditingController: _password,focusNode: _passwordnode,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ]),
                  ),
                  Padding(//todo: add forget password with it functions/edit error for password field
                    padding: const EdgeInsets.only(top: 160),
                    child: CustomButton(width: 160,
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
                          print(user.left);
                          SnackBar(
                            content: Text(user.left),
                          );
                          isError=true;
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      HomePage(user: user.right)));
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
