// // lib/main.dart
// import 'package:flutter/material.dart';
// import 'package:smartcanteen/router/user_router.dart';
// import 'package:smartcanteen/view/homescreen.dart';
// import 'package:smartcanteen/view/register_screen.dart';
// import 'package:smartcanteen/view/wallet_info_screen.dart';
// import 'view/loginscreen.dart'; // import လမ်းကြောင်းအသစ်

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//        routerConfig: router,
//       home: const RegisterScreen(), // Widget Class နာမည်အသစ်ကို ခေါ်သုံးထားခြင်း
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:smartcanteen/router/user_router.dart';

void main() {
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