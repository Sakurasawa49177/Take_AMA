import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:take_ama/models/News.dart';

class NewsAPI {
  static String url = "http://take-ama.cckcoder.cc";

  static Future<String> create(News news) async {
    var urlRegister = Uri.parse('$url/api/news/create.php');
    var response = await http.post(
      urlRegister,
      headers: {
        'Content-Type': 'application/json',
      },
      encoding: Encoding.getByName('utf-8'),
      body: jsonEncode({
        "title": news.title,
        "description": news.description,
      }),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result["message"];
    }
    return "Something went wrong";
  }

  static Future<String> update(News news) async {
    var urlRegister = Uri.parse('$url/api/news/update.php');
    var response = await http.put(
      urlRegister,
      headers: {
        'Content-Type': 'application/json',
      },
      encoding: Encoding.getByName('utf-8'),
      body: jsonEncode({
        "id": news.id,
        "title": news.title,
        "description": news.description,
      }),
    );
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result["message"];
    }
    return "Something went wrong";
  }

  static Future<String> delete(String id) async {
    var urlRegister = Uri.parse('$url/api/news/delete.php');
    var response = await http.put(
      urlRegister,
      headers: {
        'Content-Type': 'application/json',
      },
      encoding: Encoding.getByName('utf-8'),
      body: jsonEncode(
        {"id": id},
      ),
    );
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result["message"];
    }
    return "Something went wrong";
  }

  static Future<List<News?>> getAll() async {
    try {
      var urlApi = Uri.parse('$url/api/news/read.php');
      final response = await http.get(urlApi, headers: {
        'Content-Type': 'application/json',
      });
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)["data"];
        List<News> data = result.map((p) => News.fromJson(p)).toList();
        return data;
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }
}
