import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class payment_Page extends StatefulWidget {
  LatLng pos;
  payment_Page({super.key,required this.pos});

  @override
  State<payment_Page> createState() => _payment_PageState();
}

class _payment_PageState extends State<payment_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(widget.pos.latitude.toStringAsFixed(4)+" and "+widget.pos.longitude.toStringAsFixed(4)),),);
  }
}
