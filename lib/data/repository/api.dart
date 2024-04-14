import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/faq.dart';
import '../model/plant.dart';

class Api {
  static String? auth = "sk-B8oH6608468daafa24915";

  static String? defaultPlantThumbnail = "https://perenual.com/storage/article_faq/faq_13Y7nX6435fb7c71c37/medium.jpg";
  static String? defaultFaqThumbnail = "https://perenual.com/storage/article_faq/faq_13Y7nX6435fb7c71c37/medium.jpg";

  static Future<List<Faq>> getFaqList() async {
    var url = Uri.parse("https://perenual.com/api/article-faq-list?key=$auth");

    final response = await http.get(url, headers: {"Content-Type": "application/json"});
    final dynamic decodedResponse = json.decode(response.body)["data"];

    if (decodedResponse.containsKey('data')) {
      final List<dynamic> body = decodedResponse["data"];
      return body.map((e) => Faq.fromJson(e)).toList();
    }

    return [];
  }

  static Future<List<Plant>> getPlantList() async {
    var page = Random().nextInt(10);

    var url = Uri.parse("https://perenual.com/api/species-list?key=$auth&views=$page");

    final response = await http.get(url, headers: {"Content-Type": "application/json"});
    final dynamic decodedResponse = json.decode(response.body)["data"];

    if (decodedResponse.containsKey('data')) {
      final List<dynamic> body = decodedResponse["data"];
      return body.map((e) => Plant.fromJson(e)).toList();
    }

    return [];
  }
}