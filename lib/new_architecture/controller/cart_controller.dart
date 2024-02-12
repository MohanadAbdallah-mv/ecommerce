import 'dart:developer';

import 'package:ecommerece/new_architecture/repo/cart_repo.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';

import 'package:ecommerece/models/cart_item.dart';
import 'package:ecommerece/models/product.dart';
import 'package:ecommerece/models/user_model.dart';
import 'package:ecommerece/models/cart.dart';
class CartController extends ChangeNotifier {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<String, CartItem> _items = {};
  late Cart _cart;

  Future<Either<String,Cart>> getCart(MyUser user) async {
   try {
     Either<String, Cart> res = await cartRepo.getCart(user);
     if (res.isRight) {
       _items={};
       log('cart is returning');
      // log(res.right.items![0].product!.id.toString());
       _cart= res.right;
       _cart.items!.forEach((element) {
       _items.addAll({element.product!.id!:CartItem(product: element.product, quantity: element.quantity, isExist: true)});
       });
      log("hello");
      log(_items.values.toString());
      // log(" should be added from cart . . items${_items[0]!.product}");
       //notifyListeners();
       return Right(res.right);
     } else {
       log("cart controller cart error");
       return Left(res.left);
     }
   } catch (e) {
     log("error at cart controller"+e.toString());
     return Left(e.toString());
   }
 }

 String addItem(Product product, MyUser user) {
   if(_items.containsKey(product.id!)) {
     return "failed";
    }else{
     _items.putIfAbsent(product.id!, () {
       log("adding item to cart" + product.name!);
       if (product.discount_price! > 0) {
         user.cart.totalPrice =
             user.cart.totalPrice! + product.discount_price!;
         user.cart.items!
             .add(CartItem(product: product, quantity: 1, isExist: true));
       } else {
         user.cart.totalPrice = user.cart.totalPrice! + product.price!;
         user.cart.items!
             .add(CartItem(product: product, quantity: 1, isExist: true));
       }
       return CartItem(product: product, quantity: 1, isExist: true);
     });
     notifyListeners();
     return "success";}
  }

  void removeItem(Product product, MyUser user,int index) {
    if(_items.containsKey(product.id)){
      _items.removeWhere((key, value) {
        if (key == product.id) {
          if (value.product!.discount_price! > 0) {
            user.cart.totalPrice = user.cart.totalPrice! - (user.cart.items![index].quantity! * value.product!.discount_price!);
          } else {
            user.cart.totalPrice = user.cart.totalPrice! - (user.cart.items![index].quantity! * value.product!.price!);
          }
          user.cart.items!.removeWhere((element) { if(element.product!.id==key){return true;}else{return false;}});
          notifyListeners();
          return true;
        }
        print("couldn't delete item $index");
        return false;
      });
    }else{print("id doesn't exist///////////////////////");}
    print(user.cart);
    print(user.cart.items);
    notifyListeners();
  }

  void checkOut() {
    _items.clear();
    _cart.items!.clear();
    _cart.totalPrice = 0;
    notifyListeners();
  }


}
