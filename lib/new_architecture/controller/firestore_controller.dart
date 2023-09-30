import 'package:ecommerece/models/product.dart';
import 'package:ecommerece/new_architecture/repo/firestore_logic.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';

class FireStoreController extends ChangeNotifier {
  FirestorehandlerImplement firestorehandlerImplement;
  int categorySelectedindex;
  bool isSelected;

  FireStoreController(
      {required this.firestorehandlerImplement,
      this.categorySelectedindex = 0,
      this.isSelected = false});



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

  Future<Either<String, List<String>>> getCategory() async {
    try {
      Either<String, List<String>> res =
          await firestorehandlerImplement.getCategory();
      if (res.isRight) {
        return Right(res.right);
      } else {
        return Left(res.left);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<Product>>> getBestSeller() async {
    try {
      Either<String, List<Product>> res =
      await firestorehandlerImplement.getBestSeller();
      if (res.isRight) {
        return Right(res.right);
      } else {
        return Left(res.left);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
  Future<Either<String, List<Product>>> getDontMiss() async {
    try {
      Either<String, List<Product>> res =
      await firestorehandlerImplement.getDontMiss();
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


}
