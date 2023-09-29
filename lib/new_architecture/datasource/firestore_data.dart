import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';

abstract class Firestore {
  FirebaseFirestore firebaseFirestore;

  Firestore({required this.firebaseFirestore});

  Future<Either<String, QuerySnapshot>>
      getCategories(); //i can either return stream or snapshots of document or collection
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
}
