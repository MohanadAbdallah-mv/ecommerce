import 'package:firebase_auth/firebase_auth.dart';

class MyUser {
  late String id;
  late String? name;
  late String email;
  late String? phonenumber;
  late bool isLogged;

  MyUser(
      {required this.id, this.name,
      required this.email,
      this.phonenumber,
      required this.isLogged});

  MyUser.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    email = json["notes"];
    phonenumber = json["phonenumber"];
    isLogged = json["isLogged"];
  }
}
