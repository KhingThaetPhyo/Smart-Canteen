import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // GoRouter သုံးဖို့အတွက် import ထည့်ထားပါတယ်

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificationsOn = false;
  bool _darkModeOn = false;
  String _selectedLanguage = 'EN';

  @override
  Widget build(BuildContext context) {
    // Custom colors from the UI image
    const primaryTeal = Color(0xFF006D60);
    const goldColor = Color(0xFFB48346);

    return Scaffold(
      // Background Color ကို မိုးပြာရောင် (Light Blue) ပြောင်းလဲထားပါတယ်
      backgroundColor: Colors.lightBlue.shade50,

      // Home Screen ပြန်သွားဖို့အတွက် AppBar နှင့် Back Arrow ထည့်သွင်းထားပါတယ်
      appBar: AppBar(
        backgroundColor: Colors
            .transparent, // background နဲ့ တစ်သားတည်းဖြစ်အောင် transparent လုပ်ထားပါတယ်
        elevation: 0, // အောက်ခြေလိုင်း ပျောက်အောင်ပါ
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            context.go('/navigation'); // Home Screen ကို ပြန်သွားမယ့် လမ်းကြောင်း
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // --- PROFILE HEADER ---
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey.shade400,
                child: const Icon(Icons.person, size: 60, color: Colors.white),
              ),
              const SizedBox(height: 12),
              const Text(
                'Wa Thon',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const Text(
                'wathon.dev@email.mm',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const Text(
                '+95 9 778 123 456',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 24),

              // --- ACCOUNT SETTINGS ---
              _buildSectionHeader('ACCOUNT SETTINGS', goldColor),
              _buildSectionCard([
                _buildListTile(
                  Icons.person_outline,
                  'Edit Profile',
                  onTap: () {},
                ),
                _buildDivider(),
                _buildSwitchTile(
                  Icons.notifications_none_outlined,
                  'Notifications',
                  _notificationsOn,
                  (val) {
                    setState(() => _notificationsOn = val);
                  },
                ),
                _buildDivider(),
                _buildLanguageTile(Icons.language_outlined, 'Language'),
                _buildDivider(),
                _buildSwitchTile(
                  Icons.dark_mode_outlined,
                  'Dark Mode',
                  _darkModeOn,
                  (val) {
                    setState(() => _darkModeOn = val);
                  },
                ),
                _buildDivider(),
                _buildListTile(
                  Icons.help_outline_outlined,
                  'Help Center',
                  onTap: () {},
                ),
                _buildDivider(),
                _buildListTile(
                  Icons.description_outlined,
                  'Terms & Conditions',
                  onTap: () {},
                ),
              ]),
              const SizedBox(height: 32),

              // --- LOG OUT BUTTON ---
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    // Log out action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryTeal,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout, color: Colors.white, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Log Out',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // Section Label Layout
  Widget _buildSectionHeader(String title, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 16, bottom: 8, left: 4),
      child: Text(
        title,
        style: TextStyle(
          color: color,
          fontSize: 13,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  // White Card Wrap holding items
  Widget _buildSectionCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  // Navigation Rows
  Widget _buildListTile(
    IconData icon,
    String title, {
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF006D60), size: 24),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
      dense: false,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      onTap: onTap,
    );
  }

  // Toggle rows
  Widget _buildSwitchTile(
    IconData icon,
    String title,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF006D60), size: 24),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.white,
        activeTrackColor: const Color(0xFF006D60),
        inactiveTrackColor: Colors.grey.shade300,
        inactiveThumbColor: Colors.white,
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),
      dense: false,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  // Custom Selector segment row for Languages
  Widget _buildLanguageTile(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF006D60), size: 24),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
      trailing: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [_buildLangOption('EN'), _buildLangOption('MY')],
        ),
      ),
      dense: false,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  Widget _buildLangOption(String lang) {
    bool isSelected = _selectedLanguage == lang;
    return GestureDetector(
      onTap: () => setState(() => _selectedLanguage = lang),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF006D60) : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          lang,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.grey.shade600,
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 0.8,
      color: Colors.grey.withOpacity(0.15),
      indent: 16,
      endIndent: 16,
    );
  }
}
