// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.username = "",
    this.password = "",
    this.email = "",
    this.userType = "",
    this.firstName = "",
    this.lastName = "",
    this.detail = "",
    this.birthDay = 0,
    this.taxId = "",
  });

  String username;
  String password;
  String email;
  String userType;
  String firstName;
  String lastName;
  String detail;
  int birthDay;
  String taxId;

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        password: json["password"],
        email: json["email"],
        userType: json["userType"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        detail: json["detail"],
        birthDay: json["birthDay"],
        taxId: json["taxId"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "email": email,
        "userType": userType,
        "firstName": firstName,
        "lastName": lastName,
        "detail": detail,
        "birthDay": birthDay,
        "taxId": taxId,
      };
}
