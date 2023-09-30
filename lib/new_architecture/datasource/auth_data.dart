// abstract class Auth{
//
//   register(){}
//   login(){}
// }
//
// class FireCall extends Auth{
//   @override
//   login(String email, String password) async {
//     // I Interact directly with the data layer
//     // Firebase - Local Storage
//     // I need a interface to define my responsibilities
//     return true;
//   }
// }
// class LocalCall extends Auth{
//
// }
import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecommerece/models/userform.dart';
import 'package:firebase_core/firebase_core.dart';

abstract class Auth {
  FirebaseAuth firebaseauth;

  Auth({required this.firebaseauth});

  Future<Either<String, UserCredential>> login(FormUser userForm);

  Future<Either<String, UserCredential>> register(FormUser userForm);

}

class AuthImplement extends Auth {
  AuthImplement({required super.firebaseauth});

  @override
  Future<Either<String, UserCredential>> login(FormUser userForm) async {
    try {

      final credential = await firebaseauth.signInWithEmailAndPassword(
          email: userForm.email, password: userForm.password);
      log("'user is back again' auth_source");
      return Right(credential);
    } on FirebaseAuthException catch (e) {
      log("'log in failure' auth_source");
      return Left(e.code);
    }
  }

  @override
  Future<Either<String, UserCredential>> register(FormUser userForm) async {
    UserCredential credential;
    try {
      credential = await firebaseauth.createUserWithEmailAndPassword(
          email: userForm.email, password: userForm.password);
      log("auth_data returned successfully");

      print(credential);

      //return Right(credential);
    } on FirebaseAuthException catch (e) {
      log("auth_data error");
      return Left(e.code);
    }
    //if user is returned from auth we will update his name and phone number
    try {
      //credential.user!.updatePhoneNumber(userForm.phonenumber!);

      log(userForm.name.toString());
      // await FirebaseAuth.instance.currentUser!.updateDisplayName(userForm.name.toString());
      // await FirebaseAuth.instance.currentUser!.reload(); //TODO user set display name not working at the moment
      //log(credential.user.displayName.toString());
      log("'user have name and phone number now' auth_source");
      return Right(credential);
    }on FirebaseException catch (e) {
      return Left(e.code);
    }
  }


}
