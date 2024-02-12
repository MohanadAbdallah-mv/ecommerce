import 'package:ecommerece/models/cart.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyOrder {
  late Cart cart;
  late String userId;
  late LatLng pos;
  late String dateTime;
  late String id;

  MyOrder(this.cart, this.userId, this.pos, this.dateTime,this.id);

  MyOrder.fromJson(Map<String, dynamic> json) {
    cart = Cart.fromJson(json["cart"]);
    userId = json["userid"] as String;
    pos = LatLng.fromJson(json["pos"]) as LatLng;
    dateTime = json["datetime"] as String;
    id= json["id"];
  }

  Map<String, dynamic> toJson() {
    return {
      "cart": cart.toJson(),
      "userid": userId,
      "pos": pos.toJson(),
      "datetime": dateTime,
      "id": id
    };
  }
}
