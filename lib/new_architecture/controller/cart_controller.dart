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
       print(res.right);
       _cart= res.right;
       return Right(res.right);
     } else {
       print("cart controller cart error");
       return Left(res.left);
     }
   } catch (e) {
     print("error at cart controller"+e.toString());
     return Left(e.toString());
   }
 }
  void addItem(Product product, MyUser user) {
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

  void removeItem(Product product, MyUser user) {
    _items.removeWhere((key, value) {
      value.product == product;
      user.cart.items!.remove(value);
      return true;
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
