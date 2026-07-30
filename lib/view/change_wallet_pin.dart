// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:smartcanteen/service/api_service.dart';

// class ChangeWalletPinScreen extends StatefulWidget {
//   const ChangeWalletPinScreen({super.key});

//   @override
//   State<ChangeWalletPinScreen> createState() => _ChangeWalletPinScreenState();
// }

// class _ChangeWalletPinScreenState extends State<ChangeWalletPinScreen> {
//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController _oldPinController = TextEditingController();
//   final TextEditingController _newPinController = TextEditingController();
//   final TextEditingController _confirmPinController = TextEditingController();

//   bool _isOldPinObscure = true;
//   bool _isNewPinObscure = true;
//   bool _isConfirmPinObscure = true;
//   bool _isLoading = false;

//   final ApiService _apiService = ApiService();

//   @override
//   void dispose() {
//     _oldPinController.dispose();
//     _newPinController.dispose();
//     _confirmPinController.dispose();
//     super.dispose();
//   }

//   Future<void> _handleChangePin() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() => _isLoading = true);

//     try {
//       final success = await _apiService.changePin(
//         oldPin: _oldPinController.text.trim(),
//         newPin: _newPinController.text.trim(),
//       );

//       if (mounted) {
//         if (success) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('PIN နံပါတ် အောင်မြင်စွာ ပြောင်းလဲပြီးပါပြီ'),
//               backgroundColor: Colors.green,
//             ),
//           );
//           Navigator.pop(context);
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text(
//                 'PIN ပြောင်းလဲခြင်း မအောင်မြင်ပါ။ ကျေးဇူးပြု၍ ပြန်လည်ကြိုးစားပါ',
//               ),
//               backgroundColor: Colors.red,
//             ),
//           );
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
//         );
//       }
//     } finally {
//       if (mounted) {
//         setState(() => _isLoading = false);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     const primaryTeal = Color(0xFF007A87);

//     return Scaffold(
//       backgroundColor: primaryTeal,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: Column(
//         children: [
//           // Header
//           Container(
//             padding: const EdgeInsets.only(bottom: 30),
//             child: Column(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.2),
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(
//                     Icons.wallet,
//                     color: Colors.white,
//                     size: 40,
//                   ),
//                 ),
//                 const SizedBox(height: 15),
//                 const Text(
//                   'PIN နံပါတ် ပြောင်းလဲရန်',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Form Section
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.only(left: 24, right: 24, top: 30),
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(30),
//                   topRight: Radius.circular(30),
//                 ),
//               ),
//               child: SingleChildScrollView(
//                 child: Form(
//                   key: _formKey,
//                   // Form Level တွင် autovalidateMode မသုံးပါ
//                   child: Column(
//                     children: [
//                       const SizedBox(height: 10),

//                       // ===== လက်ရှိ PIN =====
//                       _buildPinFormField(
//                         controller: _oldPinController,
//                         labelText: 'လက်ရှိ PIN နံပါတ်',
//                         hintText: 'ဂဏန်း ၆ လုံး ရိုက်ထည့်ပါ',
//                         isObscure: _isOldPinObscure,
//                         prefixIcon: Icons.lock_open_outlined,
//                         onToggleVisibility: () {
//                           setState(() {
//                             _isOldPinObscure = !_isOldPinObscure;
//                           });
//                         },
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'လက်ရှိ PIN နံပါတ် ရိုက်ထည့်ပါ';
//                           }
//                           if (value.length < 6) {
//                             return 'PIN နံပါတ် ဂဏန်း ၆ လုံး ရှိရပါမည်';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 25),

//                       // ===== PIN သစ် =====
//                       _buildPinFormField(
//                         controller: _newPinController,
//                         labelText: 'PIN နံပါတ်အသစ်',
//                         hintText: 'ဂဏန်း ၆ လုံး ရိုက်ထည့်ပါ',
//                         isObscure: _isNewPinObscure,
//                         prefixIcon: Icons.lock_outline,
//                         onToggleVisibility: () {
//                           setState(() {
//                             _isNewPinObscure = !_isNewPinObscure;
//                           });
//                         },
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'PIN နံပါတ်အသစ် ရိုက်ထည့်ပါ';
//                           }
//                           if (value.length < 6) {
//                             return 'PIN နံပါတ် ဂဏန်း ၆ လုံး ရှိရပါမည်';
//                           }
//                           if (value == _oldPinController.text) {
//                             return 'PIN အသစ်သည် လက်ရှိ PIN နှင့် မတူရပါ';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 25),

//                       // ===== PIN သစ် အတည်ပြုရန် =====
//                       _buildPinFormField(
//                         controller: _confirmPinController,
//                         labelText: 'PIN နံပါတ်အသစ် အတည်ပြုရန်',
//                         hintText: 'PIN နံပါတ်အသစ် ပြန်ရိုက်ထည့်ပါ',
//                         isObscure: _isConfirmPinObscure,
//                         prefixIcon: Icons.check_circle_outline,
//                         onToggleVisibility: () {
//                           setState(() {
//                             _isConfirmPinObscure = !_isConfirmPinObscure;
//                           });
//                         },
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'PIN နံပါတ်အသစ် အတည်ပြုပေးပါ';
//                           }
//                           if (value != _newPinController.text) {
//                             return 'PIN နံပါတ် ကိုက်ညီမှု မရှိပါ';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 40),

//                       // Submit Button
//                       SizedBox(
//                         width: double.infinity,
//                         height: 52,
//                         child: ElevatedButton(
//                           onPressed: _isLoading ? null : _handleChangePin,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: primaryTeal,
//                             foregroundColor: Colors.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                             elevation: 0,
//                           ),
//                           child: _isLoading
//                               ? const SizedBox(
//                                   height: 24,
//                                   width: 24,
//                                   child: CircularProgressIndicator(
//                                     color: Colors.white,
//                                     strokeWidth: 2.5,
//                                   ),
//                                 )
//                               : const Text(
//                                   'အတည်ပြုမည်',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                         ),
//                       ),
//                       const SizedBox(height: 30),
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

//   Widget _buildPinFormField({
//     required TextEditingController controller,
//     required String labelText,
//     required String hintText,
//     required bool isObscure,
//     required IconData prefixIcon,
//     required VoidCallback onToggleVisibility,
//     required String? Function(String?) validator,
//   }) {
//     const primaryTeal = Color(0xFF007A87);

//     return TextFormField(
//       controller: controller,
//       // Field တစ်ခုချင်းစီအတွက်သာ autovalidateMode ထားပါမည်
//       autovalidateMode: AutovalidateMode.onUserInteraction,
//       obscureText: isObscure,
//       keyboardType: TextInputType.number,
//       maxLength: 6,
//       inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//       style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//       decoration: InputDecoration(
//         labelText: labelText,
//         hintText: hintText,
//         floatingLabelBehavior: FloatingLabelBehavior.auto,
//         floatingLabelStyle: const TextStyle(
//           color: primaryTeal,
//           fontWeight: FontWeight.bold,
//           fontSize: 14,
//         ),
//         labelStyle: TextStyle(color: Colors.grey.shade600, fontSize: 14),
//         hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
//         counterText: "",
//         contentPadding: const EdgeInsets.symmetric(
//           vertical: 16,
//           horizontal: 14,
//         ),
//         prefixIcon: Icon(prefixIcon, color: primaryTeal, size: 22),
//         suffixIcon: IconButton(
//           icon: Icon(
//             isObscure
//                 ? Icons.visibility_off_outlined
//                 : Icons.visibility_outlined,
//             color: Colors.grey,
//             size: 22,
//           ),
//           onPressed: onToggleVisibility,
//         ),
//         filled: true,
//         fillColor: Colors.white,
//         errorStyle: const TextStyle(
//           color: Colors.redAccent,
//           fontSize: 12,
//           fontWeight: FontWeight.w500,
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16),
//           borderSide: BorderSide(color: Colors.grey.shade300),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16),
//           borderSide: const BorderSide(color: primaryTeal, width: 1.8),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16),
//           borderSide: const BorderSide(color: Colors.redAccent, width: 1),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16),
//           borderSide: const BorderSide(color: Colors.redAccent, width: 1.8),
//         ),
//       ),
//       validator: validator,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartcanteen/service/api_service.dart';

class ChangeWalletPinScreen extends StatefulWidget {
  const ChangeWalletPinScreen({super.key});

  @override
  State<ChangeWalletPinScreen> createState() => _ChangeWalletPinScreenState();
}

class _ChangeWalletPinScreenState extends State<ChangeWalletPinScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _oldPinController = TextEditingController();
  final TextEditingController _newPinController = TextEditingController();
  final TextEditingController _confirmPinController = TextEditingController();

  bool _isOldPinObscure = true;
  bool _isNewPinObscure = true;
  bool _isConfirmPinObscure = true;
  bool _isLoading = false;

  final ApiService _apiService = ApiService();

  @override
  void dispose() {
    _oldPinController.dispose();
    _newPinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }

  Future<void> _handleChangePin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final success = await _apiService.changePin(
        oldPin: _oldPinController.text.trim(),
        newPin: _newPinController.text.trim(),
      );

      if (mounted) {
        if (success) {
          // အောင်မြင်ပါက true တန်ဖိုးဖြင့် ProfileScreen သို့ ပြန်သွားမည်
          Navigator.pop(context, true);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'PIN ပြောင်းလဲခြင်း မအောင်မြင်ပါ။ ကျေးဇူးပြု၍ ပြန်လည်ကြိုးစားပါ',
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryTeal = Color(0xFF007A87);

    return Scaffold(
      backgroundColor: primaryTeal,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.wallet,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'PIN နံပါတ် ပြောင်းလဲရန်',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Form Section
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),

                      // ===== လက်ရှိ PIN =====
                      _buildPinFormField(
                        controller: _oldPinController,
                        labelText: 'လက်ရှိ PIN နံပါတ်',
                        hintText: 'ဂဏန်း ၆ လုံး ရိုက်ထည့်ပါ',
                        isObscure: _isOldPinObscure,
                        prefixIcon: Icons.lock_open_outlined,
                        onToggleVisibility: () {
                          setState(() {
                            _isOldPinObscure = !_isOldPinObscure;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'လက်ရှိ PIN နံပါတ် ရိုက်ထည့်ပါ';
                          }
                          if (value.length < 6) {
                            return 'PIN နံပါတ် ဂဏန်း ၆ လုံး ရှိရပါမည်';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 25),

                      // ===== PIN သစ် =====
                      _buildPinFormField(
                        controller: _newPinController,
                        labelText: 'PIN နံပါတ်အသစ်',
                        hintText: 'ဂဏန်း ၆ လုံး ရိုက်ထည့်ပါ',
                        isObscure: _isNewPinObscure,
                        prefixIcon: Icons.lock_outline,
                        onToggleVisibility: () {
                          setState(() {
                            _isNewPinObscure = !_isNewPinObscure;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'PIN နံပါတ်အသစ် ရိုက်ထည့်ပါ';
                          }
                          if (value.length < 6) {
                            return 'PIN နံပါတ် ဂဏန်း ၆ လုံး ရှိရပါမည်';
                          }
                          if (value == _oldPinController.text) {
                            return 'PIN အသစ်သည် လက်ရှိ PIN နှင့် မတူရပါ';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 25),

                      // ===== PIN သစ် အတည်ပြုရန် =====
                      _buildPinFormField(
                        controller: _confirmPinController,
                        labelText: 'PIN နံပါတ်အသစ် အတည်ပြုရန်',
                        hintText: 'PIN နံပါတ်အသစ် ပြန်ရိုက်ထည့်ပါ',
                        isObscure: _isConfirmPinObscure,
                        prefixIcon: Icons.check_circle_outline,
                        onToggleVisibility: () {
                          setState(() {
                            _isConfirmPinObscure = !_isConfirmPinObscure;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'PIN နံပါတ်အသစ် အတည်ပြုပေးပါ';
                          }
                          if (value != _newPinController.text) {
                            return 'PIN နံပါတ် ကိုက်ညီမှု မရှိပါ';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 40),

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleChangePin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryTeal,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,
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
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 30),
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

  Widget _buildPinFormField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required bool isObscure,
    required IconData prefixIcon,
    required VoidCallback onToggleVisibility,
    required String? Function(String?) validator,
  }) {
    const primaryTeal = Color(0xFF007A87);

    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: isObscure,
      keyboardType: TextInputType.number,
      maxLength: 6,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      decoration: InputDecoration(
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
        counterText: "",
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 14,
        ),
        prefixIcon: Icon(prefixIcon, color: primaryTeal, size: 22),
        suffixIcon: IconButton(
          icon: Icon(
            isObscure
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: Colors.grey,
            size: 22,
          ),
          onPressed: onToggleVisibility,
        ),
        filled: true,
        fillColor: Colors.white,
        errorStyle: const TextStyle(
          color: Colors.redAccent,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
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
      ),
      validator: validator,
    );
  }
}
