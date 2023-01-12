import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:take_ama/models/User.dart';
import 'package:take_ama/models/UserCount.dart';
import 'package:take_ama/models/UserLogin.dart';

class UserAPI {
  static String url = "http://take-ama.cckcoder.cc";

  static Future<String> register(User user) async {
    var urlRegister = Uri.parse('$url/api/user/register.php');
    var response = await http.post(
      urlRegister,
      headers: {
        'Content-Type': 'application/json',
      },
      encoding: Encoding.getByName('utf-8'),
      body: jsonEncode(user),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result["message"];
    }
    return "Something went wrong";
  }

  static Future<String> update(Profile profile) async {
    var urlRegister = Uri.parse('$url/api/user/update.php');
    var response = await http.put(
      urlRegister,
      headers: {
        'Content-Type': 'application/json',
      },
      encoding: Encoding.getByName('utf-8'),
      body: jsonEncode({
        "user_id": profile.id,
        "firstName": profile.firstName,
        "lastName": profile.lastName,
        "detail": profile.detail,
        "birthDay": profile.birthDay,
        "taxId": profile.taxId,
      }),
    );
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result["message"];
    }
    return "Something went wrong";
  }

  static Future<String> delete(String id) async {
    var urlRegister = Uri.parse('$url/api/user/delete.php');
    var response = await http.put(
      urlRegister,
      headers: {
        'Content-Type': 'application/json',
      },
      encoding: Encoding.getByName('utf-8'),
      body: jsonEncode(
        {"user_id": id},
      ),
    );
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result["message"];
    }
    return "Something went wrong";
  }

  static Future<UserLogin?> login(
      {required String username, required String password}) async {
    var urlApi = Uri.parse('$url/api/user/login.php');
    final response = await http.post(urlApi,
        headers: {
          'Content-Type': 'application/json',
        },
        encoding: Encoding.getByName('utf-8'),
        body: jsonEncode({
          'username': username,
          'password': password,
        }));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      var data = UserLogin.fromJson(result);
      return data;
    }
    return null;
  }

  static Future<List<Profile?>> getAll() async {
    var urlApi = Uri.parse('$url/api/user/read.php');
    final response = await http.get(urlApi, headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)["data"];
      List<Profile> data = result.map((p) => Profile.fromJson(p)).toList();
      return data;
    } else {
      return [];
    }
  }

  static Future<UserCount?> getUserCount() async {
    var urlApi = Uri.parse('$url/api/user/user_count.php');
    final response = await http.get(urlApi, headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      UserCount? userCount = UserCount.fromJson(result);
      return userCount;
    } else {
      return null;
    }
  }
}
