import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final Alignment align;
  final TextAlign textalign;
  final  FontWeight fontWeight;
  final String fontfamily;
  const CustomText({super.key,this.text='',this.color=Colors.white,this.size=16,this.align=Alignment.topLeft,this.textalign=TextAlign.center,this.fontWeight=FontWeight.normal,this.fontfamily="ReadxPro"});

  @override
  Widget build(BuildContext context) {
    return Container(alignment:align ,
      child: Text(
        text,
        style: TextStyle(fontSize: size, color: color,fontWeight: fontWeight,fontFamily:"ReadexPro" ),textAlign: textalign,
      ),
    );
  }
}
