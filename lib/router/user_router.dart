import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smartcanteen/view/student_info_screen.dart';
import 'package:smartcanteen/view/wallet_info_screen.dart';

final router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(path: "/student_info",
    builder: (context, state) => const StudentInfoScreen(),
    ),
    GoRoute(path: "/wallet_info",
    builder: (context, state) => const WalletInfoScreen(),
    ),
    // GoRoute(path: "/student_info",
    // builder: (context, state) => const StudentInfoScreen(),
    // ),
  ],
  
  
  );

class UserRouter extends StatefulWidget {
  const UserRouter({super.key});

  @override
  State<UserRouter> createState() => _UserRouterState();
}

class _UserRouterState extends State<UserRouter> {
 
  @override
  void initState() {
    super.initState();
    //checkLogin();
  }

  // void checkLogin() async {
  //   final token = await SecureStore.getToken();
  //   await Future.delayed(const Duration(seconds: 1));

  //   if (!mounted) return;

  //   if (token != null) {
  //     context.go("/home");
  //   } else {
  //     context.go("/login");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}