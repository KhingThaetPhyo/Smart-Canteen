// import 'package:flutter/material.dart';
// import 'package:smartcanteen/service/api_service.dart';

// class ChangePasswordScreen extends StatefulWidget {
//   const ChangePasswordScreen({super.key});

//   @override
//   State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
// }

// class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final ApiService _apiService = ApiService();

//   final TextEditingController _currentPasswordController =
//       TextEditingController();
//   final TextEditingController _newPasswordController = TextEditingController();
//   final TextEditingController _confirmPasswordController =
//       TextEditingController();

//   bool _isCurrentPasswordVisible = false;
//   bool _isNewPasswordVisible = false;
//   bool _isConfirmPasswordVisible = false;
//   bool _isLoading = false;

//   static const primaryTeal = Color(0xFF007A87);
//   static const backgroundColor = Color(0xFFF8FAFC);

//   @override
//   void dispose() {
//     _currentPasswordController.dispose();
//     _newPasswordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }

//   void _handleChangePassword() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() => _isLoading = true);

//     final result = await _apiService.changePassword(
//       currentPassword: _currentPasswordController.text.trim(),
//       newPassword: _newPasswordController.text.trim(),
//       confirmPassword: _confirmPasswordController.text.trim(),
//     );

//     setState(() => _isLoading = false);

//     if (!mounted) return;

//     if (result['success'] == true) {
//       _showResultDialog(
//         title: 'အောင်မြင်ပါသည်',
//         message:
//             result['message'] ??
//             'Password ကို အောင်မြင်စွာ ပြောင်းလဲပြီးပါပြီ။',
//         isSuccess: true,
//         onOkPressed: () {
//           Navigator.pop(context); // Dialog ပိတ်မည်
//           Navigator.pop(context); // Profile Screen သို့ ပြန်သွားမည်
//         },
//       );
//     } else {
//       _showResultDialog(
//         title: 'မအောင်မြင်ပါ',
//         message: result['message'] ?? 'Password ပြောင်းလဲခြင်း မအောင်မြင်ပါ။',
//         isSuccess: false,
//         onOkPressed: () => Navigator.pop(context),
//       );
//     }
//   }

//   void _showResultDialog({
//     required String title,
//     required String message,
//     required bool isSuccess,
//     required VoidCallback onOkPressed,
//   }) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         contentPadding: const EdgeInsets.all(24),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: (isSuccess ? primaryTeal : Colors.redAccent).withOpacity(
//                   0.1,
//                 ),
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 isSuccess
//                     ? Icons.check_circle_rounded
//                     : Icons.error_outline_rounded,
//                 color: isSuccess ? primaryTeal : Colors.redAccent,
//                 size: 50,
//               ),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: isSuccess ? primaryTeal : Colors.redAccent,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               message,
//               textAlign: TextAlign.center,
//               style: const TextStyle(fontSize: 14, color: Colors.black87),
//             ),
//             const SizedBox(height: 20),
//             SizedBox(
//               width: double.infinity,
//               height: 45,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: isSuccess ? primaryTeal : Colors.redAccent,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 onPressed: onOkPressed,
//                 child: const Text(
//                   'OK',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: primaryTeal,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: Column(
//         children: [
//           // Header Section
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 12.0),
//             child: Column(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.15),
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(
//                     Icons.lock_reset_rounded,
//                     size: 48,
//                     color: Colors.white,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 const Text(
//                   'Change Password',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Form Container
//           Expanded(
//             child: Container(
//               width: double.infinity,
//               decoration: const BoxDecoration(
//                 color: backgroundColor,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(32),
//                   topRight: Radius.circular(32),
//                 ),
//               ),
//               child: SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 padding: const EdgeInsets.all(24.0),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Current Password Field
//                       _buildInputLabel('CURRENT PASSWORD'),
//                       const SizedBox(height: 8),
//                       TextFormField(
//                         controller: _currentPasswordController,
//                         obscureText: !_isCurrentPasswordVisible,
//                         validator: (val) => val == null || val.isEmpty
//                             ? 'လက်ရှိ Password ကို ရိုက်ထည့်ပါ'
//                             : null,
//                         style: const TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w600,
//                         ),
//                         decoration: _buildInputDecoration(
//                           hintText: 'Enter current password',
//                           prefixIcon: Icons.lock_clock_outlined,
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               _isCurrentPasswordVisible
//                                   ? Icons.visibility_outlined
//                                   : Icons.visibility_off_outlined,
//                               color: Colors.grey,
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 _isCurrentPasswordVisible =
//                                     !_isCurrentPasswordVisible;
//                               });
//                             },
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 18),

//                       // New Password Field
//                       _buildInputLabel('NEW PASSWORD'),
//                       const SizedBox(height: 8),
//                       TextFormField(
//                         controller: _newPasswordController,
//                         obscureText: !_isNewPasswordVisible,
//                         validator: (val) {
//                           if (val == null || val.isEmpty) {
//                             return 'Password အသစ် ရိုက်ထည့်ပါ';
//                           }
//                           if (val.length < 6) {
//                             return 'Password သည် အနည်းဆုံး ၆ လုံး ရှိရပါမည်';
//                           }
//                           return null;
//                         },
//                         style: const TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w600,
//                         ),
//                         decoration: _buildInputDecoration(
//                           hintText: 'Enter new password',
//                           prefixIcon: Icons.lock_outline_rounded,
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               _isNewPasswordVisible
//                                   ? Icons.visibility_outlined
//                                   : Icons.visibility_off_outlined,
//                               color: Colors.grey,
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 _isNewPasswordVisible = !_isNewPasswordVisible;
//                               });
//                             },
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 18),

//                       // Confirm Password Field
//                       _buildInputLabel('CONFIRM NEW PASSWORD'),
//                       const SizedBox(height: 8),
//                       TextFormField(
//                         controller: _confirmPasswordController,
//                         obscureText: !_isConfirmPasswordVisible,
//                         validator: (val) {
//                           if (val == null || val.isEmpty) {
//                             return 'Password အသစ်ကို ထပ်မံရိုက်ထည့်ပါ';
//                           }
//                           if (val != _newPasswordController.text) {
//                             return 'Password များ ကိုက်ညီမှု မရှိပါ';
//                           }
//                           return null;
//                         },
//                         style: const TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w600,
//                         ),
//                         decoration: _buildInputDecoration(
//                           hintText: 'Re-enter new password',
//                           prefixIcon: Icons.check_circle_outline_rounded,
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               _isConfirmPasswordVisible
//                                   ? Icons.visibility_outlined
//                                   : Icons.visibility_off_outlined,
//                               color: Colors.grey,
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 _isConfirmPasswordVisible =
//                                     !_isConfirmPasswordVisible;
//                               });
//                             },
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 30),

//                       // Save Changes Button
//                       SizedBox(
//                         width: double.infinity,
//                         height: 52,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: primaryTeal,
//                             elevation: 3,
//                             shadowColor: primaryTeal.withOpacity(0.3),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                           ),
//                           onPressed: _isLoading ? null : _handleChangePassword,
//                           child: _isLoading
//                               ? const SizedBox(
//                                   width: 24,
//                                   height: 24,
//                                   child: CircularProgressIndicator(
//                                     color: Colors.white,
//                                     strokeWidth: 2.5,
//                                   ),
//                                 )
//                               : const Text(
//                                   'Save Changes',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildInputLabel(String label) {
//     return Text(
//       label,
//       style: TextStyle(
//         fontSize: 11,
//         fontWeight: FontWeight.w700,
//         color: Colors.grey.shade600,
//         letterSpacing: 0.8,
//       ),
//     );
//   }

//   InputDecoration _buildInputDecoration({
//     required String hintText,
//     required IconData prefixIcon,
//     Widget? suffixIcon,
//   }) {
//     return InputDecoration(
//       hintText: hintText,
//       hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
//       prefixIcon: Icon(prefixIcon, color: primaryTeal, size: 20),
//       suffixIcon: suffixIcon,
//       filled: true,
//       fillColor: Colors.white,
//       contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(16),
//         borderSide: BorderSide(color: Colors.grey.shade200),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(16),
//         borderSide: const BorderSide(color: primaryTeal, width: 1.5),
//       ),
//       errorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(16),
//         borderSide: const BorderSide(color: Colors.redAccent, width: 1),
//       ),
//       focusedErrorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(16),
//         borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:smartcanteen/service/api_service.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiService _apiService = ApiService();

  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isCurrentPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;

  static const primaryTeal = Color(0xFF007A87);
  static const backgroundColor = Color(0xFFF8FAFC);

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Dynamic Myanmar Suggestions Validator
  String? _validatePasswordWithSuggestions(String? value) {
    if (value == null || value.isEmpty) {
      return 'လျှို့ဝှက်နံပါတ်အသစ် ရိုက်ထည့်ပါ';
    }

    if (value.length < 8) {
      return 'လျှို့ဝှက်နံပါတ်သည် အနည်းဆုံး ၈ လုံး ရှိရပါမည်';
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'စာလုံးကြီး (Uppercase) အနည်းဆုံး ၁ လုံး ပါဝင်ရပါမည်';
    }

    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'အထူးသင်္ကေတ (ဥပမာ - @, #) အနည်းဆုံး ၁ ခု ပါဝင်ရပါမည်';
    }

    return null;
  }

  void _handleChangePassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final result = await _apiService.changePassword(
      currentPassword: _currentPasswordController.text.trim(),
      newPassword: _newPasswordController.text.trim(),
      confirmPassword: _confirmPasswordController.text.trim(),
    );

    setState(() => _isLoading = false);

    if (!mounted) return;

    if (result['success'] == true) {
      _showResultDialog(
        title: 'အောင်မြင်ပါသည်',
        message:
            result['message'] ??
            'လျှို့ဝှက်နံပါတ်ကို အောင်မြင်စွာ ပြောင်းလဲပြီးပါပြီ။',
        isSuccess: true,
        onOkPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
      );
    } else {
      _showResultDialog(
        title: 'မအောင်မြင်ပါ',
        message:
            result['message'] ??
            'လျှို့ဝှက်နံပါတ် ပြောင်းလဲခြင်း မအောင်မြင်ပါ။',
        isSuccess: false,
        onOkPressed: () => Navigator.pop(context),
      );
    }
  }

  void _showResultDialog({
    required String title,
    required String message,
    required bool isSuccess,
    required VoidCallback onOkPressed,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: (isSuccess ? primaryTeal : Colors.redAccent).withOpacity(
                  0.1,
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isSuccess
                    ? Icons.check_circle_rounded
                    : Icons.error_outline_rounded,
                color: isSuccess ? primaryTeal : Colors.redAccent,
                size: 50,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isSuccess ? primaryTeal : Colors.redAccent,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isSuccess ? primaryTeal : Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: onOkPressed,
                child: const Text(
                  'ဟုတ်ပြီ',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Header Section
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
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
                    size: 48,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'လျှို့ဝှက်နံပါတ် ပြောင်းလဲရန်',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Form Container
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
                  // Form Level တွင် autovalidateMode မသုံးပါ
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),

                      // Current Password Field
                      TextFormField(
                        controller: _currentPasswordController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: !_isCurrentPasswordVisible,
                        validator: (val) => val == null || val.isEmpty
                            ? 'လက်ရှိ လျှို့ဝှက်နံပါတ် ရိုက်ထည့်ပါ'
                            : null,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: _buildFloatingInputDecoration(
                          labelText: 'လက်ရှိ လျှို့ဝှက်နံပါတ်',
                          hintText: 'လက်ရှိ လျှို့ဝှက်နံပါတ် ရိုက်ထည့်ပါ',
                          prefixIcon: Icons.lock_clock_outlined,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isCurrentPasswordVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isCurrentPasswordVisible =
                                    !_isCurrentPasswordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      // New Password Field
                      TextFormField(
                        controller: _newPasswordController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: !_isNewPasswordVisible,
                        validator: _validatePasswordWithSuggestions,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: _buildFloatingInputDecoration(
                          labelText: 'လျှို့ဝှက်နံပါတ်အသစ်',
                          hintText: 'ဥပမာ - Khing12@',
                          prefixIcon: Icons.lock_outline_rounded,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isNewPasswordVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isNewPasswordVisible = !_isNewPasswordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Confirm Password Field
                      TextFormField(
                        controller: _confirmPasswordController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: !_isConfirmPasswordVisible,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'လျှို့ဝှက်နံပါတ်အသစ် အတည်ပြုပေးပါ';
                          }
                          if (val != _newPasswordController.text) {
                            return 'လျှို့ဝှက်နံပါတ်များ ကိုက်ညီမှု မရှိပါ';
                          }
                          return null;
                        },
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: _buildFloatingInputDecoration(
                          labelText: 'လျှို့ဝှက်နံပါတ်အသစ် အတည်ပြုရန်',
                          hintText: 'လျှို့ဝှက်နံပါတ်အသစ် ပြန်ရိုက်ထည့်ပါ',
                          prefixIcon: Icons.check_circle_outline_rounded,
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
                      const SizedBox(height: 35),

                      // Save Changes Button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryTeal,
                            elevation: 3,
                            shadowColor: primaryTeal.withOpacity(0.3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: _isLoading ? null : _handleChangePassword,
                          child: _isLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : const Text(
                                  'အတည်ပြုမည်',
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
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _buildFloatingInputDecoration({
    required String labelText,
    required String hintText,
    required IconData prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      floatingLabelStyle: const TextStyle(
        color: primaryTeal,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      labelStyle: TextStyle(color: Colors.grey.shade600, fontSize: 14),
      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
      prefixIcon: Icon(prefixIcon, color: primaryTeal, size: 20),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      errorStyle: const TextStyle(
        color: Colors.redAccent,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      errorMaxLines: 2,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: primaryTeal, width: 1.8),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.8),
      ),
    );
  }
}
