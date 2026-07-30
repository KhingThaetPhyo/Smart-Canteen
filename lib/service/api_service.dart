
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as _dio;
import 'package:http/http.dart' as http;
import 'package:smartcanteen/model/category_model.dart';
import 'package:smartcanteen/model/login_model.dart';
import 'package:smartcanteen/model/register_model.dart';
import 'package:smartcanteen/model/shop_model.dart';
import 'package:smartcanteen/model/view_menu_model.dart';
import 'package:smartcanteen/service/secure_storage_service.dart'; // Make sure this path is correct for your project

class ApiService {
  // Update this to 'http://10.0.2.2:8000/api' if using an Android Emulator
  static const String baseUrl = "https://81eb70f126dfa7de-202-165-86-247.serveousercontent.com/api";
 // static const String baseUrl = "http://192.168.1.12:8000/api";
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
 
// Future<Map<String, dynamic>?> createOrder({
//   required int shopId,
//   required String orderType,
//   required String walletPassword,
//   int? foodTableId,
//   String? deliveryLocation,
//   required List<Map<String, dynamic>> items,
// }) async {
//   final url = Uri.parse('$baseUrl/orders/order-create'); // Check endpoint path
//   final token = await SecureStorageService.getToken();

//   final Map<String, dynamic> body = {
//     "shop_id": shopId,
//     "order_type": orderType,
//     "food_table_id": foodTableId,
//     "wallet_password": walletPassword,
//     "delivery_location": deliveryLocation,
//     "items": items,
//   };

//   print("=== DEBUG API REQUEST BODY ===");
//   print(jsonEncode(body));

//   try {
//     final response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         if (token != null) 'Authorization': 'Bearer $token',
//       },
//       body: jsonEncode(body),
//     );

//     print("=== DEBUG API RESPONSE ===");
//     print("Status Code: ${response.statusCode}");
//     print("Body: ${response.body}");
//     print("=== EXACT JSON BODY SENT ===");
// print(jsonEncode(body));
// print("=== ITEMS RUNTIME TYPES ===");
// for (var item in items) {
//   print("menu_id: ${item['menu_id']} (${item['menu_id'].runtimeType})");
// }

//     return jsonDecode(response.body);
//   } catch (e) {
//     print("API Error: $e");
//     return null;
//   }
// }

Future<Map<String, dynamic>?> createOrder({
  required int shopId,
  required String orderType,
  required String walletPassword,
  int? foodTableId,
  String? deliveryLocation,
  required List<Map<String, dynamic>> items,
}) async {
  final url = Uri.parse('$baseUrl/orders/order-create');
  final token = await SecureStorageService.getToken();

  // Ensures menu_id and quantity are parsed as integers to prevent validation errors
  final formattedItems = items.map((item) {
    return {
      "menu_id": int.parse(item['menu_id'].toString()),
      "quantity": int.parse(item['quantity'].toString()),
    };
  }).toList();

  final Map<String, dynamic> body = {
    "shop_id": shopId,
    "order_type": orderType,
    "food_table_id": foodTableId,
    "wallet_password": walletPassword,
    "delivery_location": deliveryLocation,
    "items": formattedItems,
  };

  print("=== DEBUG API REQUEST BODY ===");
  print(jsonEncode(body));

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    print("=== DEBUG API RESPONSE ===");
    print("Status Code: ${response.statusCode}");
    print("Body: ${response.body}");

    final decoded = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return decoded is Map<String, dynamic>
          ? decoded
          : {"success": true, "data": decoded};
    } else {
      return {
        "success": false,
        "message": decoded is Map && decoded.containsKey("message")
            ? decoded["message"]
            : "အော်ဒါ မှာယူမှု မအောင်မြင်ပါ",
      };
    }
  } catch (e) {
    print("API Exception: $e");
    return {
      "success": false,
      "message": "ဆာဗာနှင့် ချိတ်ဆက်၍ မရပါ: $e",
    };
  }
}

/// Fetch updated user wallet balance directly
Future<Map<String, dynamic>?> getWalletBalance() async {
  try {
    final token = await SecureStorageService.getToken();

    final response = await _dio.get(
      "/user/wallet/balance",
      options: Options(
        headers: {
          if (token != null) "Authorization": "Bearer $token",
        },
      ),
    );

    if (response.statusCode == 200) {
      return response.data as Map<String, dynamic>;
    }
    return null;
  } on DioException catch (e) {
    print("========== FETCH WALLET BALANCE ERROR ==========");
    print("Type: ${e.type}");
    print("Message: ${e.message}");
    print("Status Code: ${e.response?.statusCode}");
    print("Response: ${e.response?.data}");
    print("================================================");
    return null;
  }
}
}