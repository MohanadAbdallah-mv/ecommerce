import 'dart:developer';

import 'package:ecommerece/models/userform.dart';
import 'package:ecommerece/new_architecture/repo/auth_logic.dart';
import 'package:ecommerece/services/Cache_Helper.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../../models/user_model.dart';

class AuthController extends ChangeNotifier {
  // I handle collecting data from the user interface and passing it to the logic layer
  // I also handle the logic layer's response and pass it to the user interface
  CacheData cache;
  AuthHandlerImplement repo;

  AuthController({required this.cache, required this.repo});

  Future<void> login(String? email, String? password) async {
    try{
      FormUser userForm = FormUser(email: email!, password: password!);
      Either<String,MyUser> res = await repo.login(userForm);
      if(res.isRight){
        log("finally,logged in");
        print(res.right);
      }else{print(res.isLeft);}
    }catch(e){
      log(e.toString());
      log("failed at controller");}
    notifyListeners();
  }

  Future<void> register(String? name,PhoneAuthCredential? phone, String? email, String? password) async{
    //Todo name was not assigned
    FormUser userForm = FormUser(name: name!,phonenumber:phone! ,email: email!, password: password!);
    Either<String, MyUser> res = await repo.register(userForm);
    print(MyUser);
    if (res.isRight) {
      log("finally,registered");
      print(res.right);
    }else{
      log(res.left.toString());
      log("failed at controller");}
    notifyListeners();
  }

  void logout() {
    notifyListeners();
  }
// void isLogged(User? user){
// }
}
