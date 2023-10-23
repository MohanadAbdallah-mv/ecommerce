import 'dart:developer';

import 'package:ecommerece/models/product.dart';
import 'package:ecommerece/new_architecture/repo/firestore_logic.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';

import '../../models/user_model.dart';

class FireStoreController extends ChangeNotifier {
  FirestorehandlerImplement firestorehandlerImplement;
  int categorySelectedindex;
  bool isSelected;
  late String categorySelected;

  FireStoreController(
      {required this.firestorehandlerImplement,
      this.categorySelectedindex = 0,
      this.isSelected = false,this.categorySelected=""});



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
  Future<String> selectCategory(Future<List<String>> category) async{
      await category.then((value) => categorySelected=value[categorySelectedindex]);
      notifyListeners();
      return categorySelected;

  }

  Future<Either<String, List<String>>> getCategory() async {
    try {
      Either<String, List<String>> res =
          await firestorehandlerImplement.getCategory();
      if (res.isRight) {
        categorySelected=res.right[categorySelectedindex];
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
  Future<String> addUser(MyUser user) async{
    try{
      String res = await firestorehandlerImplement.addUser(user);

      return res;
    }catch (e){
      return e.toString();
    }
  }


}
