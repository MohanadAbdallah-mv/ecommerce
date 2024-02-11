
import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerece/models/order.dart';
import 'package:ecommerece/models/product.dart';
import 'package:ecommerece/new_architecture/datasource/firestore_data.dart';
import 'package:either_dart/either.dart';

import 'package:ecommerece/models/user_model.dart';
import '../../services/Cache_Helper.dart';

abstract class Firestorehandler {
  FirestoreImplement firestoreImplement;
  CacheData cacheData;
  Firestorehandler({required this.firestoreImplement,required this.cacheData});

  Future<Either<String,List>> getCategory();
  Future<Either<String,List>> getBestSeller(String category);
  Future<Either<String,List>> getDontMiss(String category);
  Future<Either<String,List>> getSimilarFrom(String subcategory);
  Future<String> addUser(MyUser user);
  Future<String> makeOrder(MyOrder order);
  Future<Either<String,MyUser>> getUser(MyUser user);
  Future<Either<String,Product>> getItemById(String id);
  Future<List<Product>> getLikedProducts(List<String> productIds);
  Future<String> updateUser(MyUser user);

}

class FirestorehandlerImplement extends Firestorehandler {
  FirestorehandlerImplement({required super.firestoreImplement,required super.cacheData});

  @override
  Future<Either<String,List<String>>> getCategory() async {
    try {
      List<String> categoryList = [];
      Either<String, QuerySnapshot>categories = await firestoreImplement
          .getCategories();
      if (categories.isRight) {
        categories.right.docs.forEach((element) {
          categoryList.add(element.get("name"));
        });
       // log("should be done-firestorelogic");
        return Right(categoryList);
        //Future<QuerySnapshot<Map<String,dynamic>>> categories=categories.right.get();
      }else{
      //  log("wtf");
        return Left(categories.left);}
    } on FirebaseException catch (e) {
      log("logic_error");
      return Left(e.toString());
    }
  }
  @override
  Future<Either<String, List<Product>>> getBestSeller(String category) async{
    try {
      // List<Product>products=[];
      //log('entering best seller in logic');
      Either<String, QuerySnapshot<Map<String,dynamic>>>bestSeller = await firestoreImplement
          .getBestSeller(category);
      if (bestSeller.isRight) {
       // log("entering");
          List<QueryDocumentSnapshot<Map<String,dynamic>>> bestref=bestSeller.right.docs;
         final products =bestref.map((e) => Product.fromSnapshot(e)).toList();
       // log("should be done and we have best seller now-firestorelogic");
        return Right(products);
      }else{
       // log("wtf");
        return Left(bestSeller.left);}
    } on FirebaseException catch (e) {
      log("logic_error");
      return Left(e.toString());
    }
  }
  @override
  Future<Either<String, List<Product>>> getDontMiss(String category) async{
    try {
      List<Product>products=[];
      Either<String, QuerySnapshot<Map<String,dynamic>>>dontMiss = await firestoreImplement.getDontMiss(category);
      if (dontMiss.isRight) {
       // log("entering");
        try{

          List<QueryDocumentSnapshot<Map<String, dynamic>>> dontMissref =
              dontMiss.right.docs;
          //print(bestref.forEach((element) {element.get()}));
          final products =
              dontMissref.map((e) => Product.fromSnapshot(e)).toList();
          return Right(products);
        }catch(e){log(e.toString());}
        //bestSeller.right.docs.
        //log("should be done and we have Dont Miss now-firestorelogic");
       // log(products.length.toString());
        //log(products.toString());
        return Right(products);
        //Future<QuerySnapshot<Map<String,dynamic>>> categories=categories.right.get();
      }else{
      //  log("wtf");
        return Left(dontMiss.left);}
    } on FirebaseException catch (e) {
      log("logic_error");
      return Left(e.toString());
    }
  }
  @override
  Future<Either<String, List<Product>>> getSimilarFrom(String subcategory) async{
    try {
      List<Product>products=[];
      Either<String, QuerySnapshot<Map<String,dynamic>>>similarFrom = await firestoreImplement.getSimilarFrom(subcategory);
      if (similarFrom.isRight) {
       // log("entering");
        try{

          List<QueryDocumentSnapshot<Map<String, dynamic>>> similarFromRef =
              similarFrom.right.docs;
          //print(bestref.forEach((element) {element.get()}));
          final products =
          similarFromRef.map((e) => Product.fromSnapshot(e)).toList();
          return Right(products);
        }catch(e){log(e.toString());}
        //bestSeller.right.docs.
       // log("should be done and we have Dont Miss now-firestorelogic");
        //log(products.length.toString());
        //log(products.toString());
        return Right(products);
        //Future<QuerySnapshot<Map<String,dynamic>>> categories=categories.right.get();
      }else{
       // log("wtf");
        return Left(similarFrom.left);}
    } on FirebaseException catch (e) {
      log("logic_error");
      return Left(e.toString());
    }
  }
  @override
  Future<String> addUser(MyUser user) async{
      try{
        String res=await firestoreImplement.addUser(user);
        return res;
      }catch (e){
        return e.toString();
      }
  }
  @override
  Future<Either<String,MyUser>> getUser(MyUser user) async{
    try{
      Either<String, MyUser> res=await firestoreImplement.getUser(user);
      if(res.isRight){
        CacheData.setData(key: "user", value: jsonEncode(user.toJson()));
        CacheData.setData(key: "cart", value: jsonEncode(user.cart.toJson()));
        return Right(res.right);
      }else{return Left(res.left);}
    }catch (e){
      return Left(e.toString());
    }
  }
  @override
  Future<Either<String, Product>> getItemById(String id) async{
    try{
      Either<String, Product> res=await firestoreImplement.getItemById(id);
      if(res.isRight){
        return Right(res.right);
      }else{return Left(res.left);}
    }catch (e){
      return Left(e.toString());
    }
  }
  @override
  Future<List<Product>> getLikedProducts(List<String> productIds) async{
    return await firestoreImplement.getLikedProducts(productIds);
  }
  @override
  Future<String> makeOrder(MyOrder order) async{
    try{
      String res=await firestoreImplement.makeOrder(order);
      return res;
    }catch (e){
      return e.toString();
    }
  }
  @override
  Future<String> updateUser(MyUser user) async{
    try{
      String res=await firestoreImplement.updateUser(user);
     // log(res+"from logic");

      return res;
    }catch (e){
      log(e.toString()+"from logic error");
      return e.toString();
    }
  }
}