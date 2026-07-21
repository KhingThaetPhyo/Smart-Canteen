// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:smartcanteen/model/register_model.dart';// Make sure this path is correct for your project

// class ApiService {
//   // Update this to 'http://10.0.2.2:8000/api/register' if using an Android Emulator
//   static const String _baseUrl = 'http://192.168.1.9:8000/api/register';

//   Future<RegisterModel?> registerUser({
//     required String name,
//     required String email,
//     required String phone,
//     required String password,
//   }) async {
//     try {
//       final response = await http.post(
//         Uri.parse(_baseUrl),
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//         },
//         body: jsonEncode({
//           'user_name': name,
//           'user_email': email,
//           'user_phone': phone,
//           'user_password': password,
//           'role_name': 'student', // default based on your JSON example
//         }),
//       );

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         // 1. Decode the raw string response into a Map
//         final Map<String, dynamic> responseData = jsonDecode(response.body);

//         // 2. Pass the map into your generated FromJson model
//         return RegisterModel.fromJson(responseData);
//       } else {
//         print('Server Error: ${response.statusCode} - ${response.body}');
//         return null;
//       }
//     } catch (e) {
//       print('Network Error: $e');
//       return null;
//     }
//   }
// }
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:smartcanteen/model/login_model.dart';
import 'package:smartcanteen/model/register_model.dart'; // Make sure this path is correct for your project

class ApiService {
  // Update this to 'http://10.0.2.2:8000/api' if using an Android Emulator
  static const String baseUrl = "http://192.168.1.10:8000/api";

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
}

