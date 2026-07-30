import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smartcanteen/service/api_service.dart';
import 'package:smartcanteen/service/secure_storage_service.dart';
import 'package:smartcanteen/service/shared_preferences_service.dart';

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
        color: const Color(0xff1E5ED8),
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
          color: Color(0xffE5E7EB),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xff1E5ED8),
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
      resizeToAvoidBottomInset: true,
      body: Container(
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
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: width * .05,
              vertical: height * .025,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(maxWidth: 500),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        width: logoSize,
                        height: logoSize,
                        decoration: BoxDecoration(
                          color: const Color(0xff0D47A1),
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
                              const Color(0xff0D47A1),
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
                                "you@gmail.com",
                              ),
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty) {
                                  return "Email is required";
                                }
                                return null;
                              },
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
                                    color: const Color(
                                        0xff1E5ED8),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword =
                                          !_obscurePassword;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty) {
                                  return "Password is required";
                                }
                                return null;
                              },
                            ),
                            
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight:
                                        FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Forgot Password
                                  },
                                  child: const Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                      color:
                                          Color(0xff1E5ED8),
                                      fontWeight:
                                          FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(
                                height: height * .03),

                            SizedBox(
                              width: double.infinity,
                              height: 55,
                              child: ElevatedButton(
                              onPressed: () async {
  print("Login button clicked");

  if (_formKey.currentState!.validate()) {
    print("Form validation passed");

    try {
      print("Calling loginUser API...");

      final result = await ApiService().loginUser(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );


      print("API Result: $result");
if (result != null && result.success == true) {

      
  print("Login successful");
  // Save user object
  await SharedPreferencesService.saveUser(result.user!);

  // Save token if available
  if (result.token != null) {
    await SharedPreferencesService.saveToken(result.token!);
  }

  // Save auth token
  if (result.token != null) {
    await SecureStorageService.saveToken(result.token!);
  }


  // Save FCM token
  if (result.user?.fcmToken != null) {
    await SecureStorageService.saveFcmToken(
      result.user!.fcmToken!,
    );
  }


  // Create QR data
  final qrData = jsonEncode({
    'user_id' : result.user?.userId ?? '',
    'user_name': result.user?.userName ?? '',
    'student_id': result.user?.student?.studentId ?? '',
  });


  // Save QR permanently
  await SecureStorageService.saveQrData(qrData);


  print("LOGIN QR DATA:");
  print(qrData);


  if (!mounted) return;


  context.go(
    '/navigation',
    extra: qrData,
  );
} else {
        print("Login failed: ${result?.message}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              result?.message ?? "Invalid email or password",
            ),
          ),
        );
      }
    } catch (e) {
      print("Login Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }
},
                                style: ElevatedButton
                                    .styleFrom(
                                  backgroundColor:
                                      const Color(
                                          0xff0D47A1),
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

                            SizedBox(
                                height: height * .02),
                                                          ],
                        ),
                      ),

                      SizedBox(height: height * .03),

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