import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:smartcanteen/view/student_info_screen.dart';
import 'package:smartcanteen/view/wallet_info_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Canteen',
      theme: ThemeData(primaryColor: const Color(0xff0F7C90)),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLogin = true;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  String? emailError;
  String? passwordError;
  String selectedRole = "Teacher";

  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  bool get isPasswordMatching {
    if (isLogin) return true;
    if (passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty)
      return false;
    return passwordController.text == confirmPasswordController.text;
  }

  // အခြား Field တွေနဲ့ Size (Height) နဲ့ Padding တစ်ပုံစံတည်း တူအောင် လုပ်ထားတဲ့ ဘုံ Input Decoration Helper
  InputDecoration _buildInputDecoration({
    required String hintText,
    required Widget prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      hintText: hintText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
    );
  }

  void navigateToStudentPage() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StudentRegisterScreen(
            name: nameController.text.trim(),
            email: emailController.text.trim(),
            password: passwordController.text,
            phone: "09${phoneController.text.trim()}",
          ),
        ),
      );
    }
  }

  void submitForm() {
    setState(() {
      emailError = null;
      passwordError = null;
    });

    if (isLogin) {
      final email = emailController.text.trim();
      final password = passwordController.text;

      if (email.isNotEmpty && password.isNotEmpty) {
        if (email != "htet@ucstt.edu.mm" || password != "123456") {
          setState(() {
            if (email != "htet@ucstt.edu.mm") {
              emailError = "Incorrect email address";
            } else if (password != "123456") {
              passwordError = "Incorrect password";
            }
          });
        }
      }
    }

    if (_formKey.currentState!.validate()) {
      if (isLogin) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Sign in successful!"),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Teacher Account Created Successfully!"),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  void switchAuthMode(bool loginMode) {
    setState(() {
      isLogin = loginMode;
      emailError = null;
      passwordError = null;
      selectedRole = "Teacher";
      nameController.clear();
      phoneController.clear();
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = const Color(0xff0F7C90);

    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: themeColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.restaurant_menu,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Smart Canteen",
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Order. Earn points. Enjoy.",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              const SizedBox(height: 30),
              Container(
                height: 56,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => switchAuthMode(true),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isLogin ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.login_outlined),
                                SizedBox(width: 8),
                                Text(
                                  "Sign in",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => switchAuthMode(false),
                        child: Container(
                          decoration: BoxDecoration(
                            color: !isLogin ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.person_add_alt_outlined),
                                SizedBox(width: 8),
                                Text(
                                  "Register",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      if (!isLogin) ...[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Full name",
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: nameController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: _buildInputDecoration(
                            hintText: "Your name",
                            prefixIcon: const Icon(Icons.person_outline),
                          ),
                          validator: (value) {
                            if (!isLogin &&
                                (value == null || value.trim().isEmpty)) {
                              return "Please enter your name";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Phone number",
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                        ),
                        const SizedBox(height: 10),

                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          maxLength: 9,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            // 👇 အစဆုံးဂဏန်းကို 6, 7, 9, 4 သာ လက်ခံရန် တားမြစ်ချက်ထည့်ခြင်း
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^[6794]\d*'),
                            ),
                          ],
                          style: const TextStyle(fontSize: 16),
                          decoration: _buildInputDecoration(
                            hintText:
                                "712345678", // ဥပမာကိုပါ 6,7,9,4 တစ်ခုခုနဲ့စပြတာ ပိုကောင်းပါတယ်
                            prefixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(width: 16),
                                const Icon(
                                  Icons.phone_android_outlined,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  "09 ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 4),
                              ],
                            ),
                          ).copyWith(counterText: ""),
                          validator: (value) {
                            if (!isLogin) {
                              if (value == null || value.trim().isEmpty) {
                                return "Please enter your phone number";
                              }
                              if (value.trim().length != 9) {
                                return "Phone number must be exactly 9 digits after 09";
                              }
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 20),
                      ],
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Email",
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: _buildInputDecoration(
                          hintText: "you@ucstt.edu.mm",
                          prefixIcon: const Icon(Icons.email_outlined),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter your email";
                          }
                          if (!RegExp(
                            r"^[a-zA-Z0-9._%+-]+@ucstt\.edu\.mm$",
                          ).hasMatch(value.trim())) {
                            return "Please enter a valid university email";
                          }
                          if (isLogin && emailError != null) {
                            return emailError;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Password",
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: passwordController,
                        obscureText: obscurePassword,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (value) {
                          setState(() {
                            if (passwordError != null) passwordError = null;
                          });
                        },
                        decoration: _buildInputDecoration(
                          hintText: "••••••••",
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscurePassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                            onPressed: () => setState(
                              () => obscurePassword = !obscurePassword,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your password";
                          }
                          if (value.length < 6) {
                            return "Password must be at least 6 characters";
                          }
                          if (isLogin && passwordError != null) {
                            return passwordError;
                          }
                          return null;
                        },
                      ),
                      if (!isLogin) ...[
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Confirm password",
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: confirmPasswordController,
                          obscureText: obscureConfirmPassword,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (value) {
                            setState(() {});
                          },
                          decoration: _buildInputDecoration(
                            hintText: "••••••••",
                            prefixIcon: const Icon(Icons.lock_reset_outlined),
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscureConfirmPassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                              onPressed: () => setState(
                                () => obscureConfirmPassword =
                                    !obscureConfirmPassword,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (!isLogin) {
                              if (value == null || value.isEmpty) {
                                return "Please confirm your password";
                              }
                              if (value != passwordController.text) {
                                return "Passwords do not match";
                              }
                            }
                            return null;
                          },
                        ),
                      ],
                      if (!isLogin) ...[
                        const SizedBox(height: 25),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Who are you?",
                            style: TextStyle(
                              color: isPasswordMatching
                                  ? Colors.grey.shade700
                                  : Colors.grey.shade400,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        IgnorePointer(
                          ignoring: !isPasswordMatching,
                          child: Opacity(
                            opacity: isPasswordMatching ? 1.0 : 0.5,
                            child: Row(
                              children: [
                                Expanded(
                                  child: RadioListTile<String>(
  title: const Text(
    "Student",
    style: TextStyle(fontSize: 14),
  ),
  value: "Student",
  groupValue: selectedRole,
  activeColor: themeColor,
  contentPadding: EdgeInsets.zero,
  onChanged: (value) {
    setState(() {
      selectedRole = value!;
    });

    // Save role only
    print("Selected Role: $selectedRole");
  },
),
                                ),
                                Expanded(
                                  child: RadioListTile<String>(
  title: const Text(
    "Teacher",
    style: TextStyle(fontSize: 14),
  ),
  value: "Teacher",
  groupValue: selectedRole,
  activeColor: themeColor,
  contentPadding: EdgeInsets.zero,
  onChanged: (value) {
    setState(() {
      selectedRole = value!;
    });

    // Save role only
    print("Selected Role: $selectedRole");
  },
),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 35),
                      SizedBox(
  width: double.infinity,
  height: 56,
  child: ElevatedButton.icon(
    style: ElevatedButton.styleFrom(
      backgroundColor: themeColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    onPressed: () {
      if (selectedRole == "Student") {
        context.go('/student_info');
      } else if (selectedRole == "Teacher") {
        context.go('/wallet_info');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a role'),
          ),
        );
      }
    },
    icon: Icon(
      isLogin ? Icons.login : Icons.person_add_alt_1,
    ),
    label: Text(
      isLogin ? 'Sign in' : 'Create account',
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),
                      if (isLogin) ...[
                        const SizedBox(height: 25),
                        const Text(
                          "Demo: htet@ucstt.edu.mm / 123456",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                "By continuing you agree to our Terms & Privacy Policy",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// StudentRegisterScreen အား နဂိုအတိုင်း ဆက်လက်ထိန်းသိမ်းထားပါသည်
class StudentRegisterScreen extends StatefulWidget {
  final String name;
  final String email;
  final String password;
  final String phone;

  const StudentRegisterScreen({
    super.key,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
  });

  @override
  State<StudentRegisterScreen> createState() => _StudentRegisterScreenState();
}

class _StudentRegisterScreenState extends State<StudentRegisterScreen> {
  String? selectedYearCode;
  String? selectedYearLevel;
  String? selectedSemester;

  final List<String> academicYears = [
    "(18-19)",
    "(19-20)",
    "(22-23)",
    "(22-23) J",
    "(23-24)",
    "(24-25)",
  ];
  final List<String> yearLevels = [
    "First Year",
    "Second Year",
    "Third Year",
    "Fourth Year",
    "Final Year",
  ];
  final List<String> semesters = [
    "I",
    "II",
    "III",
    "IV",
    "V",
    "VI",
    "VII",
    "VIII",
    "IX",
    "X",
  ];

  final _studentFormKey = GlobalKey<FormState>();
  final rollNumberController = TextEditingController();

  @override
  void dispose() {
    rollNumberController.dispose();
    super.dispose();
  }

  void completeRegistration() {
    if (_studentFormKey.currentState!.validate()) {
      String fullRollNo =
          "UCSTT-$selectedYearCode-${rollNumberController.text.trim()}";

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 30),
              SizedBox(width: 10),
              Text("Success", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          content: Text(
            "Hello ${widget.name},\nYour student account has been created successfully!\n\n"
            "Phone: ${widget.phone}\n"
            "Roll No: $fullRollNo\n"
            "Level: $selectedYearLevel\n"
            "Semester: $selectedSemester",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text(
                "OK",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = const Color(0xff0F7C90);

    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),
      appBar: AppBar(
        title: const Text(
          "Student Profile Setup",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _studentFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome, ${widget.name}! 👋",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: themeColor,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Complete your student profile information to finish registration.",
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),
                const SizedBox(height: 25),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.grey.shade200),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.05),
                        spreadRadius: 5,
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Roll Number",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              readOnly: true,
                              initialValue: "UCSTT",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade800,
                                fontSize: 14,
                              ),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 5,
                            child: DropdownButtonFormField<String>(
                              value: selectedYearCode,
                              hint: const Center(
                                child: Text(
                                  "Aca Year",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              isExpanded: true,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 10,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              items: academicYears.map((String year) {
                                return DropdownMenuItem<String>(
                                  value: year,
                                  child: Center(
                                    child: Text(
                                      year,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) =>
                                  setState(() => selectedYearCode = value),
                              validator: (value) =>
                                  value == null ? "Required" : null,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 4,
                            child: TextFormField(
                              controller: rollNumberController,
                              keyboardType: TextInputType.number,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              style: const TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                hintText: "No.",
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              validator: (value) =>
                                  (value == null || value.trim().isEmpty)
                                  ? "Required"
                                  : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Year Level",
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                DropdownButtonFormField<String>(
                                  value: selectedYearLevel,
                                  hint: const Text(
                                    "Select Year",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  isExpanded: true,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.school_outlined,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                      horizontal: 10,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  items: yearLevels.map((String level) {
                                    return DropdownMenuItem<String>(
                                      value: level,
                                      child: Text(
                                        level,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) =>
                                      setState(() => selectedYearLevel = value),
                                  validator: (value) => value == null
                                      ? "Please select year"
                                      : null,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Semester",
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                DropdownButtonFormField<String>(
                                  value: selectedSemester,
                                  hint: const Text(
                                    "Select Sem",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  isExpanded: true,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.calendar_month_outlined,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                      horizontal: 10,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  items: semesters.map((String sem) {
                                    return DropdownMenuItem<String>(
                                      value: sem,
                                      child: Text(
                                        sem,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) =>
                                      setState(() => selectedSemester = value),
                                  validator: (value) => value == null
                                      ? "Please select sem"
                                      : null,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: themeColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: completeRegistration,
                          child: const Text(
                            "Complete Setup",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
