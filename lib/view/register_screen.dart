
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isStudent = true;
  bool showPassword = false;
  bool showConfirmPassword = false;

  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController phoneController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Full name is required";
    }

    if (!RegExp(r'^[a-zA-Z ]+$')
        .hasMatch(value.trim())) {
      return "Name can only contain letters";
    }

    return null;
  }

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
      return "Use username@ucstt.edu.mm";
    }

    return null;
  }

  String? validatePhone(String? value) {
  if (value == null || value.isEmpty) {
    return "Phone number is required";
  }

  if (!RegExp(r'^09[4679]\d{8}$').hasMatch(value)) {
    return "Phone must start with 09, and the third digit must be 4, 6, 7, or 9";
  }

  return null;
}

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

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Confirm your password";
    }

    if (value != passwordController.text) {
      return "Passwords do not match";
    }

    return null;
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
                        "Create Account",
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
                              controller: nameController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: validateName,
                              decoration: decoration(
                                "Full Name",
                                Icons.person_outline,
                                "Your Name",
                              ),
                            ),

                            SizedBox(height: height * .018),

                            TextFormField(
                              controller: emailController,
                              keyboardType:
                                  TextInputType.emailAddress,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: validateEmail,
                              decoration: decoration(
                                "Email Address",
                                Icons.email_outlined,
                                "you@ucstt.edu.mm",
                              ),
                            ),

                            SizedBox(height: height * .018),

                            TextFormField(
                              controller: phoneController,
                              keyboardType:
                                  TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter
                                    .digitsOnly,
                                LengthLimitingTextInputFormatter(
                                    11),
                              ],
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: validatePhone,
                              decoration: decoration(
                                "Phone Number",
                                Icons.phone_outlined,
                                "09XXXXXXXXX",
                              ),
                            ),

                            SizedBox(height: height * .018),

                            TextFormField(
                              controller: passwordController,
                              obscureText: !showPassword,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: validatePassword,
                              decoration: decoration(
                                "Password",
                                Icons.lock_outline,
                                "********",
                              ).copyWith(
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    showPassword
                                        ? Icons.visibility
                                        : Icons
                                            .visibility_off,
                                    color: const Color(
                                        0xff1E5ED8),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      showPassword =
                                          !showPassword;
                                    });
                                  },
                                ),
                              ),
                            ),

                            SizedBox(height: height * .018),

                            TextFormField(
                              controller:
                                  confirmPasswordController,
                              obscureText:
                                  !showConfirmPassword,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator:
                                  validateConfirmPassword,
                              decoration: decoration(
                                "Confirm Password",
                                Icons.lock_outline,
                                "********",
                              ).copyWith(
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    showConfirmPassword
                                        ? Icons.visibility
                                        : Icons
                                            .visibility_off,
                                    color: const Color(
                                        0xff1E5ED8),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      showConfirmPassword =
                                          !showConfirmPassword;
                                    });
                                  },
                                ),
                              ),
                            ),

                            SizedBox(height: height * .018),

                            Align(
                              alignment:
                                  Alignment.centerLeft,
                              child: Text(
                                "Select Role",
                                style: TextStyle(
                                  fontSize: width * .04,
                                  fontWeight:
                                      FontWeight.w600,
                                ),
                              ),
                            ),

                            Row(
                              children: [
                                Expanded(
                                  child:
                                      RadioListTile<bool>(
                                    value: true,
                                    groupValue:
                                        isStudent,
                                    dense: true,
                                    contentPadding:
                                        EdgeInsets.zero,
                                    title: const Text(
                                        "Student"),
                                    onChanged: (value) {
                                      setState(() {
                                        isStudent =
                                            value!;
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child:
                                      RadioListTile<bool>(
                                    value: false,
                                    groupValue:
                                        isStudent,
                                    dense: true,
                                    contentPadding:
                                        EdgeInsets.zero,
                                    title: const Text(
                                        "Teacher"),
                                    onChanged: (value) {
                                      setState(() {
                                        isStudent =
                                            value!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: height * .02),

                            SizedBox(
                              width: double.infinity,
                              height: height * .065,
                              child: ElevatedButton(
                                style:
                                    ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color(
                                          0xff1E5ED8),
                                  foregroundColor:
                                      Colors.white,
                                  elevation: 0,
                                  shape:
                                      RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius
                                            .circular(
                                                12),
                                  ),
                                ),
                                // onPressed: () {
                                //   if (_formKey
                                //       .currentState!
                                //       .validate()) {
                                //         print("going to next page.");
                                //     context.go('/student_info');

                                //   }
                                // },
                                onPressed: () {
  print("Button pressed");

  final valid = _formKey.currentState!.validate();
  print("Valid = $valid");

  if (valid) {
    print("Before navigation");

    try {
      context.go('/student_info');
      print("After navigation");
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
    }
  }
},
                                child: Text(
                                  "Continue",
                                  style: TextStyle(
                                    fontSize:
                                        width * .043,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
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
                          Text(
                            "Already have an account? ",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: width * .04,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              context.go('/login');
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: const Color(0xff1E5ED8),
                                fontWeight: FontWeight.bold,
                                fontSize: width * .04,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: height * .03),
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
