import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../notification/notification_screen.dart';
import '../../scanner/scanner_screen.dart';
import '../../search/search_screen.dart';
import '../../wallet/wallet_screen.dart';
import '../../wallet/transfer_screen.dart';

class HomeHeader extends StatefulWidget {
  final String userName;
  final String major;
  final String studentId;
  final int points;
  final Function(int tabIndex)? onSelectTab;

  const HomeHeader({
    super.key,
    required this.userName,
    required this.major,
    required this.studentId,
    required this.points,
    this.onSelectTab,
  });

  @override
  State<HomeHeader> createState() => _HomeHeaderState();

  static const Color primaryColor = Color(0xff117992);
}

class _HomeHeaderState extends State<HomeHeader> {
  late int _currentPoints;

  @override
  void initState() {
    super.initState();
    _currentPoints = widget.points;
  }

  @override
  void didUpdateWidget(covariant HomeHeader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.points != widget.points) {
      _currentPoints = widget.points;
    }
  }

  @override
  Widget build(BuildContext context) {
    const double halfCardHeight = 48;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        /// COLORED HEADER BACKGROUND
        Container(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, halfCardHeight),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff0D6B80), Color(0xff117992)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(34),
              bottomRight: Radius.circular(34),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// TOP BAR
              Row(
                children: [
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.white.withOpacity(.12),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: const Icon(
                      Icons.restaurant_menu_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Text(
                      "Smart Canteen",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  /// NOTIFICATION ICON
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const NotificationScreen(),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.25),
                          width: 1,
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          const Icon(
                            Icons.notifications_none_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                          Positioned(
                            top: -2,
                            right: -2,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 18,
                                minHeight: 18,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xffFF5252),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color(0xff117992),
                                  width: 2,
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  "3",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    height: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// GREETING
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _greeting(),
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.userName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 4),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${widget.major} • ${widget.studentId}",
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ),

              const SizedBox(height: 16),

              /// POINTS CARD
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.white.withOpacity(.12),
                  border: Border.all(color: Colors.white.withOpacity(.2)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xffF59E0B).withOpacity(.2),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xffF59E0B).withOpacity(.3),
                        ),
                      ),
                      child: const Icon(
                        Icons.stars_rounded,
                        color: Color(0xffFBBF24),
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Available Points",
                            style: TextStyle(
                              color: Colors.white.withOpacity(.8),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.3,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "${NumberFormat('#,###').format(_currentPoints)} pts",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              /// SEARCH BAR
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SearchScreen()),
                  );
                },
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.search_rounded, color: Colors.grey, size: 24),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          "Search shops, foods...",
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),

        /// FLOATING QUICK ACTIONS
        Positioned(
          left: 20,
          right: 20,
          bottom: -halfCardHeight,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: const Color(0xff117992).withOpacity(0.12),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xff0D6B80).withOpacity(0.12),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _QuickAction(
                  icon: Icons.qr_code_scanner_rounded,
                  title: "Scan",
                  iconColor: const Color(0xff117992),
                  bgColor: const Color(0xffEAF7F9),
                  onTap: () {
                    if (widget.onSelectTab != null) {
                      widget.onSelectTab!(2);
                    }
                  },
                ),
                _QuickAction(
                  icon: Icons.qr_code_2_rounded,
                  title: "Receive",
                  iconColor: const Color(0xff117992),
                  bgColor: const Color(0xffEAF7F9),
                  onTap: () => _showReceiveQRModal(context),
                ),
                _QuickAction(
                  icon: Icons.send_rounded,
                  title: "Transfer",
                  iconColor: const Color(0xff117992),
                  bgColor: const Color(0xffEAF7F9),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TransferScreen(
                          currentBalance: _currentPoints,
                          onTransferCompleted: (amount, recipient) {
                            setState(() {
                              _currentPoints -= amount;
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
                _QuickAction(
                  icon: Icons.account_balance_wallet_rounded,
                  title: "Wallet",
                  iconColor: const Color(0xff117992),
                  bgColor: const Color(0xffEAF7F9),
                  onTap: () {
                    if (widget.onSelectTab != null) {
                      widget.onSelectTab!(3);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// MODAL BOTTOM SHEET TO SHOW RECEIVE QR CODE
  void _showReceiveQRModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle Bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              "Receive Points",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff1E293B),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Show this QR code to the sender to receive points",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
            ),
            const SizedBox(height: 24),

            // QR Code Container
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xffF8FAFC),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xffE2E8F0)),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.qr_code_2_rounded,
                    size: 200,
                    color: Color(0xff117992),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.userName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff1E293B),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "ID: ${widget.studentId}",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Close Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff117992),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Done",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return "Good morning,";
    if (hour < 17) return "Good afternoon,";
    return "Good evening,";
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color iconColor;
  final Color bgColor;
  final VoidCallback onTap;

  const _QuickAction({
    required this.icon,
    required this.title,
    required this.iconColor,
    required this.bgColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: 72,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: iconColor, size: 26),
            ),
            const SizedBox(height: 6),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff334155),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
