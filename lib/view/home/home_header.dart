import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class HomeHeader extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final String major;
  final String studentId;
  final int points;

  const HomeHeader({
    super.key,
    required this.userName,
    required this.major,
    required this.studentId,
    required this.points,
  });

  // 1. INCREASE PREFERRED HEIGHT TO ACCOUNT FOR LOWER FLOATING CARD
  @override
  Size get preferredSize => const Size.fromHeight(330); // 👈 Increased from 310 to 330

  @override
  Widget build(BuildContext context) {
    const double halfCardHeight = 48;
    final bool hasNotification = true;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        /// HEADER BACKGROUND (APPBAR CONTAINER)
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(
            20,
            60,
            20,
            halfCardHeight + 24,
          ),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff0D6B80),
                Color(0xff117992),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(34),
              bottomRight: Radius.circular(34),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// TOP ROW: AVATAR + GREETING + NOTIFICATION
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 54,
                    height: 54,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: ClipOval(
                      child: Image.asset(
                        "assets/image/user_logo.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "ကြိုဆိုပါ၏",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          userName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => context.go('/noti'),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Stack(
                        children: [
                          const Center(
                            child: Icon(
                              Icons.notifications_outlined,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                          if (hasNotification)
                            Positioned(
                              top: 10,
                              right: 10,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: const Color(0xffEF4444),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xff117992),
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  )
                ],
              ),

              const SizedBox(height: 20),

              /// SECOND ROW: STUDENT DETAILS + POINTS BADGE
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        major,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        studentId,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.white.withOpacity(0.15)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.stars_rounded, color: Colors.white, size: 16),
                        const SizedBox(width: 5),
                        Text(
                          NumberFormat('#,###').format(points),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          "ပွိုင့်",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// SEARCH BAR
              GestureDetector(
                onTap: () => context.go('/search'),
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.search_rounded, color: Colors.grey),
                      SizedBox(width: 12),
                      Text("ရှာဖွေပါ...", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        /// FLOATING QUICK ACTION CARD (MOVED DOWN)
        Positioned(
          left: 20,
          right: 20,
          bottom: -28, // 👈 Lowered down (change this value if you want more/less offset)
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 20,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _QuickAction(icon: Icons.qr_code_scanner_rounded, title: "Scan ဖတ်ပါ"),
                _QuickAction(icon: Icons.send_rounded, title: "ပွိုင့်လွှဲ"),
                _QuickAction(icon: Icons.history, title: "မှတ်တမ်း"),
                _QuickAction(icon: Icons.qr_code, title: "ကျွန်ုပ်၏ QR"),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String title;

  const _QuickAction({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 72,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xffEAF7F9),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: const Color(0xff117992),
              size: 26,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xff334155),
            ),
          ),
        ],
      ),
    );
  }
}