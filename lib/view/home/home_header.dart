
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smartcanteen/model/user_model.dart';
import 'package:smartcanteen/model/wallet_model.dart';
import 'package:smartcanteen/provider/user_provider.dart';
import 'package:smartcanteen/service/api_service.dart';
import 'package:smartcanteen/service/shared_preferences_service.dart';

class HomeHeader extends StatefulWidget implements PreferredSizeWidget {
  const HomeHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(330);

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  UserModel? currentUser;
  WalletModel? currentUserWallet;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }
Future<void> _loadUserData() async {
  try {
    // 1. Load cached user & wallet first
    final user = await SharedPreferencesService.getUser();
    WalletModel? wallet = await SharedPreferencesService.getUserWallet();
    wallet ??= user?.wallet;

    if (mounted) {
      setState(() {
        currentUser = user;
        currentUserWallet = wallet;
      });

      if (wallet != null) {
        context.read<UserProvider>().setBalance(wallet.balance);
      }
    }

    // 2. Fetch fresh wallet points from GET /api/user/wallet/balance
    final apiResponse = await ApiService().getWalletBalance();

    if (apiResponse != null && apiResponse['success'] == true && mounted) {
      final walletData = apiResponse['data']?['wallet'];

      if (walletData != null) {
        // Safely extract points without calling WalletModel.fromJson on incomplete JSON
        final int freshPoints = (walletData['points'] as num?)?.toInt() ?? 0;

        // Build a updated WalletModel using existing cached fields or safe defaults
        final updatedWallet = WalletModel(
          walletId: currentUserWallet?.walletId,
          userId: currentUserWallet?.userId ?? (apiResponse['data']?['user']?['user_id'] as int?) ?? 0,
          shopId: currentUserWallet?.shopId,
          balance: freshPoints, // Updated points from backend
          isPinChanged: currentUserWallet?.isPinChanged ?? 0,
          failedAttempts: currentUserWallet?.failedAttempts ?? 0,
          lockedUntil: currentUserWallet?.lockedUntil,
          createdAt: currentUserWallet?.createdAt ?? DateTime.now().toIso8601String(),
          updatedAt: DateTime.now().toIso8601String(),
        );

        // Store back in local storage
        await SharedPreferencesService.saveUserWallet(updatedWallet);

        // Update local state and global provider
        setState(() {
          currentUserWallet = updatedWallet;
        });

        context.read<UserProvider>().setBalance(freshPoints);
      }
    }
  } catch (e) {
    debugPrint("Error updating wallet balance: $e");
  } finally {
    if (mounted) {
      setState(() => isLoading = false);
    }
  }
}
  void _handleProtectedAction(VoidCallback onAuthenticated) async {
    if (currentUser == null) {
      await context.push('/login');
      _loadUserData(); // Reload user state after returning from login
    } else {
      onAuthenticated();
    }
  }

  @override
  Widget build(BuildContext context) {
    const double halfCardHeight = 48;
    final bool hasNotification = false;

    final String userName = currentUser?.userName ?? "Guest";
    final String major = currentUser?.student != null
        ? "${currentUser!.student!.yearLevel ?? 'Student'}"
        : "သင့်အကောင့်သို့";
    final String studentId = currentUser?.student?.studentId ?? "လော့ဂ်အင် ၀င်ပါ...";
   // final int points = currentUserWallet?.balance ?? 0;

   final int points = context.watch<UserProvider>().balancePoints;
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
                  // Avatar with authentication guard
                  GestureDetector(
                    onTap: () => _handleProtectedAction(() {
                      // Optional: Navigate to profile screen if needed
                    }),
                    child: Container(
                      width: 54,
                      height: 54,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: ClipOval(
                        child: Image.asset(
                          "assets/image/user_logo.jpg",
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.account_circle, size: 54, color: Colors.white),
                        ),
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
                          isLoading ? "..." : userName,
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
                    onTap: () => _handleProtectedAction(() {
                      context.push('/noti');
                    }),
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

              /// SECOND ROW: CONDITIONAL (STUDENT DETAILS OR LOGIN BUTTON)
              isLoading
                  ? const SizedBox(height: 40)
                  : currentUser == null
                      ? SizedBox(
                          width: 200,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              context.go('/login');
                            },
                            icon: const Icon(Icons.login, size: 18, color: Colors.white),
                            label: const Text(
                              "အကောင့်၀င်ရန်",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff0D6B80).withOpacity(0.95),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 0,
                            ),
                          ),
                        )
                      : Row(
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
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "ရှာဖွေပါ...",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    prefixIcon: Icon(Icons.search_rounded, color: Colors.grey),
                    border: InputBorder.none, // Removes the bottom underline
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 30),

        /// FLOATING QUICK ACTION CARD
        Positioned(
          left: 20,
          right: 20,
          bottom: -28,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _QuickAction(
                  icon: Icons.qr_code,
                  title: "ကျွန်ုပ်၏ QR",
                  onTap: () => _handleProtectedAction(() {
                    context.push('/user_qr');
                  }),
                ),
                _QuickAction(
                  icon: Icons.send_rounded,
                  title: "ပွိုင့်လွှဲ",
                  onTap: () => _handleProtectedAction(() {
                    context.push('/transfer');
                  }),
                ),
                _QuickAction(
                  icon: Icons.history,
                  title: "မှတ်တမ်း",
                  onTap: () => _handleProtectedAction(() {
                    context.push('/history');
                  }),
                ),
                _QuickAction(
                  icon: Icons.wallet,
                  title: "ပိုက်ဆံအိတ်",
                  onTap: () => _handleProtectedAction(() {
                    context.push('/wallet');
                  }),
                ),
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
  final VoidCallback onTap;

  const _QuickAction({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
          child: SizedBox(
            width: 68,
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff334155),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}