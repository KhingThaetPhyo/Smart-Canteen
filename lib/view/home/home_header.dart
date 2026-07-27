// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:intl/intl.dart';

// class HomeHeader extends StatelessWidget implements PreferredSizeWidget {
//   final String userName;
//   final String major;
//   final String studentId;
//   final int points;

//   const HomeHeader({
//     super.key,
//     required this.userName,
//     required this.major,
//     required this.studentId,
//     required this.points,
//   });

//   // 1. INCREASE PREFERRED HEIGHT TO ACCOUNT FOR LOWER FLOATING CARD
//   @override
//   Size get preferredSize => const Size.fromHeight(330); // 👈 Increased from 310 to 330

//   @override
//   Widget build(BuildContext context) {
//     const double halfCardHeight = 48;
//     final bool hasNotification = true;

//     return Stack(
//       clipBehavior: Clip.none,
//       children: [
//         /// HEADER BACKGROUND (APPBAR CONTAINER)
//         Container(
//           width: double.infinity,
//           padding: const EdgeInsets.fromLTRB(
//             20,
//             60,
//             20,
//             halfCardHeight + 24,
//           ),
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Color(0xff0D6B80),
//                 Color(0xff117992),
//               ],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(34),
//               bottomRight: Radius.circular(34),
//             ),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               /// TOP ROW: AVATAR + GREETING + NOTIFICATION
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                     width: 54,
//                     height: 54,
//                     decoration: const BoxDecoration(shape: BoxShape.circle),
//                     child: ClipOval(
//                       child: Image.asset(
//                         "assets/image/user_logo.jpg",
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           "ကြိုဆိုပါ၏",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 11,
//                             fontWeight: FontWeight.w600,
//                             letterSpacing: 0.8,
//                           ),
//                         ),
//                         const SizedBox(height: 2),
//                         Text(
//                           userName,
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 22,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () => context.go('/noti'),
//                     borderRadius: BorderRadius.circular(20),
//                     child: Container(
//                       width: 44,
//                       height: 44,
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.12),
//                         shape: BoxShape.circle,
//                       ),
//                       child: Stack(
//                         children: [
//                           const Center(
//                             child: Icon(
//                               Icons.notifications_outlined,
//                               color: Colors.white,
//                               size: 22,
//                             ),
//                           ),
//                           if (hasNotification)
//                             Positioned(
//                               top: 10,
//                               right: 10,
//                               child: Container(
//                                 width: 8,
//                                 height: 8,
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xffEF4444),
//                                   shape: BoxShape.circle,
//                                   border: Border.all(
//                                     color: const Color(0xff117992),
//                                     width: 1.5,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),

//               const SizedBox(height: 20),

//               /// SECOND ROW: STUDENT DETAILS + POINTS BADGE
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         major,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 13,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       const SizedBox(height: 2),
//                       Text(
//                         studentId,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 11,
//                         ),
//                       ),
//                     ],
//                   ),
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(24),
//                       border: Border.all(color: Colors.white.withOpacity(0.15)),
//                     ),
//                     child: Row(
//                       children: [
//                         const Icon(Icons.stars_rounded, color: Colors.white, size: 16),
//                         const SizedBox(width: 5),
//                         Text(
//                           NumberFormat('#,###').format(points),
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(width: 3),
//                         Text(
//                           "ပွိုင့်",
//                           style: TextStyle(
//                             color: Colors.white.withOpacity(0.6),
//                             fontSize: 10,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 24),

//               /// SEARCH BAR
//               GestureDetector(
//                 onTap: () => context.go('/search'),
//                 child: Container(
//                   height: 50,
//                   padding: const EdgeInsets.symmetric(horizontal: 18),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(32),
//                   ),
//                   child: const Row(
//                     children: [
//                       Icon(Icons.search_rounded, color: Colors.grey),
//                       SizedBox(width: 12),
//                       Text("ရှာဖွေပါ...", style: TextStyle(color: Colors.grey)),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),

//         /// FLOATING QUICK ACTION CARD (MOVED DOWN)
//         Positioned(
//           left: 20,
//           right: 20,
//           bottom: -28, // 👈 Lowered down (change this value if you want more/less offset)
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(24),
//               boxShadow: const [
//                 BoxShadow(
//                   color: Colors.black12,
//                   blurRadius: 20,
//                   offset: Offset(0, 8),
//                 ),
//               ],
//             ),
//             child: const Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 _QuickAction(icon: Icons.qr_code_scanner_rounded, title: "Scan ဖတ်ပါ"),
//                 _QuickAction(icon: Icons.send_rounded, title: "ပွိုင့်လွှဲ"),
//                 _QuickAction(icon: Icons.history, title: "မှတ်တမ်း"),
//                 _QuickAction(icon: Icons.qr_code, title: "ကျွန်ုပ်၏ QR"),
//               ],
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }

// class _QuickAction extends StatelessWidget {
//   final IconData icon;
//   final String title;

//   const _QuickAction({
//     required this.icon,
//     required this.title,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 72,
//       child: Column(
//         children: [
//           Container(
//             width: 50,
//             height: 50,
//             decoration: BoxDecoration(
//               color: const Color(0xffEAF7F9),
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: Icon(
//               icon,
//               color: const Color(0xff117992),
//               size: 26,
//             ),
//           ),
//           const SizedBox(height: 6),
//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 12,
//               fontWeight: FontWeight.w600,
//               color: Color(0xff334155),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// // }
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:intl/intl.dart';
// import 'package:smartcanteen/model/user_model.dart';
// import 'package:smartcanteen/service/shared_preferences_service.dart';

// class HomeHeader extends StatefulWidget implements PreferredSizeWidget {
//   const HomeHeader({super.key});

//   @override
//   Size get preferredSize => const Size.fromHeight(330);

//   @override
//   State<HomeHeader> createState() => _HomeHeaderState();
// }

// class _HomeHeaderState extends State<HomeHeader> {
//   UserModel? currentUser;
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _loadUserData();
//   }

//   Future<void> _loadUserData() async {
//     final user = await SharedPreferencesService.getUser();
//     if (mounted) {
//       setState(() {
//         currentUser = user;
//         isLoading = false;
//       });
//     }

//     if (user != null) {
//       print("HomeHeader loaded user: ${user.userName}");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     const double halfCardHeight = 48;
//     final bool hasNotification = true;

//     // Dynamically derive values from SharedPreferences user model
//     final String userName = currentUser?.userName ?? "Guest";
//     final String major = currentUser?.student != null
//         ? "${currentUser!.student!.yearLevel ?? 'Student'}"
//         : "သင့်အကောင့်သို့";
//     final String studentId = currentUser?.student?.studentId ?? "လော့ဂ်အင် ၀င်ပါ...";
//     final int points = currentUser?.wallet?.balance?.toInt() ?? 0;

//     return Stack(
//       clipBehavior: Clip.none,
//       children: [
//         /// HEADER BACKGROUND (APPBAR CONTAINER)
//         Container(
//           width: double.infinity,
//           padding: const EdgeInsets.fromLTRB(
//             20,
//             60,
//             20,
//             halfCardHeight + 24,
//           ),
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Color(0xff0D6B80),
//                 Color(0xff117992),
//               ],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(34),
//               bottomRight: Radius.circular(34),
//             ),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               /// TOP ROW: AVATAR + GREETING + NOTIFICATION
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                     width: 54,
//                     height: 54,
//                     decoration: const BoxDecoration(shape: BoxShape.circle),
//                     child: ClipOval(
//                       child: Image.asset(
//                         "assets/image/user_logo.jpg",
//                         fit: BoxFit.cover,
//                         errorBuilder: (context, error, stackTrace) =>
//                             const Icon(Icons.account_circle, size: 54, color: Colors.white),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           "ကြိုဆိုပါ၏",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 11,
//                             fontWeight: FontWeight.w600,
//                             letterSpacing: 0.8,
//                           ),
//                         ),
//                         const SizedBox(height: 2),
//                         Text(
//                           isLoading ? "..." : userName,
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 22,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () => context.push('/noti'),
//                     borderRadius: BorderRadius.circular(20),
//                     child: Container(
//                       width: 44,
//                       height: 44,
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.12),
//                         shape: BoxShape.circle,
//                       ),
//                       child: Stack(
//                         children: [
//                           const Center(
//                             child: Icon(
//                               Icons.notifications_outlined,
//                               color: Colors.white,
//                               size: 22,
//                             ),
//                           ),
//                           if (hasNotification)
//                             Positioned(
//                               top: 10,
//                               right: 10,
//                               child: Container(
//                                 width: 8,
//                                 height: 8,
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xffEF4444),
//                                   shape: BoxShape.circle,
//                                   border: Border.all(
//                                     color: const Color(0xff117992),
//                                     width: 1.5,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),

//               const SizedBox(height: 20),

//               /// SECOND ROW: CONDITIONAL (STUDENT DETAILS OR LOGIN BUTTON)
//               isLoading
//                   ? const SizedBox(height: 40)
//                   : currentUser == null
//                       ? SizedBox(
//                           width: 200,
//                           child: ElevatedButton.icon(
//                            onPressed: () {
//                              context.go('/login');
//                            },
//                             icon: const Icon(Icons.login, size: 18, color: Colors.white),
//                             label: const Text(
//                               "အကောင့်၀င်ရန်",
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Color(0xff0D6B80).withOpacity(0.95),
//                               padding: const EdgeInsets.symmetric(vertical: 10),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
                              
//                               elevation: 0,
//                             ),
//                           ),
//                         )
//                       : Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   major,
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 13,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 2),
//                                 Text(
//                                   studentId,
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 11,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Container(
//                               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                               decoration: BoxDecoration(
//                                 color: Colors.white.withOpacity(0.1),
//                                 borderRadius: BorderRadius.circular(24),
//                                 border: Border.all(color: Colors.white.withOpacity(0.15)),
//                               ),
//                               child: Row(
//                                 children: [
//                                   const Icon(Icons.stars_rounded, color: Colors.white, size: 16),
//                                   const SizedBox(width: 5),
//                                   Text(
//                                     NumberFormat('#,###').format(points),
//                                     style: const TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   const SizedBox(width: 3),
//                                   Text(
//                                     "ပွိုင့်",
//                                     style: TextStyle(
//                                       color: Colors.white.withOpacity(0.6),
//                                       fontSize: 10,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),

//               const SizedBox(height: 24),

//               /// SEARCH BAR
//               GestureDetector(
//                 onTap: () => context.push('/search'),
//                 child: Container(
//                   height: 50,
//                   padding: const EdgeInsets.symmetric(horizontal: 18),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(32),
//                   ),
//                   child: const Row(
//                     children: [
//                       Icon(Icons.search_rounded, color: Colors.grey),
//                       SizedBox(width: 12),
//                       Text("ရှာဖွေပါ...", style: TextStyle(color: Colors.grey)),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: 30,),
//         /// FLOATING QUICK ACTION CARD
//         Positioned(
//           left: 20,
//           right: 20,
//           bottom: -28,
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(24),
//               boxShadow: const [
//                 BoxShadow(
//                   color: Colors.black12,
//                   blurRadius: 20,
//                   offset: Offset(0, 8),
//                 ),
//               ],
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 _QuickAction(
//                   icon: Icons.qr_code_scanner_rounded,
//                   title: "Scan ဖတ်ပါ",
//                   onTap: () => context.push('/scan_qr'),
//                 ),
//                 _QuickAction(
//                   icon: Icons.send_rounded,
//                   title: "ပွိုင့်လွှဲ",
//                   onTap: () => context.push('/transfer'),
//                 ),
//                 _QuickAction(
//                   icon: Icons.history,
//                   title: "မှတ်တမ်း",
//                   onTap: () => context.push('/history'),
//                 ),
//                 _QuickAction(
//                   icon: Icons.qr_code,
//                   title: "ကျွန်ုပ်၏ QR",
//                   onTap: () => context.push('/user_qr'),
//                 ),
//               ],
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }

// class _QuickAction extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final VoidCallback onTap;

//   const _QuickAction({
//     required this.icon,
//     required this.title,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(16),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
//           child: SizedBox(
//             width: 68,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   width: 50,
//                   height: 50,
//                   decoration: BoxDecoration(
//                     color: const Color(0xffEAF7F9),
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Icon(
//                     icon,
//                     color: const Color(0xff117992),
//                     size: 26,
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//                 Text(
//                   title,
//                   textAlign: TextAlign.center,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w600,
//                     color: Color(0xff334155),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:smartcanteen/model/user_model.dart';
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
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = await SharedPreferencesService.getUser();
    if (mounted) {
      setState(() {
        currentUser = user;
        isLoading = false;
      });
    }

    if (user != null) {
      print("HomeHeader loaded user: ${user.userName}");
    }
  }

  /// Helper to guard actions that require authentication
  void _handleProtectedAction(VoidCallback onAuthenticated) {
    if (currentUser == null) {
      context.go('/login');
    } else {
      onAuthenticated();
    }
  }

  @override
  Widget build(BuildContext context) {
    const double halfCardHeight = 48;
    final bool hasNotification = false;

    // Dynamically derive values from SharedPreferences user model
    final String userName = currentUser?.userName ?? "Guest";
    final String major = currentUser?.student != null
        ? "${currentUser!.student!.yearLevel ?? 'Student'}"
        : "သင့်အကောင့်သို့";
    final String studentId = currentUser?.student?.studentId ?? "လော့ဂ်အင် ၀င်ပါ...";
    final int points = currentUser?.wallet?.balance?.toInt() ?? 0;

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