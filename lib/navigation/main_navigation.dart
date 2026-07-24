import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:smartcanteen/view/home/home_screen.dart';
import 'package:smartcanteen/view/orders/orders_screen.dart';
import 'package:smartcanteen/view/scanner/scanner_screen.dart';
import 'package:smartcanteen/view/wallet/wallet_screen.dart';
import 'package:smartcanteen/view/profilescreen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int currentIndex = 0;

  static const Color primaryColor = Color(0xFF117992);

  // REPLACE 'final List<Widget> screens = const [...]' WITH THIS GETTER:
  List<Widget> get screens => [
    HomeScreen(
      onSelectTab: (index) {
        setState(() {
          currentIndex = index; // Switches active tab on HomeHeader tap
        });
      },
    ), // Index 0
    const OrdersScreen(), // Index 1
    const ScannerScreen(), // Index 2
    const WalletScreen(), // Index 3
    const ProfileScreen(), // Index 4
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: Stack(
        children: [
          /// PAGES
          IndexedStack(index: currentIndex, children: screens),

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
            color: const Color(0xFF0C5470).withOpacity(0.75),
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
              _buildBottomNavItem(Icons.home_rounded, "Home", 0),
              _buildBottomNavItem(Icons.receipt_long_rounded, "Orders", 1),

              const SizedBox(width: 48), // Gap for middle Scanner button

              _buildBottomNavItem(
                Icons.account_balance_wallet_rounded,
                "Wallet",
                3,
              ),
              _buildBottomNavItem(Icons.person_rounded, "Profile", 4),
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
        setState(() {
          currentIndex = 2; // Switches to ScannerScreen
        });
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
