import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:smartcanteen/model/user_model.dart';

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

  static const Color primaryColor = Color(0xff117992);

  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

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

  InputDecoration decoration({required String hint, required IconData icon}) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.grey.shade600),

      filled: true,
      fillColor: Colors.grey.shade100,

      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.red),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
    );
  }

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Full name is required";
    }

    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value.trim())) {
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

    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$').hasMatch(value)) {
      return "Use username@gmail.com";
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

    if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(value)) {
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

    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
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
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.restaurant,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(height: height * .025),

                    const Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "Join Smart Canteen Today",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 15,
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
                          TextFormField(
                            controller: nameController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: validateName,
                            decoration: decoration(
                              hint: "Full Name",
                              icon: Icons.person_outline,
                            ),
                          ),

                          SizedBox(height: height * .018),

                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: validateEmail,
                            decoration: decoration(
                              hint: "Email Address",
                              icon: Icons.email_outlined,
                            ),
                          ),

                          SizedBox(height: height * .018),

                          TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(11),
                            ],
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: validatePhone,
                            decoration: decoration(
                              hint: "Phone Number",
                              icon: Icons.phone_outlined,
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
                              hint: "Password",
                              icon: Icons.lock_outline,
                            ),
                          ),

                          SizedBox(height: height * .018),

                          TextFormField(
                            controller: confirmPasswordController,
                            obscureText: !showConfirmPassword,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: validateConfirmPassword,
                            decoration: decoration(
                              hint: "Confirm Password",
                              icon: Icons.lock_outline,
                            ),
                          ),

                          SizedBox(height: height * .018),

                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Select Role",
                              style: TextStyle(
                                fontSize: width * .04,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),

                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isStudent = true;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isStudent
                                          ? primaryColor
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(color: primaryColor),
                                    ),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.school,
                                          color: isStudent
                                              ? Colors.white
                                              : primaryColor,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          "Student",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: isStudent
                                                ? Colors.white
                                                : Colors.black87,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 12),

                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isStudent = false;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      color: !isStudent
                                          ? primaryColor
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(color: primaryColor),
                                    ),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.person,
                                          color: !isStudent
                                              ? Colors.white
                                              : primaryColor,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          "Teacher",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: !isStudent
                                                ? Colors.white
                                                : Colors.black87,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: height * .02),

                          SizedBox(
                            width: double.infinity,
                            height: height * .065,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                final valid = _formKey.currentState!.validate();

                                if (valid) {
                                  final user = UserModel(
                                    //userId: 0,
                                    userName: nameController.text,
                                    userPhone: phoneController.text,
                                    userEmail: emailController.text,
                                    roleName: isStudent ? "student" : "teacher",
                                    fcmToken: null,
                                    updatedAt: DateTime.now().toString(),
                                    createdAt: DateTime.now().toString(),
                                    student: null,
                                    userPassword: passwordController.text,
                                  );

                                  if (isStudent) {
                                    // Register -> Student Info
                                    context.go('/student_info', extra: user);
                                  } else {
                                    // Register -> Wallet Info
                                    context.go('/wallet_info', extra: user);
                                  }
                                }
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Continue",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(Icons.arrow_forward),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: height * .025),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        TextButton(
                          onPressed: () {
                            context.go('/login');
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
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
    );
  }
}
