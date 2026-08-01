import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smartcanteen/model/shop_model.dart';
import 'package:smartcanteen/model/transaction_model.dart';
import 'package:smartcanteen/model/user_model.dart';
import 'package:smartcanteen/navigation_bar.dart';
import 'package:smartcanteen/service/secure_storage_service.dart';
import 'package:smartcanteen/view/favourite_screen.dart';
import 'package:smartcanteen/view/home/home_header.dart';
import 'package:smartcanteen/view/home/homescreen.dart';
import 'package:smartcanteen/view/home/shop.dart';
import 'package:smartcanteen/view/loginscreen.dart';
import 'package:smartcanteen/view/notification_screen.dart';
import 'package:smartcanteen/view/order_screen.dart';
import 'package:smartcanteen/view/profile_screen.dart';
import 'package:smartcanteen/view/qr_scanner_screen.dart';
import 'package:smartcanteen/view/register_screen.dart';
import 'package:smartcanteen/view/search_screen.dart';
import 'package:smartcanteen/view/shop_detail_screen.dart';
import 'package:smartcanteen/view/splash_screen.dart';
import 'package:smartcanteen/view/student_info_screen.dart';
import 'package:smartcanteen/view/transaction_detail_screen.dart';
import 'package:smartcanteen/view/transactoin_history_screen.dart';
import 'package:smartcanteen/view/transfer_point_screen.dart';
import 'package:smartcanteen/view/user_qr_screen.dart';
import 'package:smartcanteen/view/wallet_info_screen.dart';
import 'package:smartcanteen/view/wallet_screen.dart';

final router = GoRouter(
  initialLocation: '/splash',

  // Check token and redirect appropriately
  redirect: (context, state) async {
    final token = await SecureStorageService.getToken();
    final isLoggedIn = token != null && token.isNotEmpty;
    
    final matchedLocation = state.matchedLocation;
    const splashPath = '/splash';
    const loginPath = '/login';
    const registerPath = '/register';
    const navPath = '/navigation';

    // 1. Let the splash screen render and run its internal timer/logic
    if (matchedLocation == splashPath) {
      return null;
    }

    // 2. Prevent logged-in users from going back to login/register pages
    if (isLoggedIn && (matchedLocation == loginPath || matchedLocation == registerPath)) {
      return navPath;
    }

    return null;
  },
// final router = GoRouter(
//   initialLocation: '/splash',

//   // Check token when app opens
//   redirect: (context, state) async {
//     final token = await SecureStorageService.getToken();

//     final isLoggedIn = token != null && token.isNotEmpty;
//     final isAuthPage = state.matchedLocation == '/login' ||
//         state.matchedLocation == '/register';

//     // If logged in, don't allow login/register page
//     if (isLoggedIn && isAuthPage) {
//       return '/navigation';
//     }

//     // If not logged in, don't allow home page
//     if (!isLoggedIn && state.matchedLocation == '/navigation') {
//       return '/navigation';
//     }

//     return null;
//   },

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
      path: '/home',
      builder: (context, state) => const Homescreen(),
    ),
    GoRoute(
      path: '/home_header',
      builder: (context, state) => const Scaffold(
        body: SafeArea(child: HomeHeader()),
      ),
    ),
    // GoRoute(
    //   path: '/recent_order',
    //   builder: (context, state) => Scaffold(
    //     appBar: AppBar(title: const Text("Recent Orders")),
    //     body: const Center(child: Text("Recent Order Screen")),
    //   ),
    // ),
    // GoRoute(
    //   path: '/menu_section',
    //   builder: (context, state) => Scaffold(
    //     body: SafeArea(child: SingleChildScrollView(child: PopularMenuCard())),
    //   ),
    // ),
    GoRoute(
      path: '/shop',
      builder: (context, state) {
        final shopModel = state.extra as ShopModel?;
        if (shopModel == null) {
          return const Scaffold(
            body: Center(child: Text('Shop data not found')),
          );
        }
        return Scaffold(
          appBar: AppBar(title: Text(shopModel.shopName)),
          body: ShopCard(
            shopName: shopModel.shopName,
            category: shopModel.shopPhone ?? '',
            isOpen: shopModel.isOpen == 1,
            estimatedTime: "10-15 min",
          ),
        );
      },
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
//     GoRoute(
//   path: '/shop_detail',
//   builder: (context, state) => const ShopDetailScreen(shopName: 'Mon',),
// ),
GoRoute(
      path: '/shop_detail/:id',
      builder: (context, state) {
        final shopModel = state.extra as ShopModel?;

        if (shopModel == null) {
          return const Scaffold(
            body: Center(child: Text('Shop data not found')),
          );
        }

        return ShopDetailScreen(shopName: shopModel.shopName,shopId: shopModel.shopId,);
      },
    ),
//   GoRoute(
//   path: '/shop_detail',
//   builder: (context, state) => const ShopDetailScreen(shopName: 'Mon',),
// ),
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
GoRoute(
  path: '/navigation',
  builder: (context, state) {

    final qrData = state.extra as String? ?? '';
    return MainNavigation(
      qrData: qrData,
    );
  },
),
    GoRoute(
      path: '/order',
      builder: (context, state) =>  OrdersScreen(),
    ),
    GoRoute(
      path: '/wallet',
      builder: (context, state) => const WalletScreen(),
    ),
    GoRoute(
      path: '/transfer_point',
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>?;
        if (args == null) {
          return const Scaffold(
            body: Center(child: Text('Transfer parameters not provided')),
          );
        }
        return TransferPointScreen(
          currentBalance: args['currentBalance'] as int,
          onTransferCompleted: args['onTransferCompleted'] as Function(int, String),
        );
      },
    ),
    GoRoute(
      path: '/transaction_history',
      builder: (context, state) {
        //final transactions = state.extra as List<TransactionModel>? ?? [];
        return TransactionHistoryScreen();
      },
    ),
    // GoRoute(
    //   path: '/transaction_detail',
    //   builder: (context, state) {
    //     final transaction = state.extra as TransactionModel?;
    //     if (transaction == null) {
    //       return const Scaffold(
    //         body: Center(child: Text('Transaction data not found')),
    //       );
    //     }
    //     return TransactionDetailScreen(transaction: transaction, currentWalletId: transaction.w,);
    //   },
    // ),
    GoRoute(
      path: '/transaction_detail',
      builder: (context, state) {
        final transaction = state.extra as TransactionModel?;
        if (transaction == null) {
          return const Scaffold(
            body: Center(child: Text('Transaction data not found')),
          );
        }
        
        // ဥပမာ - fromWalletId ကို လက်ရှိ user အဖြစ် သတ်မှတ်ခြင်း သို့မဟုတ် app state မှ ယူသုံးခြင်း
        final int currentWalletId = transaction.fromWalletId ?? 0; 

        return TransactionDetailScreen(
          transaction: transaction, 
          //currentWalletId: currentWalletId,
        );
      },
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/favourite',
      builder: (context, state) => const FavouriteScreen(),
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