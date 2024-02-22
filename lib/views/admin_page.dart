import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerece/constants.dart';
import 'package:ecommerece/main.dart';
import 'package:ecommerece/models/user_model.dart';
import 'package:ecommerece/new_architecture/controller/auth_controller.dart';
import 'package:ecommerece/new_architecture/controller/firestore_controller.dart';
import 'package:ecommerece/services/NotificationHandler/notification_handler.dart';
import 'package:ecommerece/stripe_payment/stripe_keys.dart';
import 'package:ecommerece/views/admin/orders_page.dart';
import 'package:ecommerece/widgets/CustomButton.dart';
import 'package:ecommerece/widgets/CustomText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatefulWidget {
  MyUser user;

  AdminPage({super.key, required this.user});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Shoppie",
            style: GoogleFonts.sarina(
                textStyle: TextStyle(
                    color: AppTitleColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 34.sp)),
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          height: 600,
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: CustomButton(
                  child: CustomText(
                    text: "Orders",
                    color: primaryColor,
                    fontWeight: FontWeight.w700,
                    align: Alignment.center,
                    size: 20,
                  ),
                  color: Colors.white,
                  borderColor: primaryColor,
                  onpress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                OrdersPage(adminUser: widget.user)));
                  },
                  width: 150,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: CustomButton(
                  child: CustomText(
                    text: "OrderNotifications",
                    color: primaryColor,
                    fontWeight: FontWeight.w700,
                    align: Alignment.center,
                    size: 12,
                  ),
                  color: Colors.white,
                  borderColor: primaryColor,
                  onpress: () async {
                    String token = await Provider.of<FireStoreController>(
                            context,
                            listen: false)
                        .getAdminToken();
                    NotificationHandler.instance.sendPushMessage(token, "test", "test");
                  },
                  width: 150,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: CustomButton(
                  child: CustomText(
                    text: "Sign Out",
                    color: primaryColor,
                    fontWeight: FontWeight.w700,
                    align: Alignment.center,
                    size: 20,
                  ),
                  color: Colors.white,
                  borderColor: primaryColor,
                  onpress: () {
                    Provider.of<AuthController>(context, listen: false)
                        .logout(widget.user);
                    Navigator.of(context, rootNavigator: true)
                        .pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => new MyApp()),
                      (route) => false,
                    );
                  },
                  width: 150,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
