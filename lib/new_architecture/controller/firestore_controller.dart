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
}
