import 'cart_item.dart';

class Cart {
  List<CartItem>? items;
  int? totalPrice;

  Cart(this.items, this.totalPrice);

  Cart.fromJson(Map<String, dynamic> json) {
    //todo : cart item map to json like i did for user mapping in notes
    // final List mapper=jsonDecode(CacheData.getData(key: "notes"));
    // _noteslist=mapper.map((val)=>Note.fromJson(v
    print(json["items"]);
    items =json["items"].map((val)=>CartItem.fromJson(val)).toList();//       CartItem.fromJson(json["items"]) ;
    totalPrice = json["totalPrice"];
  }

  Map<String, dynamic> toJson() {
   var cartitemsmap=items!.map((e)=>e.toJson()).toList();
    return {
      "items": cartitemsmap,
    "totalPrice": totalPrice
  };
  }}
