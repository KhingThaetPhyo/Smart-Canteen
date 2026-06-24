// lib/main.dart
import 'package:flutter/material.dart';
import 'package:smartcanteen/view/homescreen.dart';
import 'view/loginscreen.dart'; // import လမ်းကြောင်းအသစ်

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(), // Widget Class နာမည်အသစ်ကို ခေါ်သုံးထားခြင်း
    );
  }
}
