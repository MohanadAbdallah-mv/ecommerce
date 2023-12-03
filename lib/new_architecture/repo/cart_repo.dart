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
      return Right(cart.right);
    } else {
      print("cart error at repo"+cart.left);
      return Left(cart.left);
    }
  }
}
