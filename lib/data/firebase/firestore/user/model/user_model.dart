// *******************************
// Develop by : Saurav Rafaliya
// Path : lib/data/firebase/firestore/user/model
// *******************************

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? email;

  UserModel({
    this.email,
  });

  UserModel copyWith({
    String? email,
  }) =>
      UserModel(
        email: email ?? this.email,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
  };
}
