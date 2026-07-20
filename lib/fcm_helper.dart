import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class FcmHelper {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  /// 🎯 FCM Token ကို တောင်းယူပေးမည့် Function
  static Future<String?> getToken() async {
    try {
      // Notification Permission တောင်းခံခြင်း (iOS & Android 13+)
      NotificationSettings settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        // FCM Token ကို Firebase ဆီမှ တောင်းယူခြင်း
        String? token = await _messaging.getToken();
        debugPrint("🔥 Device FCM Token: $token");
        return token;
      } else {
        debugPrint("⚠️ User Notification Permission ငြင်းပယ်ခဲ့ပါသည်။");
        return null;
      }
    } catch (e) {
      debugPrint("❌ FCM Token ယူရာတွင် Error တက်ပါသည်: $e");
      return null;
    }
  }
}

