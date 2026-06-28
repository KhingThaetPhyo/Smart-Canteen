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
import 'package:smartcanteen/model/register_model.dart'; // Make sure this path is correct for your project

class ApiService {
  // Update this to 'http://10.0.2.2:8000/api' if using an Android Emulator
  static const String baseUrl = "http://192.168.1.9:8000/api";

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
  }) async {
    try {
      final response = await _dio.post(
        "/register",
        data: {
          'user_name': name,
          'user_email': email,
          'user_phone': phone,
          'user_password': password,
          'role_name': role, // default based on your JSON example
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Dio automatically parses JSON string responses into a Map/List,
        // so response.data can be passed directly to your fromJson factory.
        final responseData = response.data;
        return RegisterModel.fromJson(responseData);
      } else {
        print('Server Error: ${response.statusCode} - ${response.data}');
        return null;
      }
    } catch (e) {
      print('Network Error: $e');
      return null;
    }
  }
}
