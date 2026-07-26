import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic>? initialData;

  const EditProfileScreen({super.key, this.initialData});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  // Theme Colors
  static const primaryTeal = Color(0xFF00838F);
  static const lightTealBg = Color(0xFFE0F2F1);
  static const backgroundColor = Color(0xFFF8FAFC);

  @override
  void initState() {
    super.initState();
    final data = widget.initialData;

    _nameController = TextEditingController(text: data?['name'] ?? 'Wa Thon');

    // Phone parsing: 09 ရဲ့ နောက်က ဂဏန်းများကိုသာ Controller ထဲထည့်မည်
    String rawPhone = data?['phone'] ?? '+95 9 778123456';
    String digitsOnly = rawPhone.replaceAll(RegExp(r'\D'), '');
    String phoneBody = '';

    if (digitsOnly.startsWith('959')) {
      phoneBody = digitsOnly.substring(3);
    } else if (digitsOnly.startsWith('09')) {
      phoneBody = digitsOnly.substring(2);
    } else if (digitsOnly.startsWith('9')) {
      phoneBody = digitsOnly.substring(1);
    } else {
      phoneBody = digitsOnly;
    }

    _phoneController = TextEditingController(text: phoneBody);
    _emailController = TextEditingController(
      text: data?['email'] ?? 'wathon.dev@gmail.com',
    );
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }
    if (!value.contains("@")) {
      return "Email must contain @";
    }
    if (!RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(value)) {
      return "Please enter a valid email address";
    }
    return null;
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      final updatedName = _nameController.text.trim();
      final updatedPhone = '09${_phoneController.text.trim()}';
      final updatedEmail = _emailController.text.trim();

      context.pop({
        'name': updatedName,
        'phone': updatedPhone,
        'email': updatedEmail,
      });
    }
  }

  String _getInitials(String name) {
    List<String> names = name.trim().split(" ");
    if (names.isEmpty || names[0].isEmpty) return "WT";
    if (names.length == 1) return names[0][0].toUpperCase();
    return "${names[0][0]}${names[1][0]}".toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryTeal,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/profile');
            }
          },
        ),
      ),
      body: Column(
        children: [
          // --- HEADER SECTION (Avatar & Name) ---
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: Text(
                    _getInitials(_nameController.text),
                    style: const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: primaryTeal,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  _nameController.text.isEmpty
                      ? 'Wa Thon'
                      : _nameController.text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),

          // --- FORM CONTAINER SECTION ---
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'EDIT INFORMATION',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          letterSpacing: 1.1,
                        ),
                      ),
                      // const SizedBox(height: 16),

                      // Full Name Field
                      // _buildInputLabel('FULL NAME'),
                      // const SizedBox(height: 8),
                      // TextFormField(
                      //   controller: _nameController,
                      //   keyboardType: TextInputType.name,
                      //   onChanged: (val) => setState(() {}),
                      //   inputFormatters: [
                      //     FilteringTextInputFormatter.allow(
                      //       RegExp(r'[a-zA-Z\s]'),
                      //     ),
                      //   ],
                      //   validator: (value) {
                      //     if (value == null || value.trim().isEmpty) {
                      //       return 'Please enter your full name';
                      //     }
                      //     return null;
                      //   },
                      //   style: const TextStyle(
                      //     fontSize: 15,
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      //   decoration: _buildInputDecoration(
                      //     hintText: 'Enter your full name',
                      //     prefixIcon: Icons.person_outline_rounded,
                      //   ),
                      // ),
                      const SizedBox(height: 18),

                      // Phone Field
                      _buildInputLabel('PHONE NUMBER'),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          MyanmarPhoneInputFormatter(),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter phone number';
                          }
                          String firstChar = value[0];
                          if (['9', '7', '6'].contains(firstChar) &&
                              value.length != 9) {
                            return 'Phone number must be 9 digits after 09';
                          }
                          if (firstChar == '4' && value.length != 8) {
                            return 'Phone number must be 8 digits after 09';
                          }
                          return null;
                        },
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: _buildInputDecoration(
                          hintText: '778123456',
                          prefixIcon: Icons.phone_outlined,
                          prefixText: '09 ',
                        ),
                      ),

                      const SizedBox(height: 18),

                      // Email Field
                      _buildInputLabel('EMAIL ADDRESS'),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: validateEmail,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: _buildInputDecoration(
                          hintText: 'wathon.dev@gmail.com',
                          prefixIcon: Icons.email_outlined,
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Save Button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryTeal,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: _saveProfile,
                          child: const Text(
                            'Save Changes',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: Colors.grey.shade600,
        letterSpacing: 0.8,
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required String hintText,
    required IconData prefixIcon,
    Widget? suffixIcon,
    String? prefixText,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
      prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 14.0, right: 10.0),
        child: Icon(prefixIcon, color: primaryTeal, size: 20),
      ),
      prefixText: prefixText,
      // Input Text ရဲ့ Font Style (15, Bold 600) နဲ့ တစ်ထပ်တည်းတူအောင် ညှိထားပါသည်
      prefixStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: primaryTeal, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
      ),
    );
  }
}

// --- PHONE NUMBER INPUT FORMATTER ---
class MyanmarPhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;
    if (text.isEmpty) return newValue;

    // ပထမဆုံးဂဏန်းသည် 9, 7, 6, 4 တစ်ခုခု ဖြစ်ရမည်
    if (!['9', '7', '6', '4'].contains(text[0])) {
      return oldValue;
    }

    // 9, 7, 6 နဲ့စရင် 09 နောက်မှာ 9 လုံး ရိုက်ခွင့်ပြုမည်
    if (['9', '7', '6'].contains(text[0])) {
      if (text.length > 9) return oldValue;
    }

    // 4 နဲ့စရင် 09 နောက်မှာ 8 လုံး ရိုက်ခွင့်ပြုမည်
    if (text[0] == '4') {
      if (text.length > 8) return oldValue;
    }

    return newValue;
  }
}
