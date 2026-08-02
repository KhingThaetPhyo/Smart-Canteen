
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:smartcanteen/model/user_model.dart';
// import 'package:smartcanteen/service/api_service.dart';
// import 'package:smartcanteen/service/secure_storage_service.dart';
// import 'package:smartcanteen/service/shared_preferences_service.dart';
// import 'package:smartcanteen/view/change_password_screen.dart';
// import 'package:smartcanteen/view/change_phone_screen.dart';
// import 'package:smartcanteen/view/change_pin_screen.dart';
// import 'package:smartcanteen/view/enter_email_screen.dart';
// import 'package:smartcanteen/view/loginscreen.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   bool isNotificationOn = true;
//   bool isDarkModeOn = false;
//   String selectedLanguage = 'EN';

//   // Dynamic Profile State Variables
//   bool isLoading = true;
//   String name = '';
//   String studentId = '';
//   String email = '';
//   String phone = '';
//   String initials = '';

//   @override
//   void initState() {
//     super.initState();
//     _loadUserData();
//   }

//   // Roll Number ကို 3 Digits Auto Format လုပ်ပေးသည့် Function
//   String _formatStudentId(String rawId) {
//     if (rawId.isEmpty) return '';

//     if (rawId.contains('-')) {
//       List<String> parts = rawId.split('-');
//       String prefix = parts.sublist(0, parts.length - 1).join('-');
//       String rollNumStr = parts.last.trim();

//       if (RegExp(r'^\d+$').hasMatch(rollNumStr)) {
//         String paddedRoll = rollNumStr.padLeft(3, '0');
//         return '$prefix-$paddedRoll';
//       }
//     }
//     return rawId;
//   }

//   // Fetch user data from SharedPreferences
//   Future<void> _loadUserData() async {
//     try {
//       UserModel? user = await SharedPreferencesService.getUser();
//       if (user != null && mounted) {
//         setState(() {
//           name = user.userName;
//           email = user.userEmail;
//           phone = user.userPhone;

//           String rawStudentId = user.student?.studentId.toString() ?? '';
//           studentId = _formatStudentId(rawStudentId);

//           _updateInitials(name);
//           isLoading = false;
//         });
//       } else if (mounted) {
//         setState(() {
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() {
//           isLoading = false;
//         });
//       }
//     }
//   }

//   void _updateInitials(String newName) {
//     List<String> names = newName.trim().split(' ');
//     if (names.length >= 2 && names[0].isNotEmpty && names[1].isNotEmpty) {
//       initials = '${names[0][0]}${names[1][0]}'.toUpperCase();
//     } else if (names.isNotEmpty && names[0].isNotEmpty) {
//       initials = names[0]
//           .substring(0, names[0].length >= 2 ? 2 : 1)
//           .toUpperCase();
//     } else {
//       initials = 'U';
//     }
//   }

//   // Screen အလယ်တွင် ပြသပေးမည့် Dynamic Custom Success Dialog Box
//   void _showSuccessDialog({required IconData icon, required String message}) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(24),
//           ),
//           elevation: 0,
//           backgroundColor: Colors.white,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 // Icon ဝိုင်းလေး
//                 Container(
//                   width: 70,
//                   height: 70,
//                   decoration: const BoxDecoration(
//                     color: Color(0xFFEBF6F7),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(icon, color: const Color(0xFF007A87), size: 36),
//                 ),
//                 const SizedBox(height: 20),

//                 // ခေါင်းစဉ် စာသား
//                 const Text(
//                   'အောင်မြင်ပါသည်',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF007A87),
//                   ),
//                 ),
//                 const SizedBox(height: 12),

//                 // အသေးစိတ် စာသား
//                 Text(
//                   message,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Colors.black87,
//                     height: 1.4,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

// final ApiService _apiService = ApiService();

//   Future<void> _handleLogout() async {
//     // Show a loading indicator or confirmation dialog if desired
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => const Center(
//         child: CircularProgressIndicator(color: Color(0xFF007A87)),
//       ),
//     );

//     try {
//       // 1. Call logout API
//       await _apiService.logoutUser();
//     } catch (e) {
//       print("Logout API error: $e");
//     }

//     // 2. Clear local storage / user session data
//     await SecureStorageService.clearAll();
//     await SharedPreferencesService.clearAll();

//     if (mounted) {
//       // // Dismiss the loading indicator
//       // Navigator.pop(context);

//     context.go('/login');
//     }
//   }
// void _showLogoutConfirmationDialog() {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         backgroundColor: Colors.white, // Set a clean background color
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15.0), // Rounded corners
//         ),
//         title: const Text(
//           'အကောင့်ထွက်ရန်',
//           style: TextStyle(
//             color: Color(0xFF007A87), // Use the specific color for the title
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         content: const Text(
//           'အကောင့်မှ ထွက်မည်မှာ သေချာပါသလား?',
//           style: TextStyle(
//             color: Colors.black87, // Clear text color
//             fontSize: 16.0,
//           ),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(bottom: 10.0, right: 10.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: const Text(
//                     'မလုပ်ပါ။',
//                     style: TextStyle(
//                       color: Colors.grey, // Use a standard grey color for the cancel button
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10.0), // Add some spacing between buttons
//                 ElevatedButton( // Use ElevatedButton for the primary action
//                   onPressed: () {
//                     Navigator.pop(context); // Close dialog
//                     _handleLogout(); // Proceed with logout
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF007A87), // Use the specific color for the button background
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
//                   ),
//                   child: const Text(
//                     'ထွက်မည်',
//                     style: TextStyle(
//                       color: Colors.white, // White text on the colored button
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }
//   @override
//   Widget build(BuildContext context) {
//     const primaryTeal = Color(0xff117992);
//     const lightBgColor = Color(0xFFEBF6F7);
//     final mediaQuery = MediaQuery.of(context);
//     final screenWidth = mediaQuery.size.width;

//     if (isLoading) {
//       return const Scaffold(
//         backgroundColor: Colors.white,
//         body: Center(child: CircularProgressIndicator(color: primaryTeal)),
//       );
//     }

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout_rounded, color: Colors.white),
//             onPressed: () {
//               // Optional: Show a confirmation dialog before logging out
//               _showLogoutConfirmationDialog();
//             },
//           ),
//         ],
//         backgroundColor: primaryTeal,
//         elevation: 0,
//       ),
//       body: Container(
//         color: Colors.white,
//         child: SingleChildScrollView(
//           physics: const ClampingScrollPhysics(),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // --- TOP HEADER AREA WITH CARD OVERLAY ---
//               Stack(
//                 clipBehavior: Clip.none,
//                 alignment: Alignment.bottomCenter,
//                 children: [
//                   Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.only(
//                       top: 10,
//                       left: 20,
//                       right: 20,
//                       bottom: 65,
//                     ),
//                     decoration: const BoxDecoration(
//                       color: primaryTeal,
//                       borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(32),
//                         bottomRight: Radius.circular(32),
//                       ),
//                     ),
//                     child: SafeArea(
//                       bottom: false,
//                       child: Column(
//                         children: [
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Container(
//                                 width: 90,
//                                 height: 90,
//                                 decoration: const BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: Colors.white,
//                                 ),
//                                 child: Center(
//                                   child: Text(
//                                     initials,
//                                     style: const TextStyle(
//                                       fontSize: 38,
//                                       fontWeight: FontWeight.bold,
//                                       color: primaryTeal,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 10),
//                               Text(
//                                 name.isNotEmpty ? name : 'အကောင့်ပိုင်ရှင်',
//                                 textAlign: TextAlign.center,
//                                 style: const TextStyle(
//                                   fontSize: 22,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               if (studentId.isNotEmpty) ...[
//                                 const SizedBox(height: 4),
//                                 Text(
//                                   studentId,
//                                   style: TextStyle(
//                                     fontSize: 13,
//                                     fontWeight: FontWeight.w500,
//                                     color: Colors.white.withValues(alpha: 0.85),
//                                     letterSpacing: 0.5,
//                                   ),
//                                 ),
//                               ],
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),

//                   // --- EMAIL & PHONE FLOATING CARD ---
//                   Positioned(
//                     bottom: -27,
//                     left: screenWidth > 600 ? (screenWidth - 500) / 2 : 20,
//                     right: screenWidth > 600 ? (screenWidth - 500) / 2 : 20,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 12,
//                         horizontal: 14,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(20),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withValues(alpha: 0.08),
//                             blurRadius: 15,
//                             offset: const Offset(0, 5),
//                           ),
//                         ],
//                       ),
//                       child: IntrinsicHeight(
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: _buildContactInfoTile(
//                                 icon: Icons.email_outlined,
//                                 label: 'အီးမေးလ်',
//                                 value: email.isNotEmpty ? email : '-',
//                                 lightBgColor: lightBgColor,
//                                 primaryTeal: primaryTeal,
//                               ),
//                             ),
//                             VerticalDivider(
//                               width: 16,
//                               thickness: 1,
//                               color: Colors.grey.shade300,
//                             ),
//                             Expanded(
//                               child: _buildContactInfoTile(
//                                 icon: Icons.phone_outlined,
//                                 label: 'ဖုန်းနံပါတ်',
//                                 value: phone.isNotEmpty ? phone.trim() : '-',
//                                 lightBgColor: lightBgColor,
//                                 primaryTeal: primaryTeal,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 50),

//               // --- ACCOUNT SETTINGS SECTION ---
//               Center(
//                 child: Container(
//                   constraints: const BoxConstraints(maxWidth: 600),
//                   padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         'အကောင့် ဆက်တင်များ',
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.grey,
//                           letterSpacing: 0.8,
//                         ),
//                       ),
//                       const SizedBox(height: 10),

//                       // Notifications
//                       _buildSettingItem(
//                         icon: Icons.notifications_none,
//                         title: 'အသိပေးချက်များ',
//                         trailing: Switch(
//                           value: isNotificationOn,
//                           activeThumbColor: primaryTeal,
//                           onChanged: (val) {
//                             setState(() => isNotificationOn = val);
//                           },
//                         ),
//                       ),

//                       // Edit Profile Navigation
//                       _buildSettingItem(
//                         icon: Icons.phone,
//                         title: 'ဖုန်းနံပါတ် ပြောင်းရန်',
//                         trailing: const Icon(
//                           Icons.edit_square,
//                           color: primaryTeal,
//                         ),
//                         onTap: () async {
//                           final result = await Navigator.push<bool>(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => ChangePhoneScreen(
//                                 initialData: {
//                                   'name': name,
//                                   'studentId': studentId,
//                                   'phone': phone,
//                                   'email': email,
//                                 },
//                               ),
//                             ),
//                           );

//                           if (result == true && mounted) {
//                             _loadUserData();
//                             _showSuccessDialog(
//                               icon: Icons.phone_android_rounded,
//                               message:
//                                   'ဖုန်းနံပါတ် ပြောင်းလဲခြင်း အောင်မြင်ပါပြီ။',
//                             );
//                           }
//                         },
//                       ),

//                       // ===== FORGOT WALLET PIN =====
//                       _buildSettingItem(
//                         icon: Icons.wallet,
//                         title: 'Wallet PIN မေ့နေပါသလား',
//                         trailing: const Icon(
//                           Icons.edit_square,
//                           color: primaryTeal,
//                         ),
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const EnterEmailScreen(),
//                             ),
//                           );
//                         },
//                       ),

//                       // ===== CHANGE WALLET PIN =====
//                       _buildSettingItem(
//                         icon: Icons.wallet,
//                         title: 'Wallet PIN ပြောင်းရန်',
//                         trailing: const Icon(
//                           Icons.edit_square,
//                           color: primaryTeal,
//                         ),
//                         onTap: () async {
//                           final result = await Navigator.push<bool>(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) =>
//                                   const ChangePinScreen(),
//                             ),
//                           );

//                           if (result == true && mounted) {
//                             _showSuccessDialog(
//                               icon: Icons.account_balance_wallet_rounded,
//                               message:
//                                   'PIN နံပါတ် အောင်မြင်စွာ ပြောင်းလဲပြီးပါပြီ။',
//                             );
//                           }
//                         },
//                       ),

//                       _buildSettingItem(
//                         icon: Icons.lock_outline,
//                         title: 'လျှို့ဝှက်နံပါတ် ပြောင်းရန်',
//                         trailing: const Icon(
//                           Icons.edit_square,
//                           color: primaryTeal,
//                         ),
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) =>
//                                   const ChangePasswordScreen(),
//                             ),
//                           );
//                         },
//                       ),

//                       const SizedBox(height: 30),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildContactInfoTile({
//     required IconData icon,
//     required String label,
//     required String value,
//     required Color lightBgColor,
//     required Color primaryTeal,
//   }) {
//     return Row(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(7),
//           decoration: BoxDecoration(
//             color: lightBgColor,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Icon(icon, color: primaryTeal, size: 18),
//         ),
//         const SizedBox(width: 8),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 label,
//                 style: const TextStyle(
//                   fontSize: 10,
//                   color: Colors.grey,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               const SizedBox(height: 2),
//               Text(
//                 value,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: const TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSettingItem({
//     required IconData icon,
//     required String title,
//     required Widget trailing,
//     VoidCallback? onTap,
//   }) {
//     return Column(
//       children: [
//         ListTile(
//           contentPadding: EdgeInsets.zero,
//           leading: Icon(icon, color: const Color(0xFF007A87)),
//           title: Text(
//             title,
//             style: const TextStyle(
//               fontSize: 15,
//               fontWeight: FontWeight.w500,
//               color: Colors.black87,
//             ),
//           ),
//           trailing: trailing,
//           onTap: onTap,
//         ),
//         const Divider(height: 1, color: Color(0xFFF0F0F0)),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smartcanteen/model/user_model.dart';
import 'package:smartcanteen/service/api_service.dart';
import 'package:smartcanteen/service/secure_storage_service.dart';
import 'package:smartcanteen/service/shared_preferences_service.dart';
import 'package:smartcanteen/view/change_password_screen.dart';
import 'package:smartcanteen/view/change_phone_screen.dart';
import 'package:smartcanteen/view/change_pin_screen.dart';
import 'package:smartcanteen/view/enter_email_screen.dart';
import 'package:smartcanteen/view/loginscreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isNotificationOn = true;
  bool isDarkModeOn = false;
  String selectedLanguage = 'EN';

  // Dynamic Profile State Variables
  bool isLoading = true;
  String name = '';
  String studentId = '';
  String email = '';
  String phone = '';
  String initials = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Roll Number ကို 3 Digits Auto Format လုပ်ပေးသည့် Function
  String _formatStudentId(String rawId) {
    if (rawId.isEmpty) return '';

    if (rawId.contains('-')) {
      List<String> parts = rawId.split('-');
      String prefix = parts.sublist(0, parts.length - 1).join('-');
      String rollNumStr = parts.last.trim();

      if (RegExp(r'^\d+$').hasMatch(rollNumStr)) {
        String paddedRoll = rollNumStr.padLeft(3, '0');
        return '$prefix-$paddedRoll';
      }
    }
    return rawId;
  }

  // Fetch user data from SharedPreferences
  Future<void> _loadUserData() async {
    try {
      UserModel? user = await SharedPreferencesService.getUser();
      if (user != null && mounted) {
        setState(() {
          name = user.userName;
          email = user.userEmail;
          phone = user.userPhone;

          String rawStudentId = user.student?.studentId.toString() ?? '';
          studentId = _formatStudentId(rawStudentId);

          _updateInitials(name);
          isLoading = false;
        });
      } else if (mounted) {
        setState(() {
          name = 'Guest';
          initials = 'G';
          email = '-';
          phone = '-';
          studentId = '';
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          name = 'Guest';
          initials = 'G';
          isLoading = false;
        });
      }
    }
  }

  void _updateInitials(String newName) {
    List<String> names = newName.trim().split(' ');
    if (names.length >= 2 && names[0].isNotEmpty && names[1].isNotEmpty) {
      initials = '${names[0][0]}${names[1][0]}'.toUpperCase();
    } else if (names.isNotEmpty && names[0].isNotEmpty) {
      initials = names[0]
          .substring(0, names[0].length >= 2 ? 2 : 1)
          .toUpperCase();
    } else {
      initials = 'U';
    }
  }
// Screen အလယ်တွင် ပြသပေးမည့် Dynamic Custom Success Dialog Box
  void _showSuccessDialog({required IconData icon, required String message}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEBF6F7),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: const Color(0xFF007A87), size: 36),
                ),
                const SizedBox(height: 20),
                const Text(
                  'အောင်မြင်ပါသည်',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF007A87),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),
                // --- OK Button Added Here ---
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF007A87),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'အတည်ပြုသည်', // OK
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  final ApiService _apiService = ApiService();

  Future<void> _handleLogout() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(color: Color(0xFF007A87)),
      ),
    );

    try {
      await _apiService.logoutUser();
    } catch (e) {
      print("Logout API error: $e");
    }

    await SecureStorageService.clearAll();
    await SharedPreferencesService.clearAll();

    if (mounted) {
      context.go('/login');
    }
  }

  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: const Text(
            'အကောင့်ထွက်ရန်',
            style: TextStyle(
              color: Color(0xFF007A87),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'အကောင့်မှ ထွက်မည်မှာ သေချာပါသလား?',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16.0,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'မလုပ်ပါ။',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _handleLogout();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF007A87),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 12.0),
                    ),
                    child: const Text(
                      'ထွက်မည်',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryTeal = Color(0xff117992);
    const lightBgColor = Color(0xFFEBF6F7);
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    if (isLoading) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator(color: primaryTeal)),
      );
    }

    bool isLoggedin = name.isNotEmpty && name != 'Guest';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          if (isLoggedin)
            Padding(
              padding: const EdgeInsets.only(top: 25.0, right: 20),
              child: IconButton(
                icon: const Icon(Icons.logout_sharp, color: Colors.white),
                onPressed: () {
                  _showLogoutConfirmationDialog();
                },
              ),
            ),
        ],
        backgroundColor: primaryTeal,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 20,
                        right: 20,
                        bottom: 65,
                      ),
                      decoration: const BoxDecoration(
                        color: primaryTeal,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(32),
                          bottomRight: Radius.circular(32),
                        ),
                      ),
                      child: Column(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 90,
                                height: 90,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Text(
                                    initials,
                                    style: const TextStyle(
                                      fontSize: 38,
                                      fontWeight: FontWeight.bold,
                                      color: primaryTeal,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                name.isNotEmpty ? name : 'Guest',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              if (studentId.isNotEmpty) ...[
                                const SizedBox(height: 4),
                                Text(
                                  studentId,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white.withValues(alpha: 0.85),
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: -27,
                      left: screenWidth > 600 ? (screenWidth - 500) / 2 : 20,
                      right: screenWidth > 600 ? (screenWidth - 500) / 2 : 20,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 14,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              Expanded(
                                child: _buildContactInfoTile(
                                  icon: Icons.email_outlined,
                                  label: 'အီးမေးလ်',
                                  value: email.isNotEmpty ? email : '-',
                                  lightBgColor: lightBgColor,
                                  primaryTeal: primaryTeal,
                                ),
                              ),
                              VerticalDivider(
                                width: 16,
                                thickness: 1,
                                color: Colors.grey.shade300,
                              ),
                              Expanded(
                                child: _buildContactInfoTile(
                                  icon: Icons.phone_outlined,
                                  label: 'ဖုန်းနံပါတ်',
                                  value: phone.isNotEmpty ? phone.trim() : '-',
                                  lightBgColor: lightBgColor,
                                  primaryTeal: primaryTeal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
        
                // --- ACCOUNT SETTINGS SECTION (Conditional Rendering) ---
                isLoggedin
                    ? Center(
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 600),
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'အကောင့် ဆက်တင်များ',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  letterSpacing: 0.8,
                                ),
                              ),
                              const SizedBox(height: 10),
                              _buildSettingItem(
                                icon: Icons.notifications_none,
                                title: 'အသိပေးချက်များ',
                                trailing: Switch(
                                  value: isNotificationOn,
                                  activeThumbColor: primaryTeal,
                                  onChanged: (val) {
                                    setState(() => isNotificationOn = val);
                                  },
                                ),
                              ),
                              _buildSettingItem(
                                icon: Icons.phone,
                                title: 'ဖုန်းနံပါတ် ပြောင်းရန်',
                                trailing: const Icon(Icons.edit_square,
                                    color: primaryTeal),
                                onTap: () async {
                                  final result = await Navigator.push<bool>(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChangePhoneScreen(
                                        initialData: {
                                          'name': name,
                                          'studentId': studentId,
                                          'phone': phone,
                                          'email': email,
                                        },
                                      ),
                                    ),
                                  );
        
                                  if (result == true && mounted) {
                                    _loadUserData();
                                    _showSuccessDialog(
                                      icon: Icons.phone_android_rounded,
                                      message:
                                          'ဖုန်းနံပါတ် ပြောင်းလဲခြင်း အောင်မြင်ပါပြီ။',
                                    );
                                  }
                                },
                              ),
                              _buildSettingItem(
                                icon: Icons.wallet,
                                title: 'Wallet PIN မေ့နေပါသလား',
                                trailing: const Icon(Icons.edit_square,
                                    color: primaryTeal),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const EnterEmailScreen(),
                                    ),
                                  );
                                },
                              ),
                              _buildSettingItem(
                                icon: Icons.wallet,
                                title: 'Wallet PIN ပြောင်းရန်',
                                trailing: const Icon(Icons.edit_square,
                                    color: primaryTeal),
                                onTap: () async {
                                  final result = await Navigator.push<bool>(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ChangePinScreen(),
                                    ),
                                  );
        
                                  if (result == true && mounted) {
                                    _showSuccessDialog(
                                      icon: Icons
                                          .account_balance_wallet_rounded,
                                      message:
                                          'PIN နံပါတ် အောင်မြင်စွာ ပြောင်းလဲပြီးပါပြီ။',
                                    );
                                  }
                                },
                              ),
                              _buildSettingItem(
                                icon: Icons.lock_outline,
                                title: 'လျှို့ဝှက်နံပါတ် ပြောင်းရန်',
                                trailing: const Icon(Icons.edit_square,
                                    color: primaryTeal),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ChangePasswordScreen(),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 30),
                            ],
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Center(
                          child: Text(
                            'ဆက်တင်များကို ကြည့်ရှုရန် အကောင့်ဝင်ရန် လိုအပ်ပါသည်။',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactInfoTile({
    required IconData icon,
    required String label,
    required String value,
    required Color lightBgColor,
    required Color primaryTeal,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: lightBgColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: primaryTeal, size: 18),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(icon, color: const Color(0xFF007A87)),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          trailing: trailing,
          onTap: onTap,
        ),
        const Divider(height: 1, color: Color(0xFFF0F0F0)),
      ],
    );
  }
}