import 'cart_item.dart';

class Cart {
  List<CartItem>? items;
  int? totalPrice;

  Cart(this.items, this.totalPrice);

  Cart.fromJson(Map<String, dynamic> json) {
    //todo : cart item map to json like i did for user mapping in notes
    items =json["items"];//CartItem.fromJson(json["items"]) ;
    totalPrice = json["totalPrice"];
  }

  Map<String, dynamic> toJson() => {"items": items, "totalPrice": totalPrice};
}
