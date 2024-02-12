import 'dart:developer';

import 'package:ecommerece/models/cart_item.dart';
import 'package:ecommerece/models/order.dart';
import 'package:ecommerece/models/product.dart';
import 'package:ecommerece/new_architecture/repo/firestore_logic.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:ecommerece/models/cart.dart';
import 'package:ecommerece/models/user_model.dart';
import 'cart_controller.dart';

class FireStoreController extends ChangeNotifier {
  FirestorehandlerImplement firestorehandlerImplement;
  int categorySelectedindex;
  bool isSelected;
  late String categorySelected;
  List<CartItem> cartItems = [];
  List<String> likedListIds = [];
  late CartController _cart;
  List<Product> likedList=[];

  FireStoreController({required this.firestorehandlerImplement,
    this.categorySelectedindex = 0,
    this.isSelected = false, this.categorySelected = ""});


  bool isSelectedtile(index) {
    if (categorySelectedindex == index) {
      isSelected = true;
      notifyListeners();
      return isSelected;
    } else {
      isSelected = false;
      notifyListeners();
      return isSelected;
    }
  }

  Future<String> selectCategory(Future<List<String>> category) async {
    await category.then((value) =>
    categorySelected = value[categorySelectedindex]);
    notifyListeners();
    return categorySelected;
  }

  Future<Either<String, List<String>>> getCategory() async {
    try {
      Either<String, List<String>> res =
      await firestorehandlerImplement.getCategory();
      if (res.isRight) {
        categorySelected = res.right[categorySelectedindex];
        notifyListeners();
        return Right(res.right);
      } else {
        return Left(res.left);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<Product>>> getBestSeller(String category) async {
    try {
      log("entering bestseller in controller");
      Either<String, List<Product>> res =
      await firestorehandlerImplement.getBestSeller(category);
      if (res.isRight) {
        log(res.right.toString());
        return Right(res.right);
      } else {
        return Left(res.left);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<Product>>> getDontMiss(String category) async {
    try {
      Either<String, List<Product>> res =
      await firestorehandlerImplement.getDontMiss(category);
      if (res.isRight) {
        print(res.right);
        return Right(res.right);
      } else {
        return Left(res.left);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<Product>>> getSimilarFrom(String subcategory) async {
    try {
      Either<String, List<Product>> res =
      await firestorehandlerImplement.getSimilarFrom(subcategory);
      if (res.isRight) {
        print(res.right);
        return Right(res.right);
      } else {
        return Left(res.left);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
  Future<Either<String,Product>> getItemById (String id) async {
    //todo : do repo and source handling to get id/ maybe later will make wish list id and cart id which contatins a list of product ids for data integrity
    try{
      Either<String,Product> res = await firestorehandlerImplement.getItemById(id);
      if (res.isRight) {
        print(res.right);
        return Right(res.right);
      } else {
        return Left(res.left);
      }
    }catch(e){
      throw "error at controller getting product ${e.toString()}";
    }
  }

  Future<String> addUser(MyUser user) async {
    try {
      String res = await firestorehandlerImplement.addUser(user);

      return res;
    } catch (e) {
      return e.toString();
    }
  }

  Future<Either<String, MyUser>> getUser(MyUser user) async {
    try {
      Either<String, MyUser> res = await firestorehandlerImplement.getUser(
          user);
      user = res.right;
      log("${user.wishList} at getuser in firestore controller");
      return Right(user);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<void> updateUser(MyUser user) async {
    String res = await firestorehandlerImplement.updateUser(user);
    print(res);
  }

  void initProduct(CartController cartController) {
    _cart = cartController;

    //getItemsList(user);

  }

  Future<String> addItem(Product product, MyUser user) async{
    String res=_cart.addItem(product, user);
    //updateUser(user);
    cartItems = user.cart.items!;

    notifyListeners();
    await updateUser(user);
    updateItemsList(user);
    return res;

//needs to be handled more when to update and when not// make get items list so i can notify and change it and call it with provider
  }
  void deleteItem(Product product,MyUser user,int index){
    _cart.removeItem(product,user,index);
    getUser(user);
    cartItems=user.cart.items!;
    updateUser(user);
    notifyListeners();

  }
  void setQuantity(Product product ,MyUser user,int index,bool increment){
    if(increment==true){
      //user.cart.items!.where((element) => element.product==product).single.quantity!
      if(user.cart.items![index].quantity!<10){
        log("increasing quantity");
        user.cart.items![index].quantity=user.cart.items![index].quantity! +1;
        user.cart.totalPrice=user.cart.totalPrice! +(product.discount_price!=0?product.discount_price:product.price)!.toInt();
        cartItems=user.cart.items!;
      notifyListeners();
      updateUser(user);
      }
    }else{
      if(user.cart.items![index].quantity!>1)
      {
        log("decreasing quantity");
        user.cart.items![index].quantity=user.cart.items![index].quantity! -1;
        user.cart.totalPrice=user.cart.totalPrice! -(product.discount_price!=0?product.discount_price:product.price)!.toInt();
        cartItems=user.cart.items!;
        notifyListeners();
        updateUser(user);}
    }
  }
  void updateItemsList(MyUser user) async {
    //todo cartItems = await _cart.getItemList(user);
    await getItemsList(user).then((value) {
      cartItems = value;

    });
    print("update item list trigger");
    print(cartItems.length);
    print(cartItems);
    notifyListeners();
  }

  Future<List<CartItem>> getItemsList(MyUser user) async {
    Either<String, Cart> cart = await _cart.getCart(user);
    if (cart.isRight) {
      if (cart.right.items != null) {
        cartItems = cart.right.items!;
        log("this is cart items" + cartItems.toString());
        log(cartItems[0].toString());
        notifyListeners();
        return cartItems;
      } else {
        return cartItems;
      }
//needs to be handled more when to update and when not// make get items list so i can notify and change it and call it with provider
    } else {
      return cartItems;
    }
  }
  Future<void> likeItem(Product product,MyUser user)async{

    if(user.wishList.contains(product.id)){
      user.wishList.remove(product.id);
      await updateUser(user);
      await updateWishList();
      notifyListeners();
    }else{
      user.wishList.add(product.id!);
     // likedListIds.add(product.id!);
      await updateUser(user);
      await updateWishList();
      notifyListeners();
    }

  }

  Future<List<Product>> updateWishList() async{
    if(likedListIds.isNotEmpty) {
      likedList =
      await firestorehandlerImplement.getLikedProducts(likedListIds);
      log("get liked products in controller ${likedList}");
      notifyListeners();
      return likedList;
    }else{
      likedList=[];
      return likedList;
    }
  }
  Future<List<Product>>myLikedItems()async{
    List<Product> items=await updateWishList();
    log("message items in liked list");
    notifyListeners();
    return items;
  }
  Future<void> finishPayment(MyOrder order,MyUser user)async{
    try{
      await firestorehandlerImplement.makeOrder(order).then((value) {
        log("$value");
        if(value=="success"){
          _cart.checkOut();
          user.cart.items!.clear();
          user.cart.totalPrice = 0;
          user.orders.add(order.id);
          cartItems.clear();
        };});
      await updateUser(user);

    }catch(e){
      log("error at finishing payment${e.toString()}");
    }
  }
  
}