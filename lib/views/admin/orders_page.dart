import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerece/constants.dart';
import 'package:ecommerece/models/order.dart';
import 'package:ecommerece/models/user_model.dart';
import 'package:ecommerece/widgets/CustomText.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrdersPage extends StatefulWidget {
  MyUser adminUser;

  OrdersPage({super.key, required this.adminUser});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  Stream<List<DocumentSnapshot<Map<String, dynamic>>>> _orderStream() {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('orders');
    StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
            List<DocumentSnapshot<Map<String, dynamic>>>> transformer =
        StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
            List<DocumentSnapshot<Map<String, dynamic>>>>.fromHandlers(
      handleData: (QuerySnapshot querySnapshot,
          EventSink<List<DocumentSnapshot>> sink) {
        List<DocumentSnapshot> documents = querySnapshot.docs;
        sink.add(documents);
      },
    );

    // Return the stream of data
    return collection.snapshots().transform(transformer);
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
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(right: 10, left: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    children: [
                      CustomText(
                        text: "Orders",
                        color: AppTitleColor,
                        fontWeight: FontWeight.w400,
                        size: 24,
                        underline: true,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: StreamBuilder<List<DocumentSnapshot>>(
                      stream: _orderStream(),
                      builder: (context,
                          AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
                        if (snapshot.hasData) {
                          List<DocumentSnapshot> documents = snapshot.data!;
                          print("entering stream");
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: documents.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              // Access the data in each document
                              Map<String, dynamic> data = documents[index]
                                  .data() as Map<String, dynamic>;
                              // Build UI components based on the data
                              return ListTile(
                                  title: CustomText(text:data["userid"],color: Colors.black),
                                  subtitle: CustomText(text:data["id"] ,color: Colors.black26,textalign: TextAlign.start,),
                              );
                            },
                          );
                        } else {
                          return Text("order has no data ");
                        }
                      }),
                )
              ],
            ),
          ),
        ));
  }
}
