import 'package:ecommerece/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBarfor extends StatefulWidget {
  const SearchBarfor({super.key});

  @override
  State<SearchBarfor> createState() => _SearchBarforState();
}

class _SearchBarforState extends State<SearchBarfor> {
  @override
  Widget build(BuildContext context) {

    return TextField(
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Color(0xff130F26),
          ),
          hintText: "Search",
          hintStyle: GoogleFonts.inter(
              textStyle: TextStyle(
                  color: SearchBarColor, fontWeight: FontWeight.w400)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: SearchBarColor),
              borderRadius: BorderRadius.circular(32)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: SearchBarColor),
              borderRadius: BorderRadius.circular(32))),
      cursorColor: Color(0xff130F26),
      onChanged: (value) {
        //todo: implement seacrch algo for keyword entrance
      },
    );
  }
}
// TextField(
// decoration: (InputDecoration(
// enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
// prefixIcon: Icon(Icons.search),
// hintText: "Search")),
// )
