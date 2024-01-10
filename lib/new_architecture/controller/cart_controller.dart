import 'package:ecommerece/models/user_model.dart';
import 'package:ecommerece/new_architecture/repo/cart_repo.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';

import '../../models/cart.dart';
import '../../models/cart_item.dart';
import '../../models/product.dart';
import 'dart:developer';

class CartController extends ChangeNotifier {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<String, CartItem> _items = {};
  late Cart _cart;

  Future<Either<String,Cart>> getCart(MyUser user) async {
   try {
     Either<String, Cart> res = await cartRepo.getCart(user);
     if (res.isRight) {
       log('cart is returning');
      // log(res.right.items![0].product!.id.toString());
       _cart= res.right;
       _cart.items!.forEach((element) {_items.putIfAbsent(element.product!.id!, () =>
           CartItem(product: element.product, quantity: element.quantity, isExist: true));});
       notifyListeners();
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

 void addItem(Product product, MyUser user) {
    _items.putIfAbsent(product.id!, () {
      print("adding item to cart" + product.name!);
      if(product.discount_price! >0){
        user.cart.totalPrice =user.cart.totalPrice! + product.discount_price! ;
      }else{
        user.cart.totalPrice =user.cart.totalPrice! + product.price!  ;
      }
      return CartItem(product: product, quantity: 1, isExist: true);
    });

    _items.forEach((key, value) {
      if (user.cart.items!.contains(value)) {
        log(value.toString() + "alread exists");
      } else {
        user.cart.items!.add(value);
      }
    }); //user.cart.items!. (value)

    print(user.cart);
    print(user.cart.items);
    notifyListeners();
  }

  void removeItem(Product product, MyUser user,int index) {
    _items.removeWhere((key, value) {
      if(key==product.id){
        log("removing item /////////////////////////////////////////////////////// ${value.product!.name}");
        if(value.product!.discount_price! >0){
          user.cart.totalPrice=user.cart.totalPrice! - (user.cart.items![index].quantity! * value.product!.discount_price!);
        }else{
          user.cart.totalPrice=user.cart.totalPrice! - (user.cart.items![index].quantity!* value.product!.price! );
        }
        user.cart.items!.remove(value);
        notifyListeners();
        return true;
      }
      return false;
    });
    print(user.cart);
    print(user.cart.items);
    notifyListeners();
  }

  void checkOut(Product product, MyUser user) {
    _items.putIfAbsent(product.id!, () {
      print("adding item to cart" + product.name!);
      return CartItem(product: product, quantity: 1, isExist: true);

    });

    _items.forEach((key, value) {
      if (user.cart.items!.contains(value)) {
        log(value.toString() + "alread exists");
      } else {
        user.cart.items!.add(value);
      }
    }); //user.cart.items!. (value)
    print(user.cart);
    print(user.cart.items);
    notifyListeners();
  }


}
