import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerece/models/cart.dart';
import 'package:ecommerece/models/cart_item.dart';
import 'package:either_dart/either.dart';

import '../../models/user_model.dart';

abstract class CartStore {
  FirebaseFirestore firebaseFirestore;

  CartStore({required this.firebaseFirestore});

  Future<Either<String, Cart>> getCart(MyUser user);
}

class CartSource extends CartStore {
  CartSource({required super.firebaseFirestore});

  @override
  Future<Either<String, Cart>> getCart(MyUser user) async {
    try {
      final userref = firebaseFirestore.collection("users").withConverter(
          fromFirestore: (snapshot, _) => MyUser.fromJson(snapshot.data()!),
          toFirestore: (myuser,_)=>myuser.toJson());
      user= await userref.doc(user.id).get().then((value) => value.data()!);
      print(user.cart.toString());
      return Right(user.cart);
    } on FirebaseException catch (e) {
      print("cart source error"+e.message.toString());
      return Left(e.message.toString());
    }
  }
}
