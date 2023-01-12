// To parse this JSON data, do
//
//     final userCount = userCountFromJson(jsonString);

import 'dart:convert';

UserCount userCountFromJson(String str) => UserCount.fromJson(json.decode(str));

String userCountToJson(UserCount data) => json.encode(data.toJson());

class UserCount {
  UserCount({
    this.userCount,
  });

  String? userCount;

  factory UserCount.fromJson(Map<String, dynamic> json) => UserCount(
        userCount: json["user_count"],
      );

  Map<String, dynamic> toJson() => {
        "user_count": userCount,
      };
}
