import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smartcanteen/model/user_model.dart';
import 'package:smartcanteen/navigation_bar.dart';
import 'package:smartcanteen/service/secure_storage_service.dart';
import 'package:smartcanteen/view/home/homescreen.dart';
// import 'package:smartcanteen/view/homescreen.dart';
import 'package:smartcanteen/view/loginscreen.dart';
import 'package:smartcanteen/view/notification_screen.dart';
import 'package:smartcanteen/view/orderscreen.dart';
import 'package:smartcanteen/view/profilescreen.dart';
import 'package:smartcanteen/view/qr_scanner_screen.dart';
import 'package:smartcanteen/view/register_screen.dart';
import 'package:smartcanteen/view/search_screen.dart';
import 'package:smartcanteen/view/splash_screen.dart';
import 'package:smartcanteen/view/student_info_screen.dart';
import 'package:smartcanteen/view/user_qr_screen.dart';
import 'package:smartcanteen/view/wallet_info_screen.dart';
import 'package:smartcanteen/view/wallet_screen.dart';

final router = GoRouter(
  initialLocation: '/navigation',

  // // Check token when app opens
  // redirect: (context, state) async {
  //   final token = await SecureStorageService.getToken();

  //   final isLoggedIn = token != null && token.isNotEmpty;
  //   final isAuthPage = state.matchedLocation == '/login' ||
  //       state.matchedLocation == '/register';

  //   // If logged in, don't allow login/register page
  //   if (isLoggedIn && isAuthPage) {
  //     return '/navigation';
  //   }

  //   // If not logged in, don't allow home page
  //   if (!isLoggedIn && state.matchedLocation == '/navigation') {
  //     return '/login';
  //   }

  //   return null;
  // },
redirect: (context, state) async {

  final token = await SecureStorageService.getToken();

  final isLoggedIn =
      token != null && token.isNotEmpty;


  if (isLoggedIn &&
      state.matchedLocation == '/navigation') {

    return '/navigation';
  }


  if (!isLoggedIn &&
      state.matchedLocation == '/navigation') {

    return '/navigation';
  }


  return null;
},
  routes: [
    GoRoute(
  path: '/splash',
  builder: (context, state) => const SplashScreen(),
),
    GoRoute(
      path: '/login',
      builder: (context, state) => const Loginscreen(),
    ),
     GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/student_info',
      builder: (context, state) {
        final user = state.extra as UserModel?;

        if (user == null) {
          return const Scaffold(
            body: Center(child: Text('User data not found')),
          );
        }

        return StudentInfoScreen(user: user);
      },
    ),
    GoRoute(
      path: '/wallet_info',
      builder: (context, state) {
        final user = state.extra as UserModel?;

        if (user == null) {
          return const Scaffold(
            body: Center(child: Text('User data not found')),
          );
        }

        return WalletInfoScreen(user: user);
      },
    ),
   
    // GoRoute(
    //   path: '/home',
    //   //builder: (context, state) => const Homescreen(user: null,),
    //   builder: (context, state) {
    //     final user = state.extra as UserModel?;

    //     if (user == null) {
    //       return const Scaffold(
    //         body: Center(child: Text('User data not found')),
    //       );
    //     }

    //     return Homescreen(user: user);
    //   },
    // ),
     GoRoute(
      path: '/home',
      builder: (context, state) => const Homescreen(),
    ),
//     GoRoute(
//   path: '/navigation',
//   builder: (context, state) {
//     final data = state.extra as Map<String, dynamic>?;


//     if (data == null) {
//       return const Scaffold(
//         body: Center(
//           child: Text('Navigation data not found'),
//         ),
//       );
//     }

//     return MainNavigation(
//       user: data['user'] as UserModel,
//       qrData: data['qrData'] as String?,
//     );
//   },
// ),
GoRoute(
  path: '/navigation',
  builder: (context, state) {

    final data =
        state.extra as Map<String, dynamic>?;


    if (data != null) {
      return MainNavigation(
        // user: data['user'] as UserModel,
        // qrData: data['qrData'] as String?,
      );
    }


    return FutureBuilder(
      future: SecureStorageService.getUser(),
      builder: (context, snapshot) {

        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }


        final userJson =
            jsonDecode(snapshot.data!);


        final user =
            UserModel.fromJson(userJson);


        return FutureBuilder<String?>(
          future: SecureStorageService.getQrData(),
          builder: (context, qrSnapshot) {

            return MainNavigation(
              // user: user,
              // qrData: qrSnapshot.data,
            );

          },
        );
      },
    );
  },
),
    GoRoute(
  path: '/user_qr',
  builder: (context, state) {
    final qrData = state.extra as String? ?? '';

    return UserQrScreen(qrData: qrData);
  },
),
GoRoute(
  path: '/scan_qr',
  builder: (context, state) => const QrScannerScreen(),
),
GoRoute(
  path: '/noti',
  builder: (context, state) => const NotificationScreen(),
),
GoRoute(
  path: '/search',
  builder: (context, state) => const SearchScreen(),
),
// GoRoute(
//   path: '/navigation',
//   builder: (context, state) {

//     final qrData = state.extra as String? ?? '';
//     return MainNavigation(
//       qrData: qrData,
//     );
//   },
// ),

    GoRoute(
      path: '/order',
      builder: (context, state) => const OrderScreen(),
    ),
    GoRoute(
      path: '/wallet',
      builder: (context, state) => const WalletScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
  ],
);

class UserRouter extends StatefulWidget {
  const UserRouter({super.key});

  @override
  State<UserRouter> createState() => _UserRouterState();
}

class _UserRouterState extends State<UserRouter> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}