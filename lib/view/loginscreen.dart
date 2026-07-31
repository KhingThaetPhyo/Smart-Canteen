// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:go_router/go_router.dart';
// import 'package:smartcanteen/service/api_service.dart';
// import 'package:smartcanteen/service/secure_storage_service.dart';
// import 'package:smartcanteen/service/shared_preferences_service.dart';

// // Email Formatter: အစစာလုံး ဂဏန်း/သင်္ကေတ မရ၊ a-z ဖြင့်သာ စရမည်
// class LowercaseEmailInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//     TextEditingValue oldValue,
//     TextEditingValue newValue,
//   ) {
//     String text = newValue.text;
//     if (text.isEmpty) return newValue;

//     if (RegExp(r'[A-Z]').hasMatch(text)) {
//       return oldValue;
//     }

//     if (!RegExp(r'^[a-z]').hasMatch(text)) {
//       return oldValue;
//     }

//     return newValue;
//   }
// }

// class Loginscreen extends StatefulWidget {
//   const Loginscreen({super.key});

//   @override
//   State<Loginscreen> createState() => _LoginscreenState();
// }

// class _LoginscreenState extends State<Loginscreen> {
//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   bool _obscurePassword = true;

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   InputDecoration decoration(String label, IconData icon, String hint) {
//     return InputDecoration(
//       labelText: label,
//       hintText: hint,
//       prefixIcon: Icon(icon, color: const Color(0xff1E5ED8)),
//       filled: true,
//       fillColor: Colors.white,
//       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//       border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: const BorderSide(color: Color(0xffE5E7EB)),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: const BorderSide(color: Color(0xff1E5ED8), width: 2),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     final width = size.width;
//     final height = size.height;
//     final logoSize = width * .25;

//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Colors.white, Color(0xFFEFF7FF), Color(0xFFD6ECFF)],
//           ),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             padding: EdgeInsets.symmetric(
//               horizontal: width * .05,
//               vertical: height * .025,
//             ),
//             child: Center(
//               child: ConstrainedBox(
//                 constraints: const BoxConstraints(maxWidth: 500),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       Container(
//                         width: logoSize,
//                         height: logoSize,
//                         decoration: BoxDecoration(
//                           color: const Color(0xff0D47A1),
//                           borderRadius: BorderRadius.circular(18),
//                         ),
//                         child: Icon(
//                           Icons.restaurant,
//                           color: Colors.white,
//                           size: logoSize * .75,
//                         ),
//                       ),

//                       SizedBox(height: height * .025),

//                       Text(
//                         "SmartCanteen",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: width * .07,
//                           color: const Color(0xff0D47A1),
//                         ),
//                       ),

//                       SizedBox(height: height * .02),

//                       Container(
//                         width: double.infinity,
//                         padding: EdgeInsets.all(width * .05),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(22),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(.08),
//                               blurRadius: 18,
//                               offset: const Offset(0, 8),
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           children: [
//                             // Email Field (စစချင်း ဂဏန်း/သင်္ကေတ ရိုက်မရပါ)
//                             TextFormField(
//                               controller: _emailController,
//                               keyboardType: TextInputType.emailAddress,
//                               inputFormatters: [LowercaseEmailInputFormatter()],
//                               autovalidateMode:
//                                   AutovalidateMode.onUserInteraction,
//                               decoration: decoration(
//                                 "Email Address",
//                                 Icons.email_outlined,
//                                 "you@ucstt.edu.mm",
//                               ),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return "Email is required";
//                                 }

//                                 if (RegExp(r'[A-Z]').hasMatch(value)) {
//                                   return "Capital letters are not allowed in email";
//                                 }

//                                 if (!value.contains("@")) {
//                                   return "Edu mail must contain @";
//                                 }

//                                 if (!RegExp(
//                                   r'^[a-z][a-z0-9._%+-]*@ucstt\.edu\.mm$',
//                                 ).hasMatch(value)) {
//                                   return "Use username@ucstt.edu.mm";
//                                 }

//                                 return null;
//                               },
//                             ),

//                             SizedBox(height: height * .018),

//                             TextFormField(
//                               controller: _passwordController,
//                               obscureText: _obscurePassword,
//                               autovalidateMode:
//                                   AutovalidateMode.onUserInteraction,
//                               decoration:
//                                   decoration(
//                                     "Password",
//                                     Icons.lock_outline,
//                                     "Enter Password",
//                                   ).copyWith(
//                                     suffixIcon: IconButton(
//                                       icon: Icon(
//                                         _obscurePassword
//                                             ? Icons.visibility_outlined
//                                             : Icons.visibility_off_outlined,
//                                         color: const Color(0xff1E5ED8),
//                                       ),
//                                       onPressed: () {
//                                         setState(() {
//                                           _obscurePassword = !_obscurePassword;
//                                         });
//                                       },
//                                     ),
//                                   ),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return "Password is required";
//                                 }
//                                 return null;
//                               },
//                             ),

//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 const Text(
//                                   "",
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.black87,
//                                   ),
//                                 ),
//                                 TextButton(
//                                   onPressed: () {
//                                     // Forgot Password
//                                   },
//                                   child: const Text(
//                                     "Forgot Password?",
//                                     style: TextStyle(
//                                       color: Color(0xff1E5ED8),
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),

//                             SizedBox(height: height * .03),

//                             SizedBox(
//                               width: double.infinity,
//                               height: 55,
//                               child: ElevatedButton(
//                                 onPressed: () async {
//                                   print("Login button clicked");

//                                   if (_formKey.currentState!.validate()) {
//                                     print("Form validation passed");

//                                     try {
//                                       print("Calling loginUser API...");

//                                       final result = await ApiService()
//                                           .loginUser(
//                                             email: _emailController.text.trim(),
//                                             password: _passwordController.text
//                                                 .trim(),
//                                           );

//                                       print("API Result: $result");
//                                       if (result != null &&
//                                           result.success == true) {
//                                         print("Login successful");
//                                         await SharedPreferencesService.saveUser(
//                                           result.user!,
//                                         );

//                                         if (result.token != null) {
//                                           await SharedPreferencesService.saveToken(
//                                             result.token!,
//                                           );
//                                         }

//                                         if (result.token != null) {
//                                           await SecureStorageService.saveToken(
//                                             result.token!,
//                                           );
//                                         }

//                                         if (result.user?.fcmToken != null) {
//                                           await SecureStorageService.saveFcmToken(
//                                             result.user!.fcmToken!,
//                                           );
//                                         }

//                                         final qrData = jsonEncode({
//                                           'user_name':
//                                               result.user?.userName ?? '',
//                                           'student_id':
//                                               result.user?.student?.studentId ??
//                                               '',
//                                         });

//                                         await SecureStorageService.saveQrData(
//                                           qrData,
//                                         );

//                                         print("LOGIN QR DATA:");
//                                         print(qrData);

//                                         if (!mounted) return;

//                                         context.go(
//                                           '/navigation',
//                                           extra: qrData,
//                                         );
//                                       } else {
//                                         print(
//                                           "Login failed: ${result?.message}",
//                                         );
//                                         ScaffoldMessenger.of(
//                                           context,
//                                         ).showSnackBar(
//                                           SnackBar(
//                                             content: Text(
//                                               result?.message ??
//                                                   "Invalid email or password",
//                                             ),
//                                           ),
//                                         );
//                                       }
//                                     } catch (e) {
//                                       print("Login Error: $e");
//                                       ScaffoldMessenger.of(
//                                         context,
//                                       ).showSnackBar(
//                                         SnackBar(content: Text(e.toString())),
//                                       );
//                                     }
//                                   }
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: const Color(0xff0D47A1),
//                                   foregroundColor: Colors.white,
//                                   elevation: 0,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                 ),
//                                 child: const Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       "Login",
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     SizedBox(width: 8),
//                                     Icon(Icons.arrow_forward, size: 20),
//                                   ],
//                                 ),
//                               ),
//                             ),

//                             SizedBox(height: height * .02),
//                           ],
//                         ),
//                       ),

//                       SizedBox(height: height * .03),

//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Text(
//                             "Don't have an account? ",
//                             style: TextStyle(
//                               color: Colors.black54,
//                               fontSize: 14,
//                             ),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               context.go("/register");
//                             },
//                             style: TextButton.styleFrom(
//                               padding: EdgeInsets.zero,
//                               minimumSize: Size.zero,
//                               tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                             ),
//                             child: const Text(
//                               "Sign Up",
//                               style: TextStyle(
//                                 color: Color(0xff0D47A1),
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),

//                       SizedBox(height: height * .02),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:smartcanteen/service/api_service.dart';
import 'package:smartcanteen/service/secure_storage_service.dart';
import 'package:smartcanteen/service/shared_preferences_service.dart';

// Email Formatter: အစစာလုံး ဂဏန်း/သင်္ကေတ မရ၊ a-z ဖြင့်သာ စရမည်
class LowercaseEmailInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;
    if (text.isEmpty) return newValue;

    if (RegExp(r'[A-Z]').hasMatch(text)) {
      return oldValue;
    }

    if (!RegExp(r'^[a-z]').hasMatch(text)) {
      return oldValue;
    }

    return newValue;
  }
}

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Password Validator With Myanmar Suggestions
  String? _validatePasswordWithSuggestions(String? value) {
    if (value == null || value.isEmpty) {
      return 'လျှို့ဝှက်နံပါတ် ရိုက်ထည့်ပါ';
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

  InputDecoration decoration(String label, IconData icon, String hint) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, color: const Color(0xff1E5ED8)),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      errorMaxLines: 2,
      errorStyle: const TextStyle(
        color: Colors.redAccent,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xffE5E7EB)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xff1E5ED8), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final width = size.width;
    final height = size.height;
    final logoSize = width * .25;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFFEFF7FF), Color(0xFFD6ECFF)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: width * .05,
              vertical: height * .025,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        width: logoSize,
                        height: logoSize,
                        decoration: BoxDecoration(
                          color: const Color(0xff0D6B80),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Icon(
                          Icons.restaurant,
                          color: Colors.white,
                          size: logoSize * .75,
                        ),
                      ),

                      SizedBox(height: height * .025),

                      Text(
                        "SmartCanteen",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: width * .07,
                          color: const Color(0xff0D6B80),
                        ),
                      ),

                      SizedBox(height: height * .02),

                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(width * .05),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.08),
                              blurRadius: 18,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Email Field
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              inputFormatters: [LowercaseEmailInputFormatter()],
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: decoration(
                                "အီးမေးလ် လိပ်စာ",
                                Icons.email_outlined,
                                "you@ucstt.edu.mm",
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "အီးမေးလ် ရိုက်ထည့်ရန် လိုအပ်ပါသည်";
                                }

                                if (RegExp(r'[A-Z]').hasMatch(value)) {
                                  return "အီးမေးလ်တွင် စာလုံးကြီး ရိုက်ထည့်၍ မရပါ";
                                }

                                if (!value.contains("@")) {
                                  return "အီးမေးလ်တွင် @ ပါဝင်ရပါမည်";
                                }

                                if (!RegExp(
                                  r'^[a-z][a-z0-9._%+-]*@ucstt\.edu\.mm$',
                                ).hasMatch(value)) {
                                  return "username@ucstt.edu.mm ပုံစံအတိုင်း ရိုက်ထည့်ပါ";
                                }

                                return null;
                              },
                            ),

                            SizedBox(height: height * .018),

                            // Password Field
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration:
                                  decoration(
                                    "လျှို့ဝှက်နံပါတ်",
                                    Icons.lock_outline,
                                    "ဥပမာ - Khing12@",
                                  ).copyWith(
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscurePassword
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: const Color(0xff0D6B80),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _obscurePassword = !_obscurePassword;
                                        });
                                      },
                                    ),
                                  ),
                              validator: _validatePasswordWithSuggestions,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    // Forgot Password Action
                                  },
                                  child: const Text(
                                    "လျှို့ဝှက်နံပါတ် မေ့နေပါသလား?",
                                    style: TextStyle(
                                      color: Color(0xff0D6B80),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: height * .02),

                            SizedBox(
                              width: double.infinity,
                              height: 55,
                              child: ElevatedButton(
                                onPressed: _isLoading
                                    ? null
                                    : () async {
                                        if (_formKey.currentState!.validate()) {
                                          setState(() => _isLoading = true);

                                          try {
                                            final result = await ApiService()
                                                .loginUser(
                                                  email: _emailController.text
                                                      .trim(),
                                                  password: _passwordController
                                                      .text
                                                      .trim(),
                                                );

                                            setState(() => _isLoading = false);

                                            if (result != null &&
                                                result.success == true) {
                                              await SharedPreferencesService.saveUser(
                                                result.user!,
                                              );

                                              if (result.token != null) {
                                                await SharedPreferencesService.saveToken(
                                                  result.token!,
                                                );
                                                await SecureStorageService.saveToken(
                                                  result.token!,
                                                );
                                              }

                                              if (result.user?.fcmToken !=
                                                  null) {
                                                await SecureStorageService.saveFcmToken(
                                                  result.user!.fcmToken!,
                                                );
                                              }

                                              final qrData = jsonEncode({
                                                'user_name':
                                                    result.user?.userName ?? '',
                                                'student_id':
                                                    result
                                                        .user
                                                        ?.student
                                                        ?.studentId ??
                                                    '',
                                              });

                                              await SecureStorageService.saveQrData(
                                                qrData,
                                              );

                                              if (!mounted) return;

                                              context.go(
                                                '/navigation',
                                                extra: qrData,
                                              );
                                            } else {
                                              if (!mounted) return;
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    result?.message ??
                                                        "အီးမေးလ် သို့မဟုတ် လျှို့ဝှက်နံပါတ် မှားယွင်းနေပါသည်။",
                                                  ),
                                                ),
                                              );
                                            }
                                          } catch (e) {
                                            setState(() => _isLoading = false);
                                            if (!mounted) return;
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(e.toString()),
                                              ),
                                            );
                                          }
                                        }
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff0D6B80),
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: _isLoading
                                    ? const SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2.5,
                                        ),
                                      )
                                    : const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            " အကောင့် ဝင်ရောက်မည်",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Icon(Icons.login, size: 20),
                                        ],
                                      ),
                              ),
                            ),

                            SizedBox(height: height * .02),
                          ],
                        ),
                      ),

                      SizedBox(height: height * .03),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "အကောင့် မရှိသေးပါက - ",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              context.go("/register");
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              "အကောင့်သစ်ပြုလုပ်မည်",
                              style: TextStyle(
                                color: Color(0xff0D47A1),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: height * .02),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
