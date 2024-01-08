import 'cart_item.dart';

class Cart {
  List<CartItem>? items;
  int? totalPrice;

  Cart(this.items, this.totalPrice);

  Cart.fromJson(Map<String, dynamic> json) {
    //todo : cart item map to json like i did for user mapping in notes
    print(json["items"]);
    items =List<CartItem>.from(json["items"].map((val) => CartItem.fromJson(val)));
    //json["items"].map((val) => CartItem.fromJson(val)).toList() as List<CartItem>?  ;//      CartItem.fromJson(json["items"]) ;
    totalPrice = json["totalPrice"];
  }

  Map<String, dynamic> toJson() {
   var cartitemsmap=items!.map((e)=>e.toJson()).toList();
   print("cartitemsmap");
   print(cartitemsmap);
    return {
      "items": cartitemsmap,
    "totalPrice": totalPrice
  };
  }
  // Map<String, dynamic> toJson() {
  //   return {
  //     "items": items,
  //     "totalPrice": totalPrice
  //   };
  // }
}
