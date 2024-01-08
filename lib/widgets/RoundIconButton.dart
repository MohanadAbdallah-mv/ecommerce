import 'package:ecommerece/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RoundIconButton extends StatelessWidget {
  RoundIconButton({required this.svgPath, this.onPress, this.elevation = 6.0});

  final String svgPath;

  final VoidCallback? onPress;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: SvgPicture.asset(
          svgPath,
          fit: BoxFit.values.last,
          width: 50,
          height: 50,
        ),
        decoration: BoxDecoration(shape: BoxShape.circle, color: primaryColor),
        constraints: BoxConstraints.tightFor(width: 32.0, height: 32.0),
      ),
      onTap: onPress,
    );
  }
}
