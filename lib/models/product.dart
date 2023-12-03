import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String? id;
  final String? Author_name;
  final String? Description;
  final List<dynamic>? Specifications;
  final String? category;
  final int? discount_price;
  final bool? dont_miss;
  final String? image;
  final bool? is_best_seller;
  final String? name;
  final int? price;
  final double? stars;
  final List<dynamic>? sub_category;


  Product(
      {this.id,  this.Author_name,  this.name,  this.category,  this.Description,  this.discount_price,  this.dont_miss,  this.image,  this.is_best_seller,  this.price,  this.Specifications,  this.stars,  this.sub_category});

  factory Product.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>>document){
    Map<String,dynamic> data=document.data();
    print(data["name"]);
      return Product(
          id: document.id,
          Author_name: data["Author_name"],
          name: data["name"],
          category: data["category"],
          Description: data["Description"],
          discount_price: data["discount_price"],
          dont_miss: data["dont_miss"],
          image: data["image"],
          is_best_seller: data["is_best_seller"],
          price: data["price"],
          Specifications: data["Specifications"],
          stars: data["stars"],
          sub_category: data["sub_category"]);
  }
  Map<String, dynamic> toJson() => {
    "id": id,
    "Author_name": Author_name,
    "category": category,
    "Description": Description,
    "discount_price": discount_price,
    "dont_miss": dont_miss,
    "image": image,
    "is_best_seller": is_best_seller,
    "price": price,
    "Specifications": Specifications,
    "stars": stars,
    "sub_category": sub_category
  };
  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    Author_name: json["Author_name"],
    name: json["name"],
    category: json["category"],
    Description: json["Description"],
    discount_price: json["discount_price"],
    dont_miss: json["dont_miss"],
    image: json["image"],
    is_best_seller: json["is_best_seller"],
    price: json["price"],
    Specifications: json["Specifications"],
    stars: json["stars"],
    sub_category: json["sub_category"],
  );
}
