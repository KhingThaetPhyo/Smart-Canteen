import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:smartcanteen/model/login_model.dart';
import 'package:smartcanteen/model/register_model.dart';
import 'package:smartcanteen/service/secure_storage_service.dart';
import 'package:smartcanteen/service/shared_preferences_service.dart';

class ApiService {
  // static const String baseUrl = "http://192.168.1.12:8000/api";
  static const String baseUrl =
      "https://81eb70f126dfa7de-202-165-86-247.serveousercontent.com/api";

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

  // ===== REGISTER USER =====
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
          'fcm_token': fcmToken,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return RegisterModel.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      print("========== REGISTER DIO ERROR ==========");
      print("Response: ${e.response?.data}");

      if (e.response != null && e.response!.data != null) {
        final data = e.response!.data;

        if (data is Map<String, dynamic>) {
          if (data["errors"] != null) {
            if (data["errors"] is Map) {
              String errorMessage = "";
              (data["errors"] as Map).forEach((key, value) {
                if (value is List && value.isNotEmpty) {
                  errorMessage += "${value.first}\n";
                } else if (value is String) {
                  errorMessage += "$value\n";
                }
              });
              throw errorMessage.trim();
            } else if (data["errors"] is List) {
              throw (data["errors"] as List).join("\n");
            }
          }
          throw data["message"] ?? "Registration failed.";
        } else if (data is List && data.isNotEmpty) {
          throw data.first.toString();
        }
      }
      throw "Unable to connect to server.";
    }
  }

  // ===== LOGIN USER =====
  Future<LoginModel?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      print("Sending login request...");

      final response = await _dio.post(
        '/login',
        data: {'user_email': email, 'user_password': password},
      );

      print("Login Response: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final loginModel = LoginModel.fromJson(response.data);

        // Login အောင်မြင်ပါက Token ကို မပျောက်အောင် သေချာ သိမ်းဆည်းပေးခြင်း
        if (loginModel.token != null && loginModel.token!.isNotEmpty) {
          await SecureStorageService.saveToken(loginModel.token!);
          await SharedPreferencesService.saveToken(loginModel.token!);
        }

        return loginModel;
      }
      return null;
    } on DioException catch (e) {
      print("========== LOGIN DIO ERROR ==========");
      print("Status Code: ${e.response?.statusCode}");
      print("Response: ${e.response?.data}");

      if (e.response != null && e.response!.data != null) {
        final data = e.response!.data;
        if (data is Map<String, dynamic>) {
          throw data['message'] ?? 'Login failed.';
        }
      }
      throw 'Unable to connect to server.';
    }
  }

  // ===== UPDATE Phone USER =====
  Future<bool> updatePhone({required String phone}) async {
    try {
      final token = await SecureStorageService.getToken();

      final response = await _dio.put(
        '/user/update-profile',
        data: {'user_phone': phone},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Profile Updated Successfully: ${response.data}");
        return true;
      }
      return false;
    } on DioException catch (e) {
      print("========== UPDATE PROFILE DIO ERROR ==========");
      print("Status Code: ${e.response?.statusCode}");
      print("Response: ${e.response?.data}");

      if (e.response != null) {
        final responseData = e.response!.data;

        if (responseData is Map<String, dynamic> &&
            responseData["errors"] != null) {
          String errorMessage = "";
          (responseData["errors"] as Map<String, dynamic>).forEach((
            key,
            value,
          ) {
            if (value is List && value.isNotEmpty) {
              errorMessage += "${value.first}\n";
            }
          });
          throw errorMessage.trim();
        }
        throw responseData["message"] ?? "Failed to update profile.";
      }
      throw "Unable to connect to server.";
    }
  }

  // ===== FORGOT WALLET PIN (Send OTP) =====
  Future<bool> forgotPin(String email) async {
    try {
      final token = await SecureStorageService.getToken();

      final response = await _dio.post(
        '/forgot-pin',
        data: {'user_email': email, 'email': email},
        options: Options(
          headers: {
            if (token != null && token.isNotEmpty)
              'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data['success'] ?? true;
      }
      return false;
    } on DioException catch (e) {
      if (e.response != null && e.response!.data != null) {
        final data = e.response!.data;
        if (data is Map<String, dynamic>) {
          throw data['message'] ?? 'Failed to send OTP.';
        }
      }
      throw 'Unable to connect to server.';
    }
  }

  // ===== RESET WALLET PIN =====
  Future<Map<String, dynamic>> resetPin({
    required String email,
    required String otp,
    required String newPin,
  }) async {
    try {
      final token = await SecureStorageService.getToken();

      final response = await _dio.post(
        '/reset-pin',
        data: {'email': email, 'otp': otp, 'new_pin': newPin},
        options: Options(
          headers: {
            if (token != null && token.isNotEmpty)
              'Authorization': 'Bearer $token',
          },
        ),
      );

      return {
        'success':
            (response.statusCode == 200 || response.statusCode == 201) &&
            (response.data['success'] ?? true),
        'message': response.data['message'] ?? 'PIN reset successfully.',
      };
    } on DioException catch (e) {
      if (e.response != null && e.response!.data != null) {
        final data = e.response!.data;
        if (data is Map<String, dynamic>) {
          return {
            'success': false,
            'message': data['message'] ?? 'Failed to reset PIN.',
          };
        }
      }
      return {'success': false, 'message': 'Unable to connect to server.'};
    }
  }

  // ===== CHANGE WALLET PIN =====
  Future<bool> changePin({
    required String oldPin,
    required String newPin,
  }) async {
    try {
      final String? token = await SecureStorageService.getToken();

      final response = await _dio.post(
        '/wallet/update-pin',
        data: {
          'current_pin': oldPin, // Backend မျှော်လင့်ထားသော Key Name
          'new_pin': newPin,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            if (token != null && token.isNotEmpty)
              'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
      return false;
    } on DioException catch (e) {
      print("========== CHANGE PIN DIO ERROR ==========");
      print("Status Code: ${e.response?.statusCode}");
      print("Response: ${e.response?.data}");

      if (e.response != null) {
        if (e.response!.statusCode == 401) {
          await SecureStorageService.clearStorage();
          await SharedPreferencesService.clearAll();
          throw 'Unauthenticated. Please login again.';
        }

        final data = e.response!.data;
        if (data != null && data is Map<String, dynamic>) {
          if (data["errors"] != null && data["errors"] is Map) {
            String errorMessage = "";
            (data["errors"] as Map).forEach((key, value) {
              if (value is List && value.isNotEmpty) {
                errorMessage += "${value.first}\n";
              }
            });
            throw errorMessage.trim();
          }
          throw data['message'] ?? 'Failed to change PIN.';
        }
      }
      throw 'Unable to connect to server.';
    }
  }

  // ===== CHANGE PASSWORD =====
  Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final String? token = await SecureStorageService.getToken();

      final response = await _dio.post(
        '/change-password',
        data: {
          'current_password': currentPassword,
          'new_password': newPassword,
          'new_password_confirmation': confirmPassword,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            if (token != null && token.isNotEmpty)
              'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'message':
              response.data['message'] ?? 'Password changed successfully.',
        };
      }

      return {
        'success': false,
        'message': response.data['message'] ?? 'Failed to change password.',
      };
    } on DioException catch (e) {
      print("========== CHANGE PASSWORD DIO ERROR ==========");
      print("Status Code: ${e.response?.statusCode}");
      print("Response: ${e.response?.data}");

      if (e.response != null) {
        // Token သက်တမ်းကုန်သွားပါက Logout လုပ်ပေးခြင်း
        if (e.response!.statusCode == 401) {
          await SecureStorageService.clearStorage();
          await SharedPreferencesService.clearAll();
          return {
            'success': false,
            'unauthenticated': true,
            'message': 'Session expired. Please login again.',
          };
        }

        final data = e.response!.data;
        if (data != null && data is Map<String, dynamic>) {
          if (data["errors"] != null && data["errors"] is Map) {
            String errorMessage = "";
            (data["errors"] as Map).forEach((key, value) {
              if (value is List && value.isNotEmpty) {
                errorMessage += "${value.first}\n";
              }
            });
            return {'success': false, 'message': errorMessage.trim()};
          }
          return {
            'success': false,
            'message': data['message'] ?? 'Failed to change password.',
          };
        }
      }
      return {'success': false, 'message': 'Unable to connect to server.'};
    }
  }
}
