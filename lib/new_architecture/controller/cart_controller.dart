import 'package:ecommerece/models/user_model.dart';
import 'package:ecommerece/new_architecture/repo/cart_repo.dart';
import 'package:flutter/cupertino.dart';

import '../../models/cart_item.dart';
import '../../models/product.dart';

class CartController extends ChangeNotifier {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<String, CartItem> _items = {};

  void addItem(Product product,MyUser user) {
    _items.putIfAbsent(product.id!, () {
      print("adding item to cart"+product.name!);
      return CartItem(productId: product.id, quantity: 1, isExist: true);
    }

    );

    _items.forEach((key, value) {
     if(user.cart.items!.contains(value)){}else{user.cart.items!.add(value) ;}

    });//user.cart.items!. (value)
    print(user.cart);
    print(user.cart.items);

  }
}