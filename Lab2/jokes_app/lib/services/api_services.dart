import 'dart:convert';

import 'package:jokes_app/models/joke_model.dart';
import 'package:jokes_app/models/joke_type_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://official-joke-api.appspot.com";

  ApiService();

  Future<List<JokeTypeModel>> getJokeTypes() async {
    final url = Uri.parse('$baseUrl/types');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((item) => JokeTypeModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<JokeModel>> getJokesWithType(String type) async {
    final url = Uri.parse('$baseUrl/jokes/$type/ten');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((item) => JokeModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}