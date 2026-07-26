// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart'; // GoRouter သုံးဖို့အတွက် import ထည့်ထားပါတယ်

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   bool _notificationsOn = false;
//   bool _darkModeOn = false;
//   String _selectedLanguage = 'EN';

//   @override
//   Widget build(BuildContext context) {
//     // Custom colors from the UI image
//     const primaryTeal = Color(0xFF006D60);
//     const goldColor = Color(0xFFB48346);

//     return Scaffold(
//       // Background Color ကို မိုးပြာရောင် (Light Blue) ပြောင်းလဲထားပါတယ်
//       backgroundColor: Colors.lightBlue.shade50,

//       // Home Screen ပြန်သွားဖို့အတွက် AppBar နှင့် Back Arrow ထည့်သွင်းထားပါတယ်
//       appBar: AppBar(
//         backgroundColor: Colors
//             .transparent, // background နဲ့ တစ်သားတည်းဖြစ်အောင် transparent လုပ်ထားပါတယ်
//         elevation: 0, // အောက်ခြေလိုင်း ပျောက်အောင်ပါ
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black87),
//           onPressed: () {
//             context.go('/home'); // Home Screen ကို ပြန်သွားမယ့် လမ်းကြောင်း
//           },
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               // --- PROFILE HEADER ---
//               CircleAvatar(
//                 radius: 50,
//                 backgroundColor: Colors.grey.shade400,
//                 child: const Icon(Icons.person, size: 60, color: Colors.white),
//               ),
//               const SizedBox(height: 12),
//               const Text(
//                 'Wa Thon',
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87,
//                 ),
//               ),
//               const Text(
//                 'wathon.dev@email.mm',
//                 style: TextStyle(color: Colors.grey, fontSize: 13),
//               ),
//               const Text(
//                 '+95 9 778 123 456',
//                 style: TextStyle(color: Colors.grey, fontSize: 13),
//               ),
//               const SizedBox(height: 24),

//               // --- ACCOUNT SETTINGS ---
//               _buildSectionHeader('ACCOUNT SETTINGS', goldColor),
//               _buildSectionCard([
//                 _buildListTile(
//                   Icons.person_outline,
//                   'Edit Profile',
//                   onTap: () {},
//                 ),
//                 _buildDivider(),
//                 _buildSwitchTile(
//                   Icons.notifications_none_outlined,
//                   'Notifications',
//                   _notificationsOn,
//                   (val) {
//                     setState(() => _notificationsOn = val);
//                   },
//                 ),
//                 _buildDivider(),
//                 _buildLanguageTile(Icons.language_outlined, 'Language'),
//                 _buildDivider(),
//                 _buildSwitchTile(
//                   Icons.dark_mode_outlined,
//                   'Dark Mode',
//                   _darkModeOn,
//                   (val) {
//                     setState(() => _darkModeOn = val);
//                   },
//                 ),
//                 _buildDivider(),
//                 _buildListTile(
//                   Icons.help_outline_outlined,
//                   'Help Center',
//                   onTap: () {},
//                 ),
//                 _buildDivider(),
//                 _buildListTile(
//                   Icons.description_outlined,
//                   'Terms & Conditions',
//                   onTap: () {},
//                 ),
//               ]),
//               const SizedBox(height: 32),

//               // --- LOG OUT BUTTON ---
//               SizedBox(
//                 width: double.infinity,
//                 height: 54,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Log out action
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: primaryTeal,
//                     elevation: 0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(27),
//                     ),
//                   ),
//                   child: const Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.logout, color: Colors.white, size: 20),
//                       const SizedBox(width: 8),
//                       Text(
//                         'Log Out',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Section Label Layout
//   Widget _buildSectionHeader(String title, Color color) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.only(top: 16, bottom: 8, left: 4),
//       child: Text(
//         title,
//         style: TextStyle(
//           color: color,
//           fontSize: 13,
//           fontWeight: FontWeight.bold,
//           letterSpacing: 0.5,
//         ),
//       ),
//     );
//   }

//   // White Card Wrap holding items
//   Widget _buildSectionCard(List<Widget> children) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.03),
//             spreadRadius: 1,
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(children: children),
//     );
//   }

//   // Navigation Rows
//   Widget _buildListTile(
//     IconData icon,
//     String title, {
//     required VoidCallback onTap,
//   }) {
//     return ListTile(
//       leading: Icon(icon, color: const Color(0xFF006D60), size: 24),
//       title: Text(
//         title,
//         style: const TextStyle(
//           fontSize: 15,
//           fontWeight: FontWeight.w500,
//           color: Colors.black87,
//         ),
//       ),
//       dense: false,
//       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//       onTap: onTap,
//     );
//   }

//   // Toggle rows
//   Widget _buildSwitchTile(
//     IconData icon,
//     String title,
//     bool value,
//     ValueChanged<bool> onChanged,
//   ) {
//     return ListTile(
//       leading: Icon(icon, color: const Color(0xFF006D60), size: 24),
//       title: Text(
//         title,
//         style: const TextStyle(
//           fontSize: 15,
//           fontWeight: FontWeight.w500,
//           color: Colors.black87,
//         ),
//       ),
//       trailing: Switch(
//         value: value,
//         onChanged: onChanged,
//         activeColor: Colors.white,
//         activeTrackColor: const Color(0xFF006D60),
//         inactiveTrackColor: Colors.grey.shade300,
//         inactiveThumbColor: Colors.white,
//         trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
//       ),
//       dense: false,
//       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//     );
//   }

//   // Custom Selector segment row for Languages
//   Widget _buildLanguageTile(IconData icon, String title) {
//     return ListTile(
//       leading: Icon(icon, color: const Color(0xFF006D60), size: 24),
//       title: Text(
//         title,
//         style: const TextStyle(
//           fontSize: 15,
//           fontWeight: FontWeight.w500,
//           color: Colors.black87,
//         ),
//       ),
//       trailing: Container(
//         decoration: BoxDecoration(
//           color: Colors.grey.shade200,
//           borderRadius: BorderRadius.circular(20),
//         ),
//         padding: const EdgeInsets.all(2),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [_buildLangOption('EN'), _buildLangOption('MY')],
//         ),
//       ),
//       dense: false,
//       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//     );
//   }

//   Widget _buildLangOption(String lang) {
//     bool isSelected = _selectedLanguage == lang;
//     return GestureDetector(
//       onTap: () => setState(() => _selectedLanguage = lang),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
//         decoration: BoxDecoration(
//           color: isSelected ? const Color(0xFF006D60) : Colors.transparent,
//           borderRadius: BorderRadius.circular(18),
//         ),
//         child: Text(
//           lang,
//           style: TextStyle(
//             fontSize: 12,
//             fontWeight: FontWeight.bold,
//             color: isSelected ? Colors.white : Colors.grey.shade600,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDivider() {
//     return Divider(
//       height: 1,
//       thickness: 0.8,
//       color: Colors.grey.withOpacity(0.15),
//       indent: 16,
//       endIndent: 16,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smartcanteen/model/user_model.dart';
import 'package:smartcanteen/service/shared_preferences_service.dart';
import 'package:smartcanteen/view/change_password.dart';
import 'package:smartcanteen/view/edit_profile.dart'; // Import ထည့်သွင်းထားပါသည်

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

  // Fetch user data from SharedPreferences using exact UserModel properties
  Future<void> _loadUserData() async {
    try {
      UserModel? user = await SharedPreferencesService.getUser();
      if (user != null && mounted) {
        setState(() {
          name = user.userName;
          email = user.userEmail;
          phone = user.userPhone;

          studentId = user.student?.studentId?.toString() ?? '';

          _updateInitials(name);
          isLoading = false;
        });
      } else if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
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

  @override
  Widget build(BuildContext context) {
    const primaryTeal = Color(0xFF007A87);
    const lightBgColor = Color(0xFFEBF6F7);
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    if (isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFFF8F9FA),
        body: Center(child: CircularProgressIndicator(color: primaryTeal)),
      );
    }

    return Scaffold(
      backgroundColor: primaryTeal,
      body: Container(
        color: const Color(0xFFF8F9FA),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- TOP HEADER AREA WITH CARD OVERLAY ---
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
                    child: SafeArea(
                      bottom: false,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                onPressed: () {
                                  if (context.canPop()) {
                                    context.pop();
                                  }
                                },
                              ),
                              const SizedBox(width: 40),
                            ],
                          ),
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
                                name.isNotEmpty ? name : 'User',
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
                  ),

                  // --- EMAIL & PHONE FLOATING CARD ---
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
                                label: 'Email',
                                value: email.isNotEmpty ? email : 'N/A',
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
                                label: 'Phone',
                                value: phone.isNotEmpty ? phone.trim() : 'N/A',
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

              // --- ACCOUNT SETTINGS SECTION ---
              Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'ACCOUNT SETTINGS',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Edit Profile (Direct Navigation / Router Error Safe Method)
                      _buildSettingItem(
                        icon: Icons.person_outline,
                        title: 'Edit Profile',
                        trailing: const Icon(
                          Icons.edit_square,
                          color: primaryTeal,
                        ),
                        onTap: () async {
                          final result = await Navigator.push<bool>(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfileScreen(
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
                          }
                        },
                      ),

                      // Change Password
                      _buildSettingItem(
                        icon: Icons.lock_outline,
                        title: 'Change Password',
                        trailing: const Icon(
                          Icons.edit_square,
                          color: primaryTeal,
                        ),
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

                      // Notifications
                      _buildSettingItem(
                        icon: Icons.notifications_none,
                        title: 'Notifications',
                        trailing: Switch(
                          value: isNotificationOn,
                          activeColor: primaryTeal,
                          onChanged: (val) {
                            setState(() => isNotificationOn = val);
                          },
                        ),
                      ),

                      // Language
                      _buildSettingItem(
                        icon: Icons.language,
                        title: 'Language',
                        trailing: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.all(3),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildLangPill('EN', selectedLanguage == 'EN'),
                              _buildLangPill('MY', selectedLanguage == 'MY'),
                            ],
                          ),
                        ),
                      ),

                      // Dark Mode
                      _buildSettingItem(
                        icon: Icons.nightlight_round_outlined,
                        title: 'Dark Mode',
                        trailing: Switch(
                          value: isDarkModeOn,
                          activeColor: primaryTeal,
                          onChanged: (val) {
                            setState(() => isDarkModeOn = val);
                          },
                        ),
                      ),

                      // Help Center
                      _buildSettingItem(
                        icon: Icons.help_outline,
                        title: 'Help Center',
                        trailing: const Icon(
                          Icons.chevron_right,
                          color: Colors.grey,
                        ),
                        onTap: () {},
                      ),

                      // Terms & Conditions
                      _buildSettingItem(
                        icon: Icons.article_outlined,
                        title: 'Terms & Conditions',
                        trailing: const Icon(
                          Icons.chevron_right,
                          color: Colors.grey,
                        ),
                        onTap: () {},
                      ),

                      const SizedBox(height: 25),

                      // Log Out Button
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Color(0xFFD9534F),
                              width: 1.5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            _showLogoutDialog(context);
                          },
                          icon: const Icon(
                            Icons.logout,
                            color: Color(0xFFD9534F),
                            size: 20,
                          ),
                          label: const Text(
                            'Log Out',
                            style: TextStyle(
                              color: Color(0xFFD9534F),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
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

  Widget _buildLangPill(String label, bool isActive) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLanguage = label;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF007A87) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: isActive ? Colors.white : Colors.grey.shade600,
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Log Out'),
          content: const Text('Are you sure you want to log out?'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                await SharedPreferencesService.clearAll();
                if (context.mounted) {
                  context.go('/login');
                }
              },
              child: const Text(
                'Log Out',
                style: TextStyle(color: Color(0xFFD9534F)),
              ),
            ),
          ],
        );
      },
    );
  }
}
