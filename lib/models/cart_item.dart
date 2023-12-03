
import 'package:ecommerece/models/product.dart';

class CartItem{
  Product? product;
  int? quantity;
  bool? isExist;
CartItem({this.product, this.quantity, this.isExist});

CartItem.fromJson(Map<String,dynamic>json){
  product= Product.fromJson(json["product"]) ;
  quantity=json["quantity"];
  isExist=json["isExist"];
}
  Map<String,dynamic>toJson()=>{
    "product":product!.toJson(),
    "quantity":quantity,
    "isExist":isExist,
  };
}