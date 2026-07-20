import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:smartcanteen/router/user_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase ကို initialize လုပ်ခြင်း
  await Firebase.initializeApp();

  // Notification permission တောင်းခြင်း (optional)
  await FirebaseMessaging.instance.requestPermission();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}