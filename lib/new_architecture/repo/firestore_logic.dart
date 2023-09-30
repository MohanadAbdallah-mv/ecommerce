
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerece/models/product.dart';
import 'package:ecommerece/new_architecture/datasource/firestore_data.dart';
import 'package:either_dart/either.dart';

abstract class Firestorehandler {
  FirestoreImplement firestoreImplement;

  Firestorehandler({required this.firestoreImplement});

  Future<Either<String,List>> getCategory();
  Future<Either<String,List>> getBestSeller();
  Future<Either<String,List>> getDontMiss();
  Future<Either<String,List>> getSimilarFrom(String subcategory);

}

class FirestorehandlerImplement extends Firestorehandler {
  FirestorehandlerImplement({required super.firestoreImplement});

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
        log("should be done-firestorelogic");
        return Right(categoryList);
        //Future<QuerySnapshot<Map<String,dynamic>>> categories=categories.right.get();
      }else{
        log("wtf");
        return Left(categories.left);}
    } on FirebaseException catch (e) {
      log("logic_error");
      return Left(e.toString());
    }
  }
  @override
  Future<Either<String, List<Product>>> getBestSeller() async{
    try {
      // List<Product>products=[];
      Either<String, QuerySnapshot<Map<String,dynamic>>>bestSeller = await firestoreImplement
          .getBestSeller();
      if (bestSeller.isRight) {
        log("entering");
          List<QueryDocumentSnapshot<Map<String,dynamic>>> bestref=bestSeller.right.docs;
         final products =bestref.map((e) => Product.fromSnapshot(e)).toList();
        log("should be done and we have best seller now-firestorelogic");
        return Right(products);
      }else{
        log("wtf");
        return Left(bestSeller.left);}
    } on FirebaseException catch (e) {
      log("logic_error");
      return Left(e.toString());
    }
  }
  @override
  Future<Either<String, List<Product>>> getDontMiss() async{
    try {
      List<Product>products=[];
      Either<String, QuerySnapshot<Map<String,dynamic>>>dontMiss = await firestoreImplement.getDontMiss();
      if (dontMiss.isRight) {
        log("entering");
        try{

          List<QueryDocumentSnapshot<Map<String, dynamic>>> dontMissref =
              dontMiss.right.docs;
          //print(bestref.forEach((element) {element.get()}));
          final products =
              dontMissref.map((e) => Product.fromSnapshot(e)).toList();
          return Right(products);
        }catch(e){log(e.toString());}
        //bestSeller.right.docs.
        log("should be done and we have Dont Miss now-firestorelogic");
        log(products.length.toString());
        log(products.toString());
        return Right(products);
        //Future<QuerySnapshot<Map<String,dynamic>>> categories=categories.right.get();
      }else{
        log("wtf");
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
        log("entering");
        try{

          List<QueryDocumentSnapshot<Map<String, dynamic>>> similarFromRef =
              similarFrom.right.docs;
          //print(bestref.forEach((element) {element.get()}));
          final products =
          similarFromRef.map((e) => Product.fromSnapshot(e)).toList();
          return Right(products);
        }catch(e){log(e.toString());}
        //bestSeller.right.docs.
        log("should be done and we have Dont Miss now-firestorelogic");
        log(products.length.toString());
        log(products.toString());
        return Right(products);
        //Future<QuerySnapshot<Map<String,dynamic>>> categories=categories.right.get();
      }else{
        log("wtf");
        return Left(similarFrom.left);}
    } on FirebaseException catch (e) {
      log("logic_error");
      return Left(e.toString());
    }
  }
}