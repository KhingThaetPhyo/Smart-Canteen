import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smartcanteen/service/secure_storage_service.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "သင့်အကောင့်ကို ဖွင့်ပါ",
      "description":
          "ကျောင်းသားကတ်ပေါ်တွင် ဖော်ပြထားသည့် ကျောင်းသားအမှတ်၊ အမည်အပြည့်အစုံနှင့် ဖုန်းနံပါတ်တို့ကို မှန်ကန်စွာထည့်သွင်းပြီး အကောင့်ဖွင့်ပါ။",
      "icon": "person_add",
    },
    {
      "title": "ကျောင်းသားအချက်အလက်ကို အတည်ပြုပါ",
      "description":
          "Smart Canteen ဝန်ဆောင်မှုများကို အသုံးပြုနိုင်ရန် သင့်ကျောင်းသားအချက်အလက်များကို ဖြည့်သွင်းပြီး အတည်ပြုပါ။",
      "icon": "verified_user",
    },
    {
      "title": "အစားအသောက်များကို ရွေးချယ်မှာယူပါ",
      "description":
          "ဆိုင်အသီးသီးမှ Menu များကို ကြည့်ရှုပြီး ကြိုက်နှစ်သက်ရာ အစားအသောက်များကို အလွယ်တကူ ရွေးချယ်မှာယူနိုင်ပါသည်။",
      "icon": "restaurant",
    },
    {
      "title": "စားပွဲကြိုတင်မှာယူပါ",
      "description":
          "အားလပ်နေသော စားပွဲများကို စစ်ဆေးပြီး လူများသည့်အချိန်တွင် သင့်အတွက် စားပွဲတစ်လုံးကို ကြိုတင်မှာယူထားနိုင်ပါသည်။",
      "icon": "table_restaurant",
    },
    {
      "title": "ငွေပေးချေပြီး အော်ဒါထုတ်ယူပါ",
      "description":
          "Wallet Point သို့မဟုတ် QR Payment ဖြင့် ငွေပေးချေပြီး အော်ဒါအဆင်သင့်ဖြစ်သောအခါ လွယ်ကူမြန်ဆန်စွာ ထုတ်ယူနိုင်ပါသည်။",
      "icon": "qr_code_scanner",
    },
  ];

  IconData getIcon(String iconName) {
    switch (iconName) {
      case "person_add":
        return Icons.person_add_alt_1_rounded;
      case "verified_user":
        return Icons.verified_user_rounded;
      case "restaurant":
        return Icons.restaurant_menu_rounded;
      case "table_restaurant":
        return Icons.table_restaurant_rounded;
      case "qr_code_scanner":
        return Icons.qr_code_scanner_rounded;
      default:
        return Icons.info_rounded;
    }
  }
// inside view/onboard_screen.dart

Future<void> _finishOnboarding() async {
  await SecureStorageService.setFirstTimeCompleted();
  if (mounted) {
    context.go('/navigation'); // Or context.go('/login');
  }
}

void nextPage() {
  if (currentIndex == onboardingData.length - 1) {
    _finishOnboarding();
    return;
  }
  _pageController.nextPage(
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeInOutCubic,
  );
}

void skipToLogin() {
  _finishOnboarding();
}
  // void nextPage() {
  //   if (currentIndex == onboardingData.length - 1) {
  //     Navigator.pushReplacementNamed(context, "/navigation");
  //     return;
  //   }
  //   _pageController.nextPage(
  //     duration: const Duration(milliseconds: 500),
  //     curve: Curves.easeInOutCubic,
  //   );
  // }

  // void skipToLogin() {
  //   Navigator.pushReplacementNamed(context, "/navigation");
  // }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xff117992);

    return Scaffold(
      body: Stack(
        children: [
          // 1. Dynamic Vibrant Background (Glassmorphism needs background colors/gradients to blur)
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xff0A4D5C),
                    Color(0xff117992),
                    Color(0xff22A39F),
                  ],
                ),
              ),
            ),
          ),

          // 2. Decorative Background Glowing Orbs (Creates refraction effects)
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.15),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            right: -80,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xffF4F8F9).withOpacity(0.1),
              ),
            ),
          ),

          // 3. Main Content Layer
          SafeArea(
            child: Column(
              children: [
                // Top Bar: Pill Indicators & Skip Button
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: List.generate(onboardingData.length, (index) {
                          bool isActive = currentIndex == index;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            height: 6,
                            width: isActive ? 24 : 6,
                            margin: const EdgeInsets.only(right: 6),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          );
                        }),
                      ),
                      if (currentIndex < onboardingData.length - 1)
                        TextButton(
                          onPressed: skipToLogin,
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white70,
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(50, 30),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            "ကျော်မည်",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // Center PageView Content with Frosted Glass Card
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: onboardingData.length,
                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      final item = onboardingData[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(32),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                            child: Container(
                              padding: const EdgeInsets.all(28),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(32),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.25),
                                  width: 1.5,
                                ),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.white.withOpacity(0.2),
                                    Colors.white.withOpacity(0.05),
                                  ],
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Glass Icon Container
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        width: 120,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.1),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      Container(
                                        width: 90,
                                        height: 90,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.2),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.white.withOpacity(
                                              0.4,
                                            ),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.1,
                                              ),
                                              blurRadius: 15,
                                              offset: const Offset(0, 8),
                                            ),
                                          ],
                                        ),
                                        child: Icon(
                                          getIcon(item["icon"]!),
                                          size: 40,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 40),

                                  // Title
                                  Text(
                                    item["title"]!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      letterSpacing: -0.5,
                                    ),
                                  ),

                                  const SizedBox(height: 16),

                                  // Description
                                  Text(
                                    item["description"]!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.85),
                                      fontSize: 14.5,
                                      height: 1.6,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Bottom Action Buttons with Glass Effect
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
                  child: Row(
                    children: [
                      if (currentIndex > 0) ...[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              height: 56,
                              width: 56,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                ),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  _pageController.previousPage(
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                icon: const Icon(
                                  Icons.arrow_back_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              height: 56,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: nextPage,
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      currentIndex == onboardingData.length - 1
                                          ? "စတင်အသုံးပြုမည်"
                                          : "ရှေ့သို့",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    if (currentIndex <
                                        onboardingData.length - 1) ...[
                                      const SizedBox(width: 8),
                                      Icon(
                                        Icons.arrow_forward_rounded,
                                        size: 18,
                                        color: primaryColor,
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
