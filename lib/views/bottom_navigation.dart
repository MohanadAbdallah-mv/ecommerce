import 'package:ecommerece/models/user_model.dart';
import 'package:ecommerece/views/home.dart';
import 'package:ecommerece/views/onBoarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:global_bottom_navigation_bar/global_bottom_navigation_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import '../models/bottom_navigation_item.dart';

class MainHome extends StatefulWidget {
  MainHome({super.key, required this.user});

  MyUser user;

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> with TickerProviderStateMixin {
  @override
  int index = 2;

  @override
  Widget build(BuildContext context) {
    return ScaffoldGlobalBottomNavigation(primary: true,listOfChild: [
      Intro(),
      Intro(),
      HomePage(user: widget.user),
      Intro(),
      Intro()
    ], listOfBottomNavigationItem: buildBottomNavigationItemList());
  }
  List<BottomNavigationItem> buildBottomNavigationItemList() => [
    BottomNavigationItem(
      activeIcon: SvgPicture.asset("assets/svg/bottom_navigation_bar/User.svg"),
      inActiveIcon: SvgPicture.asset("assets/svg/bottom_navigation_bar/User.svg"),
      title: 'Profile',
      color: Colors.white,
      vSync: this,
    ),BottomNavigationItem(
      activeIcon: SvgPicture.asset("assets/svg/bottom_navigation_bar/Category.svg"),
      inActiveIcon: SvgPicture.asset("assets/svg/bottom_navigation_bar/Category.svg"),
      title: 'Category',
      color: Colors.white,
      vSync: this,
    ),BottomNavigationItem(
      activeIcon: SvgPicture.asset("assets/svg/bottom_navigation_bar/Home.svg"),
      inActiveIcon: SvgPicture.asset("assets/svg/bottom_navigation_bar/Home.svg"),
      title: 'Home',
      color: Colors.white,
      vSync: this,
    ),BottomNavigationItem(
      activeIcon: SvgPicture.asset("assets/svg/bottom_navigation_bar/Union.svg"),
      inActiveIcon: SvgPicture.asset("assets/svg/bottom_navigation_bar/Union.svg"),
      title: 'WishList',
      color: Colors.white,
      vSync: this,
    ),BottomNavigationItem(
      activeIcon: SvgPicture.asset("assets/svg/bottom_navigation_bar/Cart.svg"),
      inActiveIcon: SvgPicture.asset("assets/svg/bottom_navigation_bar/Cart.svg"),
      title: 'Cart',
      color: Colors.white,
      vSync: this,
    )
  ];

}
