
class MyUser {
  late String id;
  late String? name;
  late String email;
  late String? phonenumber;
  late bool isLogged;

  MyUser(
      {required this.id, required this.name,
      required this.email,
      required this.phonenumber,
      required this.isLogged});

  MyUser.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
    phonenumber = json["phonenumber"];
    isLogged = json["isLogged"];
  }
  Map<String,dynamic>toJson()=>{
  "id":id,
    "name":name,
    "email":email,
    "phonenumber":phonenumber,
    "isLogged":isLogged
  };
}
