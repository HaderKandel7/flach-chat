import 'package:flutter/material.dart';

class UserModel {
  String name;
  String email;
  String phone;
  String uId;
  String bio;
  String profile;
  String cover;



  UserModel(
      {@required this.name,
      @required this.email,
      @required this.phone,
      @required this.uId,
      @required this.bio,
      @required this.cover,
      @required this.profile
      });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    profile = json['profile'];
    cover = json['cover'];
    bio = json['bio'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'bio': bio,
      'cover': cover,
      'profile': profile
    };
  }
}
