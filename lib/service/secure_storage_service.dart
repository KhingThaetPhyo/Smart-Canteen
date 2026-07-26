// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class SecureStorageService {
//   static const FlutterSecureStorage _storage = FlutterSecureStorage();

//   static const String tokenKey = 'auth_token';
//   static const String fcmTokenKey = 'fcm_token';

//   // Save auth token
//   static Future<void> saveToken(String token) async {
//     await _storage.write(key: tokenKey, value: token);
//   }

//   // Get auth token
//   static Future<String?> getToken() async {
//     return await _storage.read(key: tokenKey);
//   }

//   // Save FCM token
//   static Future<void> saveFcmToken(String token) async {
//     await _storage.write(key: fcmTokenKey, value: token);
//   }

//   // Get FCM token
//   static Future<String?> getFcmToken() async {
//     return await _storage.read(key: fcmTokenKey);
//   }

//   // Clear all data on logout
//   static Future<void> clearStorage() async {
//     await _storage.delete(key: tokenKey);
//     await _storage.delete(key: fcmTokenKey);
//   }

//   static Future<void> saveQrData(String qrData) async {
//   await _storage.write(
//     key: "qr_data",
//     value: qrData,
//   );
// }


// static Future<String?> getQrData() async {
//   return await _storage.read(
//     key: "qr_data",
//   );
// }
// }
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  // Configured options to avoid common Keychain / EncryptedSharedPreferences crashes
  static const FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );

  // Storage Keys
  static const String _tokenKey = 'auth_token';
  static const String _fcmTokenKey = 'fcm_token';
  static const String _qrDataKey = 'qr_data';

  // --- Auth Token Methods ---
  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }

  // --- FCM Token Methods ---
  static Future<void> saveFcmToken(String token) async {
    await _storage.write(key: _fcmTokenKey, value: token);
  }

  static Future<String?> getFcmToken() async {
    return await _storage.read(key: _fcmTokenKey);
  }

  static Future<void> deleteFcmToken() async {
    await _storage.delete(key: _fcmTokenKey);
  }

  // --- QR Data Methods ---
  static Future<void> saveQrData(String qrData) async {
    await _storage.write(key: _qrDataKey, value: qrData);
  }

  static Future<String?> getQrData() async {
    return await _storage.read(key: _qrDataKey);
  }

  static Future<void> deleteQrData() async {
    await _storage.delete(key: _qrDataKey);
  }

  // --- Storage Utility Methods ---

  /// Clears ALL stored keys in one operation (best for full logout reset)
  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  /// Clears user session data (like auth token and QR data) 
  /// while optionally keeping device-specific tokens like FCM if needed.
  static Future<void> clearUserSession({bool keepFcmToken = false}) async {
    if (keepFcmToken) {
      await _storage.delete(key: _tokenKey);
      await _storage.delete(key: _qrDataKey);
    } else {
      await clearAll();
    }
  }
}