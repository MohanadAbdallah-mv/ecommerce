import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';

import '../../models/user_model.dart';

abstract class Firestore {
  FirebaseFirestore firebaseFirestore;

  Firestore({required this.firebaseFirestore});

  Future<Either<String, QuerySnapshot>> getCategories(); //i can either return stream or snapshots of document or collection
  Future<Either<String, QuerySnapshot<Map<String,dynamic>>>> getBestSeller(String category);
  Future<Either<String, QuerySnapshot<Map<String,dynamic>>>> getDontMiss(String category);
  Future<Either<String, QuerySnapshot<Map<String,dynamic>>>> getSimilarFrom(String subcategory);
  Future<String>addUser(MyUser user);

}

class FirestoreImplement extends Firestore {
  FirestoreImplement({required super.firebaseFirestore});

  @override
  Future<Either<String, QuerySnapshot>>getCategories()async {
    try {
      CollectionReference<Map<String, dynamic>> categoriesref =
          firebaseFirestore.collection('category');
      QuerySnapshot categories =await categoriesref.get();
      return Right(categories);
    } on FirebaseException catch (e) {
      return Left(e.toString());
    }
  }
  @override
  Future<Either<String, QuerySnapshot<Map<String,dynamic>>>> getBestSeller(String category) async{
    try {
      log('entering best seller in source');
      CollectionReference<Map<String, dynamic>> ProductsRef =
      firebaseFirestore.collection('product');
      QuerySnapshot<Map<String,dynamic>> bestSeller =await ProductsRef.where("is_best_seller",isEqualTo: true).where("category",isEqualTo: category).get();
      log(bestSeller.toString());
      log("best seller is back from source");
      return Right(bestSeller);
    } on FirebaseException catch (e) {
      log("firebase exception at source");
      log(e.toString());
      return Left(e.toString());
    }
  }
  @override
  Future<Either<String, QuerySnapshot<Map<String,dynamic>>>> getDontMiss(String category) async{
    try {
      CollectionReference<Map<String, dynamic>> ProductsRef =
      firebaseFirestore.collection('product');
      QuerySnapshot<Map<String,dynamic>> dontMiss =await ProductsRef.where("dont_miss",isEqualTo: true).where("category",isEqualTo: category).get();
      log("Dont Miss is back from source");
      return Right(dontMiss);
    } on FirebaseException catch (e) {
      return Left(e.toString());
    }
  }
  @override
  Future<Either<String, QuerySnapshot<Map<String,dynamic>>>> getSimilarFrom(String subcategory) async{
    try {
      CollectionReference<Map<String, dynamic>> ProductsRef =
      firebaseFirestore.collection('product');
      QuerySnapshot<Map<String,dynamic>> similarFrom =await ProductsRef.where("sub_category",arrayContains: subcategory).get();
      log("SimilarFrom is back from source");
      return Right(similarFrom);
    } on FirebaseException catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<String> addUser(MyUser user) async{
    try{
      CollectionReference<Map<String, dynamic>> usersref =
      firebaseFirestore.collection('users');
      await usersref.add(user.toJson());
      return "success";
    }on FirebaseException catch (e){
      return e.message.toString();
    }
  }

}
