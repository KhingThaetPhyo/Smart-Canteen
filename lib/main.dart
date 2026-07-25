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
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartcanteen/router/user_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase initialization
  await Firebase.initializeApp();

  // Notification permission
  await FirebaseMessaging.instance.requestPermission();

  // Hide ONLY top status bar (removes clock, battery, notifications)
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom],
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,

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

        // Remove top padding globally so background fills to the physical screen top
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              padding: MediaQuery.of(context).padding.copyWith(top: 0),
            ),
            child: child!,
          );
        },

        routerConfig: router,
      ),
    );
  }
}