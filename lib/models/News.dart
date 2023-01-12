// To parse this JSON data, do
//
//     final news = newsFromJson(jsonString);

import 'dart:convert';

NewsList newsFromJson(String str) => NewsList.fromJson(json.decode(str));

String newsToJson(NewsList data) => json.encode(data.toJson());

class NewsList {
  NewsList({
    this.newsList,
  });

  List<News>? newsList;

  factory NewsList.fromJson(Map<String, dynamic> json) => NewsList(
        newsList: List<News>.from(json["data"].map((x) => News.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(newsList!.map((x) => x.toJson())),
      };
}

class News {
  News({
    this.id,
    this.title,
    this.description,
  });

  String? id;
  String? title;
  String? description;

  factory News.fromJson(Map<String, dynamic> json) => News(
        id: json["id"],
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
      };
}
