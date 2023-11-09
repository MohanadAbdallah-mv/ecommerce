
class CartItem{
  String? productId;
  int? quantity;
  bool? isExist;
CartItem({this.productId, this.quantity, this.isExist});

CartItem.fromJson(Map<String,dynamic>json){
  productId=json["productId"];
  quantity=json["productId"];
  isExist=json["isExist"];
}
  Map<String,dynamic>toJson()=>{
    "productId":productId,
    "quantity":quantity,
    "isExist":isExist,
  };
}