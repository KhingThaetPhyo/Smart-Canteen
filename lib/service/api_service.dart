
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as _dio;
import 'package:smartcanteen/model/category_model.dart';
import 'package:smartcanteen/model/login_model.dart';
import 'package:smartcanteen/model/register_model.dart';
import 'package:smartcanteen/model/shop_model.dart';
import 'package:smartcanteen/model/view_menu_model.dart'; // Make sure this path is correct for your project

class ApiService {
  // Update this to 'http://10.0.2.2:8000/api' if using an Android Emulator
  //static const String baseUrl = "http://192.168.1.12:8000/api";
  static const String baseUrl = "https://7d031e28c4fff2cc-202-165-86-143.serveousercontent.com/api";
//https://0c087b6d8fabd90f-202-165-86-143.serveousercontent.com/api/login
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    ),
  );

  Future<RegisterModel?> registerUser({
  required String name,
  required String email,
  required String phone,
  required String password,
  required String role,
  String? studentId,
  String? semester,
  String? academicYear,
  String? yearLevel,
  required String walletPin,
  String? fcmToken, // FCM Token ထည့်ရန်
}) async {
  try {
    print({
      'user_name': name,
      'user_email': email,
      'user_phone': phone,
      'user_password': password,
      'role_name': role,
      'student_id': studentId,
      'semester': semester,
      'academic_year': academicYear,
      'year_level': yearLevel,
      'wallet_pin': walletPin,
      'fcm_token': fcmToken,
    });

    final response = await _dio.post(
      "/register",
      data: {
        'user_name': name,
        'user_phone': phone,
        'user_email': email,
        'user_password': password,
        'role_name': role,
        'student_id': studentId,
        'semester': semester,
        'academic_year': academicYear,
        'year_level': yearLevel,
        'wallet_pin': walletPin,
        'fcm_token': fcmToken, // API ကို token ပို့ခြင်း
      },
    );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Dio automatically parses JSON string responses into a Map/List,
        // so response.data can be passed directly to your fromJson factory.
        final responseData = response.data;
        print("Response Data:");
print(response.data);
        return RegisterModel.fromJson(responseData);
      } else {
        print('Server Error: ${response.statusCode} - ${response.data}');
        return null;
      }
    }on DioException catch (e) {
  print("========== DIO ERROR ==========");
  print("Type: ${e.type}");
  print("Message: ${e.message}");
  print("Status Code: ${e.response?.statusCode}");
  print("Response: ${e.response?.data}");
  print("===============================");

  if (e.response != null) {
    final data = e.response!.data;

    // Validation errors (422)
    if (data["errors"] != null) {
      String errorMessage = "";

      (data["errors"] as Map<String, dynamic>).forEach((key, value) {
        if (value is List && value.isNotEmpty) {
          errorMessage += "${value.first}\n";
        }
      });

      throw errorMessage.trim();
    }

    // Other server errors
    throw data["message"] ?? "Registration failed.";
  }

  throw "Unable to connect to server.";
}
  }


Future<LoginModel?> loginUser({
  required String email,
  required String password,
}) async {
  try {
    print("Sending login request...");

    final response = await _dio.post(
      '/login',
      data: {
        'user_email': email,
        'user_password': password,
      },
    );

    print("Login Response: ${response.data}");

    if (response.statusCode == 200) {
      return LoginModel.fromJson(response.data);
    }
    return null;
  }  on DioException catch (e) {
  print("========== LOGIN DIO ERROR ==========");
  print("Type: ${e.type}");
  print("Message: ${e.message}");
  print("Status Code: ${e.response?.statusCode}");
  print("Response: ${e.response?.data}");
  print("=====================================");

  if (e.response != null) {
    final data = e.response!.data;
    throw data['message'] ?? 'Login failed.';
  }

  throw 'Unable to connect to server.';
}
}

/// Fetch Shops along with their Menu Items using ViewMenuModel
  Future<ViewMenuModel?> getShopsWithMenus() async {
    try {
      final response = await _dio.get("/shops-with-menus");

      if (response.statusCode == 200) {
        return ViewMenuModel.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      print("========== FETCH MENUS DIO ERROR ==========");
      print("Type: ${e.type}");
      print("Message: ${e.message}");
      print("Status Code: ${e.response?.statusCode}");
      print("Response: ${e.response?.data}");
      print("===========================================");

      if (e.response != null) {
        final data = e.response!.data;
        throw data['message'] ?? 'Failed to load shops and menus.';
      }

      throw 'Unable to connect to server.';
    }
  }

 Future<List<ShopModel>> getShops() async {
  try {
    final response = await _dio.get("/shops");

    if (response.statusCode == 200 && response.data['success'] == true) {
      final List list = response.data['data'] ?? [];
      return list.map((json) => ShopModel.fromJson(json)).toList();
    }
    return [];
  } on DioException catch (e) {
    // PRINT THIS TO YOUR FLUTTER CONSOLE TO SEE THE EXACT ISSUE:
    print("LOG ERROR: ${e.type} -> ${e.message}");
    print("RESPONSE: ${e.response?.data}");
    
    throw e.response?.data['message'] ?? 'Failed to load shops.';
  }
}

/// Fetch Categories List
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await _dio.get("/shops/all-categories");

      if (response.statusCode == 200 && response.data['success'] == true) {
        final List list = response.data['data'] ?? [];
        return list.map((json) => CategoryModel.fromJson(json)).toList();
      }
      return [];
    } on DioException catch (e) {
      print("========== FETCH CATEGORIES DIO ERROR ==========");
      print("Type: ${e.type}");
      print("Message: ${e.message}");
      print("Status Code: ${e.response?.statusCode}");
      print("Response Data: ${e.response?.data}");
      print("================================================");

      if (e.response != null && e.response?.data != null) {
        throw e.response?.data['message'] ?? 'Failed to load categories.';
      }
      throw 'Unable to connect to server. Please check your connection.';
    }
  }

  /// Fetch all menus for a specific shop without using a custom model
  Future<Map<String, dynamic>?> getShopAllMenus(int shopId) async {
    try {
      final response = await _dio.get("/shops/$shopId/all-menus");

      if (response.statusCode == 200) {
        // Dio automatically decodes JSON responses into a Map
        return response.data as Map<String, dynamic>;
      }
      return null;
    } on DioException catch (e) {
      print("========== FETCH SHOP MENUS DIO ERROR ==========");
      print("Type: ${e.type}");
      print("Message: ${e.message}");
      print("Status Code: ${e.response?.statusCode}");
      print("Response: ${e.response?.data}");
      print("================================================");

      if (e.response != null && e.response?.data != null) {
        throw e.response?.data['message'] ?? 'Failed to load menu details.';
      }

      throw 'Unable to connect to server. Please check your connection.';
    }
  }
}