import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smartcanteen/model/user_model.dart';
import 'package:smartcanteen/view/homescreen.dart';
import 'package:smartcanteen/view/loginscreen.dart';
import 'package:smartcanteen/view/register_screen.dart';
import 'package:smartcanteen/view/student_info_screen.dart';
import 'package:smartcanteen/view/wallet_info_screen.dart';

final router = GoRouter(
  initialLocation: "/login",
  routes: [
    GoRoute(
      path: "/login",
      builder: (context, state) => const Loginscreen(),
    ),
    GoRoute(
      path: "/home",
      builder: (context, state) => const Homescreen(),
    ),
//     GoRoute(
//   path: "/student_info",
//   builder: (context, state) {

//     final user = state.extra as UserModel;

//     return StudentInfoScreen(
//       user: user,
//     );
//   },
// ),
//     GoRoute(
//       path: "/wallet_info",
//       builder: (context, state) {

//     final user = state.extra as UserModel;

//     return WalletInfoScreen(
//       user: user,
//     );
//   },
//     ),
GoRoute(
  path: "/student_info",
  builder: (context, state) {
    final user = state.extra as UserModel?;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("User data not found")),
      );
    }

    return StudentInfoScreen(user: user);
  },
),

GoRoute(
  path: "/wallet_info",
  builder: (context, state) {
    final user = state.extra as UserModel?;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("User data not found")),
      );
    }

    return WalletInfoScreen(user: user);
  },
),
    GoRoute(path: "/register",
    builder: (context, state) => const RegisterScreen(),
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
