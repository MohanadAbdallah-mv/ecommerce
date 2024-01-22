import 'cart.dart';

class MyUser {
  late String id;
  late String? name;
  late String email;
  late String? phonenumber;
  late bool isLogged;
  late List<String> wishList;
  late Cart cart;
  late List<Cart>? orders;

  MyUser(
      {required this.id,
      required this.name,
      required this.email,
      required this.phonenumber,
      required this.isLogged,
      required this.cart,
      required this.wishList,
      this.orders});

  MyUser.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
    phonenumber = json["phonenumber"];
    isLogged = json["isLogged"];
    cart = Cart.fromJson(json["cart"]);
    wishList = List<String>.from(json["wishList"]) ;
    orders = json["orders"];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phonenumber": phonenumber,
        "isLogged": isLogged,
        "cart": cart.toJson(),
        "wishList": wishList,
        "orders": orders
      };
}
