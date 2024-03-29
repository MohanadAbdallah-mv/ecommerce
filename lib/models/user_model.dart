import 'package:ecommerece/models/order.dart';

import 'cart.dart';

class MyUser {
  late String id;
  late String? name;
  late String email;
  late String? phonenumber;
  late bool isLogged;
  late List<String> wishList;
  late Cart cart;
  late List<String> orders;
  String role="user";

  MyUser(
      {required this.id,
      required this.name,
      required this.email,
      required this.phonenumber,
      required this.isLogged,
      required this.cart,
      required this.wishList,
      required this.orders,
      required this.role});

  MyUser.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
    phonenumber = json["phonenumber"];
    isLogged = json["isLogged"];
    cart = Cart.fromJson(json["cart"]);
    wishList = List<String>.from(json["wishList"]) ;
    orders = List<String>.from(json["orders"]);//List<MyOrder>.from(json["orders"].map((val)=>MyOrder.fromJson(val)));//   Order.fromJson();
    role =json["role"];

  }

  Map<String, dynamic> toJson() {
    //var ordersMap=orders!.map((e)=>e.toJson()).toList();
    return{
        "id": id,
        "name": name,
        "email": email,
        "phonenumber": phonenumber,
        "isLogged": isLogged,
        "cart": cart.toJson(),
        "wishList": wishList,
        "orders": orders,
        "role":role
      };}
}
