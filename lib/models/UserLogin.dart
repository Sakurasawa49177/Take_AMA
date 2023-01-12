// To parse this JSON data, do
//
//     final userLogin = userLoginFromJson(jsonString);

import 'dart:convert';

UserLogin userLoginFromJson(String str) => UserLogin.fromJson(json.decode(str));

String userLoginToJson(UserLogin data) => json.encode(data.toJson());

class UserLogin {
  UserLogin({this.message, this.data, this.status});

  String? message;
  Profile? data;
  String? status;

  factory UserLogin.fromJson(Map<String, dynamic> json) => UserLogin(
      message: json["message"],
      data: json["data"] == null ? null : Profile.fromJson(json["data"]),
      status: json["status"]);

  Map<String, dynamic> toJson() =>
      {"message": message, "data": data!.toJson(), "status": status};
}

class Profile {
  Profile({
    this.id,
    this.username,
    this.detail,
    this.email,
    this.userType,
    this.firstName,
    this.lastName,
    this.birthDay,
    this.isActive,
    this.taxId,
  });

  String? id;
  String? username;
  String? email;
  String? detail;
  String? userType;
  String? firstName;
  String? lastName;
  String? birthDay;
  String? isActive;
  String? taxId;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        username: json["username"],
        detail: json["detail"],
        email: json["email"],
        userType: json["userType"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        birthDay: json["birthDay"],
        isActive: json["isActive"],
        taxId: json["taxId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "userType": userType,
        "firstName": firstName,
        "lastName": lastName,
        "birthDay": birthDay,
        "isActive": isActive,
        "taxId": taxId,
      };
}
