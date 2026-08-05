// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:smartcanteen/view/home/homescreen.dart';

// // import 'package:smartcanteen/view/home_screen.dart';
// // import 'package:smartcanteen/view/orders_screen.dart';
// import 'package:smartcanteen/view/orderscreen.dart';
// import 'package:smartcanteen/view/qr_scanner_screen.dart';
// // import 'package:smartcanteen/view/scanner_screen.dart';
// import 'package:smartcanteen/view/user_qr_screen.dart';
// import 'package:smartcanteen/view/wallet_screen.dart';
// import 'package:smartcanteen/view/profilescreen.dart';

// class MainNavigation extends StatefulWidget {
//   const MainNavigation({super.key});

//   @override
//   State<MainNavigation> createState() => _MainNavigationState();
// }

// class _MainNavigationState extends State<MainNavigation> {
//   int currentIndex = 0;
  
//   static const Color primaryColor = Color(0xFF117992);

//   // Route mapping for GoRouter
//   final List<String> routes = const [
//     '/home', // Index 0
//     '/order', // Index 1
//     '/user_qr', // Index 2
//     '/wallet', // Index 3
//     '/profile', // Index 4
//   ];

//   // Screens for each tab
//   final List<Widget> screens = [
//      Homescreen(), // Index 0
//      OrderScreen(), // Index 1
//     QrScannerScreen(), // Index 2
//      WalletScreen(), // Index 3
//      ProfileScreen(), // Index 4
//   ];
  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       extendBody: true,
//       body: Stack(
//         children: [
//           /// SHOW CURRENT SCREEN
//           IndexedStack(
//             index: currentIndex,
//             children: screens,
//           ),

//           /// FROSTED GLASS NAV BAR
//           Positioned(
//             left: 16,
//             right: 16,
//             bottom: 20,
//             child: _buildGlassNavigationBar(),
//           ),

//           /// CENTER FLOATING SCANNER BUTTON
//           Positioned(
//             bottom: 38,
//             left: 0,
//             right: 0,
//             child: Center(child: _buildCenterScannerButton()),
//           ),
//         ],
//       ),
//     );
//   }

//   /// FROSTED GLASS NAVIGATION BAR
//   Widget _buildGlassNavigationBar() {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(30),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
//         child: Container(
//           height: 66,
//           decoration: BoxDecoration(
//             color: const Color(0xFF0C5470).withOpacity(0.75),
//             borderRadius: BorderRadius.circular(30),
//             border: Border.all(
//               color: Colors.white.withOpacity(0.2),
//               width: 1.2,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.12),
//                 blurRadius: 20,
//                 offset: const Offset(0, 8),
//               ),
//             ],
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               _buildBottomNavItem(Icons.home_rounded, 'Home', 0),
//               _buildBottomNavItem(Icons.receipt_long_rounded, 'Orders', 1),

//               const SizedBox(width: 48), // Gap for middle Scanner button

//               _buildBottomNavItem(
//                 Icons.account_balance_wallet_rounded,
//                 'Wallet',
//                 3,
//               ),
//               _buildBottomNavItem(Icons.person_rounded, 'Profile', 4),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   /// ELEVATED MIDDLE SCANNER BUTTON
//   Widget _buildCenterScannerButton() {
//     final isScannerActive = currentIndex == 2;

//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           currentIndex = 2;
//         });
//         context.go(routes[2]); // Go to /scanner
//       },
//       child: Container(
//         height: 60,
//         width: 60,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           gradient: const LinearGradient(
//             colors: [Color(0xFF0D6B80), Color(0xFF117992)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           border: Border.all(
//             color: isScannerActive
//                 ? Colors.white
//                 : Colors.white.withOpacity(0.8),
//             width: 3,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: primaryColor.withOpacity(0.4),
//               blurRadius: 14,
//               offset: const Offset(0, 6),
//             ),
//           ],
//         ),
//         child: const Center(
//           child: Icon(
//             Icons.qr_code_scanner_rounded,
//             color: Colors.white,
//             size: 26,
//           ),
//         ),
//       ),
//     );
//   }

//   /// NAV ITEM BUILDER
//   Widget _buildBottomNavItem(IconData icon, String label, int index) {
//     final isActive = currentIndex == index;
//     final color = isActive ? Colors.white : Colors.white.withOpacity(0.5);

//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           currentIndex = index;
//         });
//         context.go(routes[index]); // Navigate with GoRouter
//       },
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//         decoration: BoxDecoration(
//           color: isActive ? Colors.white.withOpacity(0.15) : Colors.transparent,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, color: color, size: 22),
//             const SizedBox(height: 3),
//             Text(
//               label,
//               style: TextStyle(
//                 color: color,
//                 fontSize: 10,
//                 fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:smartcanteen/service/secure_storage_service.dart';
import 'package:smartcanteen/view/favourite_screen.dart';
// import 'package:smartcanteen/view/home/home_screen.dart';
import 'package:smartcanteen/view/home/homescreen.dart';
// import 'package:smartcanteen/view/orders/orders_screen.dart';
import 'package:smartcanteen/view/order_screen.dart';
// import 'package:smartcanteen/view/scanner/scanner_screen.dart';
// import 'package:smartcanteen/view/wallet/wallet_screen.dart'; // Updated import
import 'package:smartcanteen/view/profile_screen.dart';

class MainNavigation extends StatefulWidget {

  final String? qrData;

  const MainNavigation({
    super.key,
    this.qrData,
  });

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

 
class _MainNavigationState extends State<MainNavigation> {
 int currentIndex = 0;
String? qrData;

@override
void initState() {
  super.initState();
  _hideStatusBar();

  qrData = widget.qrData;

  print("Widget QR = $qrData");

  _loadQrData();
}
void _hideStatusBar() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom], // Hides the top status bar
    );
  }
Future<void> _loadQrData() async {

  if (qrData == null || qrData!.isEmpty) {

    final savedQr =
        await SecureStorageService.getQrData();

    print("Saved QR from storage = $savedQr");

    if(savedQr != null){

      setState(() {
        qrData = savedQr;
      });
    }
  }
}
  static const Color primaryColor = Color(0xff117992);

  // Index mapping:
  // 0: Home
  // 1: Orders
  // 2: Scanner (Center Button)
  // 3: Wallet
  // 4: Profile
  // final List<Widget> screens = const [
  //   Homescreen(), // Index 0
  //   OrdersScreen(), // Index 1
  //   //QrScannerScreen(), // Index 2
  //   SizedBox.shrink(),
  //   FavouriteScreen(), // Index 3
  //   ProfileScreen(), // Index 4
  // ];

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     resizeToAvoidBottomInset: false, // <-- PREVENTS NAV BAR FROM RISING WITH KEYBOARD
  //     backgroundColor: Color(0xff117992),
  //     extendBody: true,
  //     body: Stack(
  //       children: [
  //         /// PAGES
  //         IndexedStack(index: currentIndex, children: screens),

  //         /// FROSTED GLASS NAV BAR
  //         Positioned(
  //           left: 16,
  //           right: 16,
  //           bottom: 20,
  //           child: _buildGlassNavigationBar(),
  //         ),

  //         /// CENTER FLOATING SCANNER BUTTON
  //         Positioned(
  //           bottom: 38,
  //           left: 0,
  //           right: 0,
  //           child: Center(child: _buildCenterScannerButton()),
  //         ),
  //       ],
  //     ),
  //   );
  // }
// Inside navigation_bar.dart -> build method
@override
  Widget build(BuildContext context) {
    // 1. Move or define your screens list here so it can use the callback
    final List<Widget> screens = [
      Homescreen(
        onSeeAllOrdersPressed: () {
          setState(() {
            currentIndex = 1; // Switches to OrdersScreen tab safely
          });
        },
      ), // Index 0
      const OrdersScreen(), // Index 1
      const SizedBox.shrink(), // Index 2 (Center Scanner Button)
      const FavouriteScreen(), // Index 3
      const ProfileScreen(), // Index 4
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:  Color(0xff0D6B80),
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            /// RENDER ONLY THE CURRENT ACTIVE SCREEN SAFELY
            Positioned.fill(
              child: KeyedSubtree(
                key: ValueKey<int>(currentIndex),
                child: screens[currentIndex > 4 ? 0 : currentIndex],
              ),
            ),

            /// FROSTED GLASS NAV BAR
            Positioned(
              left: 16,
              right: 16,
              bottom: 20,
              child: _buildGlassNavigationBar(),
            ),

            /// CENTER FLOATING SCANNER BUTTON
            Positioned(
              bottom: 38,
              left: 0,
              right: 0,
              child: Center(child: _buildCenterScannerButton()),
            ),
          ],
        ),
      ),
    );
  }
  /// FROSTED GLASS NAVIGATION BAR
  Widget _buildGlassNavigationBar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          height: 66,
          decoration: BoxDecoration(
            color: const Color(0xFF0C5470),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBottomNavItem(Icons.home_rounded, "ပင်မ", 0),
              _buildBottomNavItem(Icons.receipt_long_rounded, "အော်ဒါ", 1),

              const SizedBox(width: 48), // Gap for middle Scanner button

              _buildBottomNavItem(
                Icons.favorite_outline_rounded,
                "နှစ်သက်သော",
                3,
              ),
              _buildBottomNavItem(Icons.person_rounded, "ပရိုဖိုင်", 4),
            ],
          ),
        ),
      ),
    );
  }

  /// ELEVATED MIDDLE SCANNER BUTTON
 Widget _buildCenterScannerButton() {
  final isScannerActive = currentIndex == 2;

  return GestureDetector(
    onTap: () {

 if(qrData != null){

 context.go(
   '/scan_qr',
   extra: qrData,
 );

}
else{

 ScaffoldMessenger.of(context)
 .showSnackBar(
   const SnackBar(
     content: Text(
       "QR data not found",
     ),
   ),
 );

}

},
    child: Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [Color(0xFF0D6B80), Color(0xFF117992)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: isScannerActive
              ? Colors.white
              : Colors.white.withOpacity(0.8),
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.4),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: const Center(
        child: Icon(
          Icons.qr_code_scanner_rounded,
          color: Colors.white,
          size: 26,
        ),
      ),
    ),
  );
}

  /// NAV ITEM BUILDER
  Widget _buildBottomNavItem(IconData icon, String label, int index) {
    final isActive = currentIndex == index;
    final color = isActive ? Colors.white : Colors.white.withOpacity(0.5);

    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? Colors.white.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}