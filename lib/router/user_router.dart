import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smartcanteen/view/loginscreen.dart';
import 'package:smartcanteen/view/register_screen.dart';
import 'package:smartcanteen/navigation/main_navigation.dart';

final router = GoRouter(
  initialLocation: '/home',

  errorBuilder: (context, state) => const NotFoundScreen(),

  routes: [
    //------------------------------------------------
    // LOGIN
    //------------------------------------------------
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) =>
          FadeTransitionPage(child: const Loginscreen()),
    ),

    //------------------------------------------------
    // REGISTER
    //------------------------------------------------
    GoRoute(
      path: '/register',
      pageBuilder: (context, state) =>
          FadeTransitionPage(child: const RegisterScreen()),
    ),

    //------------------------------------------------
    // MAIN APP (BOTTOM NAVIGATION)
    //------------------------------------------------
    GoRoute(
      path: '/home',
      pageBuilder: (context, state) =>
          FadeTransitionPage(child: const MainNavigation()),
    ),
  ],
);

/// =====================================================
/// FADE ANIMATION
/// =====================================================

class FadeTransitionPage extends CustomTransitionPage {
  FadeTransitionPage({required Widget child})
    : super(
        child: child,
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      );
}

/// =====================================================
/// 404 PAGE
/// =====================================================

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Smart Canteen")),
      body: const Center(
        child: Text(
          "404\nPage Not Found",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
