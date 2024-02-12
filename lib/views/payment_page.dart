import 'dart:developer';

import 'package:ecommerece/constants.dart';
import 'package:ecommerece/models/cart.dart';
import 'package:ecommerece/models/order.dart';
import 'package:ecommerece/models/user_model.dart';
import 'package:ecommerece/new_architecture/controller/firestore_controller.dart';
import 'package:ecommerece/views/bottom_navigation.dart';
import 'package:ecommerece/views/map_page.dart';
import 'package:ecommerece/widgets/CustomButton.dart';
import 'package:ecommerece/widgets/CustomText.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ecommerece/Stripe_Payment/payment_manager.dart ';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class paymentPage extends StatefulWidget {
  LatLng? pos;
  MyUser user;

  paymentPage({super.key, required this.user});

  @override
  State<paymentPage> createState() => _paymentPageState();
}

class _paymentPageState extends State<paymentPage> {
  String _address = ""; // create this variable
  Future<void> _getResultFromMapScreen(BuildContext context) async {
    final result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => MapPage(user: widget.user)));
    log("$result");
    widget.pos=result;
    _getPlace(result);
  }

  void _getPlace(LatLng pos) async {
    List<Placemark> newPlace =
    await placemarkFromCoordinates(pos.latitude, pos.longitude);

    // this is all you need
    Placemark placeMark = newPlace[0];
    String name = placeMark.name!;
    String subLocality = placeMark.subLocality!;
    String locality = placeMark.locality!;
    String administrativeArea = placeMark.administrativeArea!;
    String postalCode = placeMark.postalCode!;
    String country = placeMark.country!;
    String address =
        "${name}, ${subLocality}, ${locality}, ${administrativeArea} ${postalCode}, ${country}";

    print(address);

    setState(() {
      _address = address; // update _address
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//_getResultFromMapScreen(context);
  }

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
                      fontSize: 30)),
            ),
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: _address.length < 2
                    ? "please select your location"
                    : _address,
                color: Colors.black,
                align: Alignment.center,
              ),
              SizedBox(height: 20,),
              CustomButton(
                  child: CustomText(
                    text: "SelectLocation",
                    size: 15,
                    color: Colors.white,
                    align: Alignment.center,
                    fontfamily: "ReadexPro",
                    fontWeight: FontWeight.w500,
                  ),
                  height: 50,
                  width: 150,
                  borderColor: Colors.white,
                  borderRadius: 10,
                  color: primaryColor,
                  onpress: () {
                    _getResultFromMapScreen(context);
                  })
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 70,
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            color: Colors.white,
            child: CustomButton(
              child: CustomText(
                text: "Confirm Purchase",
                size: 15,
                color: Colors.white,
                align: Alignment.center,
                fontfamily: "ReadexPro",
                fontWeight: FontWeight.w500,
              ),
              onpress: () async {
                log("cart total price${widget.user.cart.totalPrice
                    .toString()}");
                if(_address.length>2){
                  var res = await PaymentManager.makePayment(
                      widget.user.cart.totalPrice!, 'USD');
                  if (res == "success payment") {
                    //make firebase payment and store data
                    var now = DateTime.now();
                    var formatter = DateFormat('yyyy-MM-dd – hh:mm-aa');
                    String formattedDate = formatter.format(now);
                    Cart ordercart=widget.user.cart;
                    String id="${widget.user.id}+$formattedDate";
                    await Provider.of<FireStoreController>(context,
                            listen: false)
                        .finishPayment(
                            MyOrder(ordercart, widget.user.id,
                                widget.pos!, formattedDate,id),
                            widget.user)
                        .then((value) {
                      Fluttertoast.showToast(
                          msg:
                              "Successful Payment,Your Order Should Be Delivered Soon",
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          timeInSecForIosWeb: 5,toastLength: Toast.LENGTH_LONG);
                      Navigator.pop(context);
                    }); //                      Navigator.of(context,rootNavigator: true).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => MainHome(user: widget.user))));
                  }
                }else{
                  log("toast failed");
                  Fluttertoast.showToast(
                      msg:
                      "Please Select drop off location",
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      timeInSecForIosWeb: 5);
                }
              },
              height: 50,
              borderColor: Colors.white,
              borderRadius: 10,
              color: primaryColor,
            ),
          ),
        ));
  }
}
