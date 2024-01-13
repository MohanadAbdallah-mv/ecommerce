import 'dart:convert';
import 'dart:developer';

import 'package:ecommerece/models/cart.dart';
import 'package:ecommerece/models/cart_item.dart';
import 'package:ecommerece/models/user_model.dart';
import 'package:either_dart/either.dart';

import '../../services/Cache_Helper.dart';
import '../datasource/cart_data.dart';

abstract class CartRepoHandler {
  CacheData cacheData;
  CartStore cartStore;

  CartRepoHandler({required this.cacheData, required this.cartStore});

  Future<Either<String, Cart>> getCart(MyUser user);
}

class CartRepo extends CartRepoHandler {
  CartRepo({required super.cacheData, required super.cartStore});

//need cashe instance here, cashe should check cart if its not equal then update based on it

  @override
  Future<Either<String, Cart>> getCart(MyUser user) async {
    Either<String, Cart> cart = await cartStore.getCart(user);
    if (cart.isRight) {
      //Cart cartdecoded=Cart.fromJson(cart.right);
      CacheData.setData(key: "cart", value: jsonEncode(user.cart.toJson()));
      log("cart repo , cart right is : ${cart.right}");
      return Right(cart.right);
    } else {
      log("cart error at repo"+cart.left);
      return Left(cart.left);
    }
  }
}
