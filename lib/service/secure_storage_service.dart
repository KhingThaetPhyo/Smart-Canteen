import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static const String tokenKey = 'auth_token';
  static const String fcmTokenKey = 'fcm_token';

  // Save auth token
  static Future<void> saveToken(String token) async {
    await _storage.write(key: tokenKey, value: token);
  }

  // Get auth token
  static Future<String?> getToken() async {
    return await _storage.read(key: tokenKey);
  }

  // Save FCM token
  static Future<void> saveFcmToken(String token) async {
    await _storage.write(key: fcmTokenKey, value: token);
  }

  // Get FCM token
  static Future<String?> getFcmToken() async {
    return await _storage.read(key: fcmTokenKey);
  }

  // Clear all data on logout
  static Future<void> clearStorage() async {
    await _storage.delete(key: tokenKey);
    await _storage.delete(key: fcmTokenKey);
  }

  static Future<void> saveQrData(String qrData) async {
  await _storage.write(
    key: "qr_data",
    value: qrData,
  );
}


static Future<String?> getQrData() async {
  return await _storage.read(
    key: "qr_data",
  );
}
}