import 'dart:convert';
import 'package:jokes_app/models/joke_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  // Singleton pattern for the service
  static final LocalStorageService _instance = LocalStorageService._internal();

  factory LocalStorageService() => _instance;

  LocalStorageService._internal();

  Future<void> saveJsonList(String key, List<JokeModel> jsonList) async {
    final prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(jsonList);
    await prefs.setString(key, jsonString);
  }

  // Retrieve a list of JSON data
  Future<List<JokeModel>> GetFavoriteJokes(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(key);
    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((item) => JokeModel.fromJson(item)).toList();

    }
    return [];
  }

  // Save a single string
  Future<void> saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  // Retrieve a single string
  Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  // Clear a specific key
  Future<void> clear(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
