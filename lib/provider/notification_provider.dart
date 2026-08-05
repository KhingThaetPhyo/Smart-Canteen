// // import 'package:flutter/material.dart';
// // import 'package:dio/dio.dart';
// // import 'package:smartcanteen/model/notification_model.dart';

// // class NotificationProvider extends ChangeNotifier {
// //   final List<NotificationModel> _notifications = [];
// //   bool _isLoading = false;

// //   List<NotificationModel> get notifications => _notifications;
// //   bool get isLoading => _isLoading;
// //   int get unreadCount => _notifications.where((n) => !n.isRead).length;

// //   /// Fetch notifications history from Backend API
// //   Future<void> fetchNotifications({required String userToken, required String baseUrl}) async {
// //     _isLoading = true;
// //     notifyListeners();

// //     try {
// //       final response = await Dio().get(
// //         '$baseUrl/notifications',
// //         options: Options(
// //           headers: {'Authorization': 'Bearer $userToken'},
// //         ),
// //       );

// //       if (response.statusCode == 200) {
// //         final List data = response.data['data'] ?? response.data;
// //         _notifications.clear();
// //         _notifications.addAll(data.map((item) => NotificationModel.fromJson(item)).toList());
// //       }
// //     } catch (e) {
// //       debugPrint('Error fetching notifications: $e');
// //     } finally {
// //       _isLoading = false;
// //       notifyListeners();
// //     }
// //   }

// //   /// Add new dynamic incoming FCM notification
// //   void addNotification(NotificationModel notification) {
// //     _notifications.insert(0, notification);
// //     notifyListeners();
// //   }

// //   // /// Mark single notification as read
// //   // void markAsRead(String id) {
// //   //   final index = _notifications.indexWhere((n) => n.id == id);
// //   //   if (index != -1) {
// //   //     _notifications[index].isRead = true;
// //   //     notifyListeners();
// //   //   }
// //   // }
// // // notification_provider.dart

// // /// Mark single notification as read
// // void markAsRead(int id) { // 👈 Change String to int
// //   final index = _notifications.indexWhere((n) => n.id == id);
// //   if (index != -1) {
// //     _notifications[index].isRead = true;
// //     notifyListeners();
// //   }
// // }
// //   /// Mark all as read
// //   void markAllAsRead() {
// //     for (var n in _notifications) {
// //       n.isRead = true;
// //     }
// //     notifyListeners();
// //   }
// // }
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:smartcanteen/model/notification_model.dart';

// class NotificationProvider extends ChangeNotifier {
//   List<NotificationModel> _notifications = [];
//   bool _isLoading = false;

//   List<NotificationModel> get notifications => _notifications;
//   bool get isLoading => _isLoading;
//   int get unreadCount => _notifications.where((n) => !n.isRead).length;

//   static const String _storageKey = 'cached_notifications';

//   NotificationProvider() {
//     _loadFromLocal(); // 👈 Load cached notifications on startup
//   }

//   /// Load cached notifications from SharedPreferences
//   Future<void> _loadFromLocal() async {
//     _isLoading = true;
//     notifyListeners();

//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final String? cachedData = prefs.getString(_storageKey);

//       if (cachedData != null) {
//         final List decodedList = jsonDecode(cachedData);
//         _notifications = decodedList
//             .map((item) => NotificationModel.fromJson(item))
//             .toList();
//       }
//     } catch (e) {
//       debugPrint('Error loading cached notifications: $e');
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   /// Save current list to SharedPreferences
//   Future<void> _saveToLocal() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final String encodedData = jsonEncode(
//         _notifications.map((n) => n.toJson()).toList(),
//       );
//       await prefs.setString(_storageKey, encodedData);
//     } catch (e) {
//       debugPrint('Error saving notifications locally: $e');
//     }
//   }

//   /// Fetch notifications history from Backend API
//   Future<void> fetchNotifications({
//     required String userToken,
//     required String baseUrl,
//   }) async {
//     _isLoading = true;
//     notifyListeners();

//     try {
//       final response = await Dio().get(
//         '$baseUrl/notifications',
//         options: Options(
//           headers: {'Authorization': 'Bearer $userToken'},
//         ),
//       );

//       if (response.statusCode == 200) {
//         final List data = response.data['data'] ?? response.data;
//         _notifications.clear();
//         _notifications.addAll(
//           data.map((item) => NotificationModel.fromJson(item)).toList(),
//         );
//         await _saveToLocal(); // Save newly fetched API data
//       }
//     } catch (e) {
//       debugPrint('Error fetching notifications: $e');
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   /// Add dynamic incoming FCM notification
//   void addNotification(NotificationModel notification) {
//     _notifications.insert(0, notification);
//     _saveToLocal();
//     notifyListeners();
//   }

//   /// Mark single notification as read
//   void markAsRead(int id) {
//     final index = _notifications.indexWhere((n) => n.id == id);
//     if (index != -1) {
//       _notifications[index].isRead = true;
//       _saveToLocal();
//       notifyListeners();
//     }
//   }

//   /// Mark all as read
//   void markAllAsRead() {
//     for (var n in _notifications) {
//       n.isRead = true;
//     }
//     _saveToLocal();
//     notifyListeners();
//   }

//   /// Delete notification by int ID
//   void deleteNotification(int id) {
//     _notifications.removeWhere((n) => n.id == id);
//     _saveToLocal();
//     notifyListeners();
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartcanteen/model/notification_model.dart';

class NotificationProvider extends ChangeNotifier {
  List<NotificationModel> _notifications = [];
  bool _isLoading = false;

  List<NotificationModel> get notifications => _notifications;
  bool get isLoading => _isLoading;

  // Calculate unread count and unread status directly from the notification list
  int get unreadCount => _notifications.where((n) => !n.isRead).length;
  bool get hasUnread => _notifications.any((n) => !n.isRead);

  static const String _storageKey = 'cached_notifications';

  NotificationProvider() {
    _loadFromLocal();
  }

  /// Load cached notifications from SharedPreferences
  Future<void> _loadFromLocal() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final String? cachedData = prefs.getString(_storageKey);

      if (cachedData != null) {
        final List decodedList = jsonDecode(cachedData);
        _notifications = decodedList
            .map((item) => NotificationModel.fromJson(item))
            .toList();
      }
    } catch (e) {
      debugPrint('Error loading cached notifications: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Save current list to SharedPreferences
  Future<void> _saveToLocal() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String encodedData = jsonEncode(
        _notifications.map((n) => n.toJson()).toList(),
      );
      await prefs.setString(_storageKey, encodedData);
    } catch (e) {
      debugPrint('Error saving notifications locally: $e');
    }
  }

  /// Fetch notifications history from Backend API
  Future<void> fetchNotifications({
    required String userToken,
    required String baseUrl,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await Dio().get(
        '$baseUrl/notifications',
        options: Options(
          headers: {'Authorization': 'Bearer $userToken'},
        ),
      );

      if (response.statusCode == 200) {
        final List data = response.data['data'] ?? response.data;
        _notifications.clear();
        _notifications.addAll(
          data.map((item) => NotificationModel.fromJson(item)).toList(),
        );
        await _saveToLocal();
      }
    } catch (e) {
      debugPrint('Error fetching notifications: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Add dynamic incoming FCM notification
  void addNotification(NotificationModel notification) {
    _notifications.insert(0, notification);
    _saveToLocal();
    notifyListeners();
  }

  /// Mark single notification as read
  void markAsRead(int id) {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notifications[index].isRead = true;
      _saveToLocal();
      notifyListeners();
    }
  }

  /// Mark all notifications as read
  void markAllAsRead() {
    for (var n in _notifications) {
      n.isRead = true;
    }
    _saveToLocal();
    notifyListeners();
  }

  /// Delete notification by ID
  void deleteNotification(int id) {
    _notifications.removeWhere((n) => n.id == id);
    _saveToLocal();
    notifyListeners();
  }
}