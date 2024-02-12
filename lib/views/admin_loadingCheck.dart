import 'dart:developer';

import 'package:ecommerece/models/user_model.dart';
import 'package:ecommerece/views/admin_page.dart';
import 'package:ecommerece/views/bottom_navigation.dart';
import 'package:flutter/material.dart';
class AdminCheckPage extends StatefulWidget {
  MyUser user;
  AdminCheckPage({super.key,required this.user});

  @override
  State<AdminCheckPage> createState() => _AdminCheckPageState();
}

class _AdminCheckPageState extends State<AdminCheckPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((value) {
      log("${widget.user.role}");
      if(widget.user.role=="admin"){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute<dynamic>(builder: (context)=>AdminPage(user: widget.user)),(route) =>false);
      }else{
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MainHome(user: widget.user)),(route) =>false);
      }
    });


  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(appBar: AppBar(),body: CircularProgressIndicator());
  }
}
