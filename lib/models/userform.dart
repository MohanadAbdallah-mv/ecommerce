import 'package:firebase_auth/firebase_auth.dart';

class FormUser {
  String? name;
  PhoneAuthCredential? phonenumber;
  String email;
  String password;

  FormUser(
      {this.name,
        required this.email,
        required this.password,this.phonenumber});
}