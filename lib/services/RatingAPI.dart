import 'dart:convert';
import 'package:http/http.dart' as http;

class RatingAPI {
  static String url = "http://take-ama.cckcoder.cc";

  static Future<String> updateRating(
      {required String username, required double? ratingstart}) async {
    var urlApi = Uri.parse('$url/api/rating/create.php');
    final response = await http.post(urlApi,
        headers: {
          'Content-Type': 'application/json',
        },
        encoding: Encoding.getByName('utf-8'),
        body: jsonEncode({
          'user_id': username,
          'star': ratingstart,
        }));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['message'];
    }
    return "Something went wrong";
  }

  static Future<double> getRating() async {
    var urlGetStarRating = Uri.parse('$url/api/rating/read.php');
    var response = await http.get(
      urlGetStarRating,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      double rating = double.parse(result['total_star'].toString());
      return rating;
    }
    return 0;
  }
}
