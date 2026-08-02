// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:smartcanteen/router/user_router.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Firebase initialization
//   await Firebase.initializeApp();

//   // Notification permission
//   await FirebaseMessaging.instance.requestPermission();

//   // Enable Edge-to-Edge display mode
//   await SystemChrome.setEnabledSystemUIMode(
//     SystemUiMode.edgeToEdge,
//   );

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: const SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent, // Removes top white bar
//         systemNavigationBarColor: Colors.transparent, // Removes bottom white bar
//         statusBarIconBrightness: Brightness.light, // White status icons
//         systemNavigationBarIconBrightness: Brightness.dark,
//       ),
//       child: MaterialApp.router(
//         debugShowCheckedModeBanner: false,

//         theme: ThemeData(
//           useMaterial3: true,
//           textTheme: GoogleFonts.latoTextTheme(
//             Theme.of(context).textTheme,
//           ),
//           colorScheme: ColorScheme.fromSeed(
//             seedColor: const Color(0xFF4CAF50),
//             brightness: Brightness.light,
//           ),

//           scaffoldBackgroundColor: const Color(0xFFF8F9FA),

//           appBarTheme: const AppBarTheme(
//             backgroundColor: Colors.white,
//             elevation: 0,
//             centerTitle: true,
//             foregroundColor: Colors.black,
//           ),

//           cardTheme: CardThemeData(
//             elevation: 3,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(16),
//             ),
//           ),

//           inputDecorationTheme: InputDecorationTheme(
//             border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//           ),
//         ),

//         // Remove top padding globally so color fills behind status bar
//         builder: (context, child) {
//           return MediaQuery(
//             data: MediaQuery.of(context).copyWith(
//               padding: MediaQuery.of(context).padding.copyWith(top: 0),
//             ),
//             child: child!,
//           );
//         },

//         routerConfig: router,
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:smartcanteen/fcm_helper.dart';
// import 'package:smartcanteen/notification_service.dart';
// import 'package:smartcanteen/provider/user_provider.dart';
// import 'package:smartcanteen/router/user_router.dart';

// // Background တွင် Notification လက်ခံရန် Handler
// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   debugPrint("Background message received: ${message.messageId}");
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
 
//   // // Firebase initialization
//   await Firebase.initializeApp();
// await NotificationService.initialize();
//   // // Notification permission
//   // await FirebaseMessaging.instance.requestPermission();
// // Firebase စတင်ခြင်း[cite: 1]
 

//   // Background Message Handler ချိတ်ဆက်ခြင်း
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//   // FCM Token နှင့် Notification Permission တောင်းခံခြင်း
//   await FcmHelper.getToken();
//   // Hide ONLY top status bar (removes clock, battery, notifications)
//   await SystemChrome.setEnabledSystemUIMode(
//     SystemUiMode.manual,
//     overlays: [SystemUiOverlay.bottom],
//   );

//   //runApp(const MyApp());
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => UserProvider()),
//         // Add other providers here if needed
//       ],
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: const SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent,
//         systemNavigationBarColor: Colors.transparent,
//         systemNavigationBarIconBrightness: Brightness.dark,
//       ),
//       child: MaterialApp.router(
//         debugShowCheckedModeBanner: false,

//         theme: ThemeData(
//           useMaterial3: true,
//           textTheme: GoogleFonts.latoTextTheme(
//             Theme.of(context).textTheme,
//           ),
//           colorScheme: ColorScheme.fromSeed(
//             seedColor: const Color(0xFF4CAF50),
//             brightness: Brightness.light,
//           ),

//           scaffoldBackgroundColor: const Color(0xFFF8F9FA),

//           appBarTheme: const AppBarTheme(
//             backgroundColor: Colors.white,
//             elevation: 0,
//             centerTitle: true,
//             foregroundColor: Colors.black,
//           ),

//           cardTheme: CardThemeData(
//             elevation: 3,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(16),
//             ),
//           ),

//           inputDecorationTheme: InputDecorationTheme(
//             border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//           ),
//         ),

//         // Remove top padding globally so background fills to the physical screen top
//         builder: (context, child) {
//           return MediaQuery(
//             data: MediaQuery.of(context).copyWith(
//               padding: MediaQuery.of(context).padding.copyWith(top: 0),
//             ),
//             child: child!,
//           );
//         },

//         routerConfig: router,
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smartcanteen/fcm_helper.dart';
import 'package:smartcanteen/notification_service.dart';
import 'package:smartcanteen/provider/notification_provider.dart';
import 'package:smartcanteen/provider/user_provider.dart';
import 'package:smartcanteen/router/user_router.dart';

// Background တွင် Notification လက်ခံရန် Handler
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.requestPermission();
  debugPrint("Background message received: ${message.messageId}");
}
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 
  // 1. Firebase Initialization
  await Firebase.initializeApp();

  // 2. Notification Service & Background Handler Initialized
  await NotificationService.initialize();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // 3. FCM Token ယူခြင်း
  await FcmHelper.getToken();

  // 4. Status Bar & Navigation Bar UI
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Transparent status bar
      statusBarIconBrightness: Brightness.dark, // Dark icons for light theme
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

    // Hide ONLY top status bar (removes clock, battery, notifications)
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom],
  );

  runApp(
    MultiProvider(
      // providers: [
      //   ChangeNotifierProvider(create: (_) => UserProvider()),
      //   // အခြား Providers များရှိပါက ဒီမှာ ထပ်တိုးနိုင်ပါသည်။
      // ],
      providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => NotificationProvider()), // Added here
    ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      key: navigatorKey, // or routerConfig with navigatorKey
      debugShowCheckedModeBanner: false,
      title: 'Smart Canteen',

      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4CAF50),
          brightness: Brightness.light,
        ),

        scaffoldBackgroundColor: const Color(0xFFF8F9FA),

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          foregroundColor: Colors.black,
        ),

        cardTheme: CardThemeData(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),

      routerConfig: router,
    );
  }
}