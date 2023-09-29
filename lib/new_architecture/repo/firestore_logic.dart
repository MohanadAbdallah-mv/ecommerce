
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerece/new_architecture/datasource/firestore_data.dart';
import 'package:either_dart/either.dart';

abstract class Firestorehandler {
  FirestoreImplement firestoreImplement;

  Firestorehandler({required this.firestoreImplement});

  Future<Either<String,List>> getCategory();
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
}