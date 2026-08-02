
// // import 'package:flutter/material.dart';
// // import 'package:go_router/go_router.dart';
// // import 'package:smartcanteen/service/api_service.dart';
// // import 'package:smartcanteen/service/secure_storage_service.dart';
// // import 'package:smartcanteen/service/shared_preferences_service.dart';

// // class Loginscreen extends StatefulWidget {
// //   const Loginscreen({super.key});

// //   @override
// //   State<Loginscreen> createState() => _LoginscreenState();
// // }

// // class _LoginscreenState extends State<Loginscreen> {
// //   final _formKey = GlobalKey<FormState>();

// //   final TextEditingController _emailController =
// //       TextEditingController();

// //   final TextEditingController _passwordController =
// //       TextEditingController();

// //   bool _obscurePassword = true;

// //   @override
// //   void dispose() {
// //     _emailController.dispose();
// //     _passwordController.dispose();
// //     super.dispose();
// //   }

// //   InputDecoration decoration(
// //     String label,
// //     IconData icon,
// //     String hint,
// //   ) {
// //     return InputDecoration(
// //       labelText: label,
// //       hintText: hint,
// //       prefixIcon: Icon(
// //         icon,
// //         color: Color(0xff0D6B80),
// //       ),
// //       filled: true,
// //       fillColor: Colors.white,
// //       contentPadding: const EdgeInsets.symmetric(
// //         horizontal: 16,
// //         vertical: 16,
// //       ),
// //       border: OutlineInputBorder(
// //         borderRadius: BorderRadius.circular(12),
// //       ),
// //       enabledBorder: OutlineInputBorder(
// //         borderRadius: BorderRadius.circular(12),
// //         borderSide: const BorderSide(
// //           color: Color(0xffE5E7EB),
// //         ),
// //       ),
// //       focusedBorder: OutlineInputBorder(
// //         borderRadius: BorderRadius.circular(12),
// //         borderSide: const BorderSide(
// //           color: Color(0xff0D6B80),
// //           width: 2,
// //         ),
// //       ),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final size = MediaQuery.of(context).size;

// //     final width = size.width;
// //     final height = size.height;
// //     final logoSize = width * .25;

// //     return Scaffold(
// //       backgroundColor: Colors.white, // or your background colo
// //       resizeToAvoidBottomInset: true,
// //       body: Container(
// //         decoration: const BoxDecoration(
// //           gradient: LinearGradient(
// //             begin: Alignment.topCenter,
// //             end: Alignment.bottomCenter,
// //             colors: [
// //               Colors.white,
// //               Color(0xFFEFF7FF),
// //               Color(0xFFD6ECFF),
// //             ],
// //           ),
// //         ),
// //         child: SafeArea(
// //           child: SingleChildScrollView(
// //             padding: EdgeInsets.symmetric(
// //               horizontal: width * .05,
// //               vertical: height * .025,
// //             ),
// //             child: Center(
// //               child: ConstrainedBox(
// //                 constraints:
// //                     const BoxConstraints(maxWidth: 500),
// //                 child: Form(
// //                   key: _formKey,
// //                   child: Column(
// //                     children: [
// //                       Container(
// //                         width: logoSize,
// //                         height: logoSize,
// //                         decoration: BoxDecoration(
// //                           color: Color(0xff0D6B80),
// //                           borderRadius:
// //                               BorderRadius.circular(18),
// //                         ),
// //                         child: Icon(
// //                           Icons.restaurant,
// //                           color: Colors.white,
// //                           size: logoSize * .75,
// //                         ),
// //                       ),

// //                       SizedBox(height: height * .025),

// //                       Text(
// //                         "SmartCanteen",
// //                         style: TextStyle(
// //                           fontWeight: FontWeight.bold,
// //                           fontSize: width * .07,
// //                           color:
// //                               Color(0xff0D6B80),
// //                         ),
// //                       ),

// //                       SizedBox(height: height * .02),

// //                       Container(
// //                         width: double.infinity,
// //                         padding:
// //                             EdgeInsets.all(width * .05),
// //                         decoration: BoxDecoration(
// //                           color: Colors.white,
// //                           borderRadius:
// //                               BorderRadius.circular(22),
// //                           boxShadow: [
// //                             BoxShadow(
// //                               color: Colors.black
// //                                   .withOpacity(.08),
// //                               blurRadius: 18,
// //                               offset:
// //                                   const Offset(0, 8),
// //                             ),
// //                           ],
// //                         ),
// //                         child: Column(
// //                           children: [
// //                                                         TextFormField(
// //                               controller: _emailController,
// //                               keyboardType:
// //                                   TextInputType.emailAddress,
// //                               autovalidateMode:
// //                                   AutovalidateMode.onUserInteraction,
// //                               decoration: decoration(
// //                                 "Email Address",
// //                                 Icons.email_outlined,
// //                                 "you@ucstt.edu.mm",
// //                               ),
// //                               validator: (value) {
// //                                 if (value == null ||
// //                                     value.isEmpty) {
// //                                   return "Email is required";
// //                                 }
// //                                 return null;
// //                               },
// //                             ),

// //                             SizedBox(height: height * .018),

// //                             TextFormField(
// //                               controller:
// //                                   _passwordController,
// //                               obscureText:
// //                                   _obscurePassword,
// //                               autovalidateMode:
// //                                   AutovalidateMode.onUserInteraction,
// //                               decoration: decoration(
// //                                 "Password",
// //                                 Icons.lock_outline,
// //                                 "Enter Password",
// //                               ).copyWith(
// //                                 suffixIcon: IconButton(
// //                                   icon: Icon(
// //                                     _obscurePassword
// //                                         ? Icons
// //                                             .visibility_outlined
// //                                         : Icons
// //                                             .visibility_off_outlined,
// //                                     color: Color(0xff0D6B80),
// //                                   ),
// //                                   onPressed: () {
// //                                     setState(() {
// //                                       _obscurePassword =
// //                                           !_obscurePassword;
// //                                     });
// //                                   },
// //                                 ),
// //                               ),
// //                               validator: (value) {
// //                                 if (value == null ||
// //                                     value.isEmpty) {
// //                                   return "Password is required";
// //                                 }

// //                                 return null;

// //                               },
// //                             ),
                            
// //                             Row(
// //                               mainAxisAlignment:
// //                                   MainAxisAlignment.spaceBetween,
// //                               children: [
// //                                 const Text(
// //                                   "",
// //                                   style: TextStyle(
// //                                     fontSize: 14,
// //                                     fontWeight:
// //                                         FontWeight.w600,
// //                                     color: Colors.black87,
// //                                   ),
// //                                 ),
// //                                 TextButton(
// //                                   onPressed: () {
// //                                     // Forgot Password
// //                                   },
// //                                   child: const Text(
// //                                     "Forgot Password?",
// //                                     style: TextStyle(
// //                                       color:
// //                                           Color(0xff0D6B80),
// //                                       fontWeight:
// //                                           FontWeight.w600,
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),

// //                             SizedBox(
// //                                 height: height * .03),

// //                             SizedBox(
// //                               width: double.infinity,
// //                               height: 55,
// //                               child: ElevatedButton(
// // //                               onPressed: () async {
// // //   print("Login button clicked");

// // //   if (_formKey.currentState!.validate()) {
// // //     print("Form validation passed");

// // //     try {
// // //       print("Calling loginUser API...");

// // //       final result = await ApiService().loginUser(
// // //         email: _emailController.text.trim(),
// // //         password: _passwordController.text.trim(),
// // //       );


// // //       print("API Result: $result");
// // // if (result != null && result.success == true) {

      
// // //   print("Login successful");
// // //   // Save user object
// // //   await SharedPreferencesService.saveUser(result.user!);

// // //   // Save token if available
// // //   if (result.token != null) {
// // //     await SharedPreferencesService.saveToken(result.token!);
// // //   }

// // //   // Save auth token
// // //   if (result.token != null) {
// // //     await SecureStorageService.saveToken(result.token!);
// // //   }


// // //   // Save FCM token
// // //   if (result.user?.fcmToken != null) {
// // //     await SecureStorageService.saveFcmToken(
// // //       result.user!.fcmToken!,
// // //     );
// // //   }


// // //   // Create QR data
// // //   final qrData = jsonEncode({
// // //     'user_id' : result.user?.userId ?? '',
// // //     'user_name': result.user?.userName ?? '',
// // //     'student_id': result.user?.student?.studentId ?? '',
// // //   });


// // //   // Save QR permanently
// // //   await SecureStorageService.saveQrData(qrData);


// // //   print("LOGIN QR DATA:");
// // //   print(qrData);


// // //   if (!mounted) return;


// // //   context.go(
// // //     '/navigation',
// // //     extra: qrData,
// // //   );
// // // } else {
// // //         print("Login failed: ${result?.message}");
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(
// // //             content: Text(
// // //               result?.message ?? "Invalid email or password",
// // //             ),
// // //           ),
// // //         );
// // //       }
// // //     } catch (e) {
// // //       print("Login Error: $e");
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         SnackBar(content: Text(e.toString())),
// // //       );
// // //     }
// // //   }
// // // },
// // onPressed: () async {
// //   print("Login button clicked");

// //   if (_formKey.currentState!.validate()) {
// //     print("Form validation passed");

// //     try {
// //       print("Calling loginUser API...");

// //       final result = await ApiService().loginUser(
// //         email: _emailController.text.trim(),
// //         password: _passwordController.text.trim(),
// //       );

// //       print("API Result: $result");
      
// //       if (result != null && result.success == true) {
// //         print("Login successful");

// //         // 1. Perform storage operations in microtasks/background to avoid frame skips
// //         await Future.wait([
// //           SharedPreferencesService.saveUser(result.user!),
// //           if (result.token != null) ...[
// //             SharedPreferencesService.saveToken(result.token!),
// //             SecureStorageService.saveToken(result.token!),
// //           ],
// //           if (result.user?.fcmToken != null)
// //             SecureStorageService.saveFcmToken(result.user!.fcmToken!),
// //         ]);

// //         // 2. Create QR data
// //         // 2. Create QR data as plain text
// //         final userName = result.user?.userName ?? '';
// //         final studentId = result.user?.student?.studentId ?? '';
        
// //         // Combine them with a space (or format them however you need)
// //         final qrData = '$userName $studentId'.trim();

// //         await SecureStorageService.saveQrData(qrData);

// //         await SecureStorageService.saveQrData(qrData);

// //         if (!mounted) return;

// //         // 3. Smooth transition to navigation screen
// //         context.go(
// //           '/navigation',
// //           extra: qrData,
// //         );
// //       } else {
// //         print("Login failed: ${result?.message}");
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(
// //             content: Text(
// //               result?.message ?? "Invalid email or password",
// //             ),
// //           ),
// //         );
// //       }
// //   } catch (e, stackTrace) {
// //       print("Login Error: $e");
// //       print("Stack trace: $stackTrace"); // 👈 This will reveal the exact line causing the loop
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text(e.toString())),
// //       );
// //     }
// //   }
// // },
// //                                 style: ElevatedButton
// //                                     .styleFrom(
// //                                   backgroundColor:
// //                                       Color(0xff0D6B80),
// //                                   foregroundColor:
// //                                       Colors.white,
// //                                   elevation: 0,
// //                                   shape:
// //                                       RoundedRectangleBorder(
// //                                     borderRadius:
// //                                         BorderRadius
// //                                             .circular(12),
// //                                   ),
// //                                 ),
// //                                 child: const Row(
// //                                   mainAxisAlignment:
// //                                       MainAxisAlignment
// //                                           .center,
// //                                   children: [
// //                                     Text(
// //                                       "Login",
// //                                       style: TextStyle(
// //                                         fontSize: 16,
// //                                         fontWeight:
// //                                             FontWeight.bold,
// //                                       ),
// //                                     ),
// //                                     SizedBox(width: 8),
// //                                     Icon(
// //                                       Icons.arrow_forward,
// //                                       size: 20,
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ),
// //                             ),

// //                             SizedBox(
// //                                 height: height * .02),
// //                                                           ],
// //                         ),
// //                       ),

// //                       SizedBox(height: height * .03),

// //                       Row(
// //                         mainAxisAlignment:
// //                             MainAxisAlignment.center,
// //                         children: [
// //                           const Text(
// //                             "Don't have an account? ",
// //                             style: TextStyle(
// //                               color: Colors.black54,
// //                               fontSize: 14,
// //                             ),
// //                           ),
// //                           TextButton(
// //                             onPressed: () {
// //                               context.go("/register");
// //                             },
// //                             style: TextButton.styleFrom(
// //                               padding: EdgeInsets.zero,
// //                               minimumSize: Size.zero,
// //                               tapTargetSize:
// //                                   MaterialTapTargetSize
// //                                       .shrinkWrap,
// //                             ),
// //                             child: const Text(
// //                               "Sign Up",
// //                               style: TextStyle(
// //                                 color: Color(0xff0D6B80),
// //                                 fontWeight: FontWeight.bold,
// //                                 fontSize: 14,
// //                               ),
// //                             ),
// //                           ),
// //                         ],
// //                       ),

// //                       //SizedBox(height: height * .02),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smartcanteen/service/api_service.dart';
import 'package:smartcanteen/service/secure_storage_service.dart';
import 'package:smartcanteen/service/shared_preferences_service.dart';
import 'package:smartcanteen/view/enter_email_screen.dart';
import 'package:smartcanteen/view/forgot_password_screen.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController =
      TextEditingController();

  final TextEditingController _passwordController =
      TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  
  // 👇 Email Validation Function with RegEx[cite: 1]
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }

    if (!value.contains("@")) {
      return "Email must contain @";
    }

    if (!RegExp(
      r'^[a-zA-Z0-9._%+-]+@ucstt\.edu\.mm$',
    ).hasMatch(value)) {
      return "Use name@ucstt.edu.mm";
    }

    return null;
  }

  // 👇 Password Validation Function with RegEx[cite: 1]
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    if (value.length != 8) {
      return "Password must be exactly 8 characters";
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

    if (!RegExp(
      r'[!@#\$%^&*(),.?":{}|<>]',
    ).hasMatch(value)) {
      return "Need one special character";
    }

    return null;
  }


  InputDecoration decoration(
    String label,
    IconData icon,
    String hint,
  ) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(
        icon,
        color: Color(0xff0D6B80),
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xff05E5E7EB),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xff0D6B80),
          width: 2,
        ),
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
      backgroundColor: const Color(0xFFD6ECFF), // 👈 အောက်ခြေ အဖြူကွက်မပေါ်အောင် နောက်ဆုံးအရောင်ဖြင့် ချိန်ပေးခြင်း
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Color(0xFFEFF7FF),
              Color(0xFFD6ECFF),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: width * .05,
                vertical: height * .02,
              ),
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(maxWidth: 500),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: logoSize,
                        height: logoSize,
                        decoration: BoxDecoration(
                          color: Color(0xff0D6B80),
                          borderRadius:
                              BorderRadius.circular(18),
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
                          color:
                              Color(0xff0D6B80),
                        ),
                      ),

                      SizedBox(height: height * .02),

                      Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.all(width * .05),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(22),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black
                                  .withOpacity(.08),
                              blurRadius: 18,
                              offset:
                                  const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emailController,
                              keyboardType:
                                  TextInputType.emailAddress,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: decoration(
                                "Email Address",
                                Icons.email_outlined,
                                "you@ucstt.edu.mm",
                              ),
                              // validator: (value) {
                              //   if (value == null ||
                              //       value.isEmpty) {
                              //     return "Email is required";
                              //   }
                              validator: validateEmail, // 👈 Connected validator here
                               // return null;
                              //},
                            ),

                            SizedBox(height: height * .018),

                            TextFormField(
                              controller:
                                  _passwordController,
                              obscureText:
                                  _obscurePassword,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: decoration(
                                "Password",
                                Icons.lock_outline,
                                "Enter Password",
                              ).copyWith(
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons
                                            .visibility_outlined
                                        : Icons
                                            .visibility_off_outlined,
                                    color: Color(0xff0D6B80),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword =
                                          !_obscurePassword;
                                    });
                                  },
                                ),
                              ),
                              // validator: (value) {
                              //   if (value == null ||
                              //       value.isEmpty) {
                              //     return "Password is required";
                              //   }
                              //   return null;
validator: validatePassword, // 👈 Connected validator here
                              //},
                            ),
                            
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(""),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
      );
                                  },
                                  child: const Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                      color:
                                          Color(0xff0D6B80),
                                      fontWeight:
                                          FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(
                                height: height * .02),

                            SizedBox(
                              width: double.infinity,
                              height: 55,
                              child: ElevatedButton(
                                // onPressed: () async {
                                //   print("Login button clicked");

                                //   if (_formKey.currentState!.validate()) {
                                //     print("Form validation passed");

                                //     try {
                                //       print("Calling loginUser API...");

                                //       final result = await ApiService().loginUser(
                                //         email: _emailController.text.trim(),
                                //         password: _passwordController.text.trim(),
                                //       );

                                //       print("API Result: $result");
                                      
                                //       if (result != null && result.success == true) {
                                //         print("Login successful");

                                //         await Future.wait([
                                //           SharedPreferencesService.saveUser(result.user!),
                                //           if (result.token != null) ...[
                                //             SharedPreferencesService.saveToken(result.token!),
                                //             SecureStorageService.saveToken(result.token!),
                                //           ],
                                //           if (result.user?.fcmToken != null)
                                //             SecureStorageService.saveFcmToken(result.user!.fcmToken!),
                                //         ]);

                                //         final userName = result.user?.userName ?? '';
                                //         final studentId = result.user?.student?.studentId ?? result.user?.userId;
                                //         final qrData = '$userName $studentId'.trim();

                                //         await SecureStorageService.saveQrData(qrData);

                                //         if (!mounted) return;

                                //         context.go(
                                //           '/navigation',
                                //           extra: qrData,
                                //         );
                                //       } else {
                                //         print("Login failed: ${result?.message}");
                                //         ScaffoldMessenger.of(context).showSnackBar(
                                //           SnackBar(
                                //             content: Text(
                                //               result?.message ?? "Invalid email or password",
                                //             ),
                                //           ),
                                //         );
                                //       }
                                //     } catch (e, stackTrace) {
                                //       print("Login Error: $e");
                                //       print("Stack trace: $stackTrace");
                                //       ScaffoldMessenger.of(context).showSnackBar(
                                //         SnackBar(content: Text(e.toString())),
                                //       );
                                //     }
                                //   }
                                // },
                                onPressed: () async {
  print("Login button clicked");

  if (_formKey.currentState!.validate()) {
    print("Form validation passed");

    try {
      // 1. Fetch FCM Token first
      print("Fetching FCM token...");
      // String? fcmToken;
      // try {
      //   fcmToken = await FirebaseMessaging.instance.getToken();
      //   print("Fetched FCM Token: $fcmToken");

      //   // Save FCM token locally right away if retrieved successfully
      //   if (fcmToken != null && fcmToken.isNotEmpty) {
      //     await SecureStorageService.saveFcmToken(fcmToken);
      //   }
      // } catch (e) {
      //   print("Error fetching FCM token: $e");
      // }

      // print("Calling loginUser API...");

      // // 2. Pass fcmToken to your API call (if your ApiService supports it)
      // final result = await ApiService().loginUser(
      //   email: _emailController.text.trim(),
      //   password: _passwordController.text.trim(),
      //   // fcmToken: fcmToken, // 👈 Pass fcmToken here if supported in your ApiService
      // );
// 1. Fetch FCM Token
String? fcmToken;
try {
  fcmToken = await FirebaseMessaging.instance.getToken();
  print("Fetched FCM Token: $fcmToken");

  if (fcmToken != null && fcmToken.isNotEmpty) {
    await SecureStorageService.saveFcmToken(fcmToken);
  }
} catch (e) {
  print("Error fetching FCM token: $e");
}

print("Calling loginUser API...");

// 2. Pass fcmToken to your API call here!
final result = await ApiService().loginUser(
  email: _emailController.text.trim(),
  password: _passwordController.text.trim(),
  fcmToken: fcmToken, // 👈 Pass it here!
);
      print("API Result: $result");

      if (result != null && result.success == true) {
        print("Login successful");

        // Save user data & auth tokens
        await Future.wait([
          SharedPreferencesService.saveUser(result.user!),
          if (result.token != null) ...[
            SharedPreferencesService.saveToken(result.token!),
            SecureStorageService.saveToken(result.token!),
          ],
          // Fallback: save backend's returned fcmToken if available and not saved earlier
          if (result.user?.fcmToken != null)
            SecureStorageService.saveFcmToken(result.user!.fcmToken!),
        ]);

        final userName = result.user?.userName ?? '';
        final studentId = result.user?.student?.studentId ?? result.user?.userId;
        final qrData = '$userName $studentId'.trim();

        await SecureStorageService.saveQrData(qrData);

        if (!mounted) return;

        context.go(
          '/navigation',
          extra: qrData,
        );
      } else {
        print("Login failed: ${result?.message}");
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              result?.message ?? "Invalid email or password",
            ),
          ),
        );
      }
    } catch (e, stackTrace) {
      print("Login Error: $e");
      print("Stack trace: $stackTrace");
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }
},
                                style: ElevatedButton
                                    .styleFrom(
                                  backgroundColor:
                                      Color(0xff0D6B80),
                                  foregroundColor:
                                      Colors.white,
                                  elevation: 0,
                                  shape:
                                      RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius
                                            .circular(12),
                                  ),
                                ),
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment
                                          .center,
                                  children: [
                                    Text(
                                      "Login",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Icon(
                                      Icons.arrow_forward,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: height * .025),

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account? ",
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
                              tapTargetSize:
                                  MaterialTapTargetSize
                                      .shrinkWrap,
                            ),
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Color(0xff0D6B80),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
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