import 'dart:developer';
import 'package:ecommerece/new_architecture/controller/firestore_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class CategoryCard extends StatefulWidget {
  int index;
  String name;
  bool isSelected;
  Future<List<String>> category;
  CategoryCard(
      {super.key, required this.index, required this.name, this.isSelected = false,required this.category});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {

  @override
  Widget build(BuildContext context) {

    return Consumer<FireStoreController>(builder: (context,fire,child){
      // if(fire.categorySelectedindex==widget.index){
      //  // fire.categorySelectedindex
      //   log('here');
      //   widget.isSelected=true;
      // }else{widget.isSelected=false;}
      return GestureDetector(
        onTap: () {
          //todo :update the whole page content based on this selected category
          setState(() {
            log('pressed');
            fire.categorySelectedindex=widget.index;
            widget.isSelected=fire.isSelectedtile(widget.index);
            widget.category.then((value) => fire.categorySelected=value[widget.index]);
            //widget.isSelected=!widget.isSelected;
          });
          print(widget.index);
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Container(
              height: 20,
              width: 108,
              child: Center(
                  child: Text(
                    widget.name,
                    style: TextStyle(
                        fontFamily: "Readex",
                        fontWeight: FontWeight.w400, color: widget.isSelected?Colors.white:primaryColor),
                  )),
              decoration: BoxDecoration(
                  color: widget.isSelected?primaryColor:Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: widget.isSelected ?Colors.white:primaryColor))),
        ),
      );
    },

    );
  }
}
