// shared_preferences_service.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartcanteen/model/user_model.dart';

class SharedPreferencesService {
  static const String _userKey = 'user_data';
  static const String _tokenKey = 'auth_token';

  // Save User Model
  static Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(user.toJson());
    await prefs.setString(_userKey, jsonString);
  }

  // Retrieve User Model
  static Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(_userKey);
    if (jsonString != null && jsonString.isNotEmpty) {
      return UserModel.fromJson(jsonDecode(jsonString));
    }
    return null;
  }

  // Save Auth Token
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // Retrieve Auth Token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Clear session on logout
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
