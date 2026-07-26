import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChangePasswordScreen extends StatefulWidget {
  final Map<String, dynamic>? initialData;

  const ChangePasswordScreen({super.key, this.initialData});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  // Real-time validation states
  bool _hasMinLength = false;
  bool _hasUppercase = false;
  bool _hasLowercase = false;
  bool _hasDigit = false;
  bool _hasSpecialChar = false;

  // Modern Teal Palette Matching Profile
  static const primaryTeal = Color(0xFF00838F);
  static const backgroundColor = Color(0xFFF8FAFC);

  @override
  void initState() {
    super.initState();
    final data = widget.initialData;

    _passwordController = TextEditingController(text: data?['password'] ?? '');
    _confirmPasswordController = TextEditingController(
      text: data?['password'] ?? '',
    );

    _passwordController.addListener(_onPasswordChanged);
  }

  void _onPasswordChanged() {
    final text = _passwordController.text;
    setState(() {
      _hasMinLength = text.length >= 8;
      _hasUppercase = RegExp(r'[A-Z]').hasMatch(text);
      _hasLowercase = RegExp(r'[a-z]').hasMatch(text);
      _hasDigit = RegExp(r'\d').hasMatch(text);
      _hasSpecialChar = RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(text);
    });
  }

  @override
  void dispose() {
    _passwordController.removeListener(_onPasswordChanged);
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // --- VALIDATION FUNCTIONS ---
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (value.length < 8) {
      return "Password must be at least 8 characters";
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return "Need one uppercase letter";
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return "Need one lowercase letter";
    }
    if (!RegExp(r'\d').hasMatch(value)) {
      return "Need one digit";
    }
    if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return "Need one special character";
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Confirm your password";
    }
    if (value != _passwordController.text) {
      return "Passwords do not match";
    }
    return null;
  }

  void _savePassword() {
    if (_formKey.currentState!.validate()) {
      final updatedPassword = _passwordController.text;

      if (context.canPop()) {
        context.pop({'password': updatedPassword});
      } else {
        context.go('/profile', extra: {'password': updatedPassword});
      }
    }
  }

  void _handleBackNavigation() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/profile');
    }
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
          onPressed: _handleBackNavigation,
        ),
      ),
      body: Column(
        children: [
          // --- HEADER SECTION ---
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 17.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.lock_reset_rounded,
                    size: 57,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Change Password',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                // Text(
                //   'Set a strong & secure password',
                //   style: TextStyle(
                //     color: Colors.white.withOpacity(0.8),
                //     fontSize: 13,
                //   ),
                // ),
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
                      // const Text(
                      //   'SECURITY SETTINGS',
                      //   style: TextStyle(
                      //     fontSize: 12,
                      //     fontWeight: FontWeight.bold,
                      //     color: Colors.grey,
                      //     letterSpacing: 1.1,
                      //   ),
                      // ),
                      const SizedBox(height: 17),

                      // New Password Field
                      _buildInputLabel('NEW PASSWORD'),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        validator: _validatePassword,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: _buildInputDecoration(
                          hintText: 'Enter new password',
                          prefixIcon: Icons.lock_outline_rounded,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Confirm Password Field
                      _buildInputLabel('CONFIRM PASSWORD'),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: !_isConfirmPasswordVisible,
                        validator: _validateConfirmPassword,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: _buildInputDecoration(
                          hintText: 'Re-enter your new password',
                          prefixIcon: Icons.lock_clock_outlined,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isConfirmPasswordVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isConfirmPasswordVisible =
                                    !_isConfirmPasswordVisible;
                              });
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Clean & Dynamic Requirement Checklist (No Card Box)
                      // _buildRequirementItem(
                      //   'At least 8 characters long',
                      //   _hasMinLength,
                      // ),
                      // _buildRequirementItem(
                      //   'One uppercase & lowercase letter',
                      //   _hasUppercase && _hasLowercase,
                      // ),
                      // _buildRequirementItem(
                      //   'One number & special character',
                      //   _hasDigit && _hasSpecialChar,
                      // ),
                      const SizedBox(height: 32),

                      // Save Changes Button
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
                          onPressed: _savePassword,
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

  Widget _buildRequirementItem(String text, bool isMet) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check_circle : Icons.check_circle_outline,
            size: 16,
            color: isMet ? primaryTeal : Colors.grey.shade400,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: isMet ? Colors.black87 : Colors.grey.shade600,
              fontWeight: isMet ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required String hintText,
    required IconData prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
      prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 14.0, right: 10.0),
        child: Icon(prefixIcon, color: primaryTeal, size: 20),
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
