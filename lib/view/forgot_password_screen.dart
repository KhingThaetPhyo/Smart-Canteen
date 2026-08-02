
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartcanteen/service/api_service.dart';
import 'package:smartcanteen/view/reset_password_screen.dart';
import 'package:smartcanteen/view/reset_pin_screen.dart';
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _service = ApiService();
  bool _isLoading = false;
void _handleSendOtp() async {
    // 1. Ensure the email input is not empty
    if (_emailController.text.trim().isEmpty) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text('အီးမေးလ် လိပ်စာ ထည့်သွင်းပါ'),
      //     backgroundColor: Colors.redAccent,
      //   ),
      // ); 
      
      return;
    }

    // 2. Validate format using form key
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    final email = _emailController.text.trim();

    // Call API endpoint POST /api/forgot-password
    final result = await _service.sendOtp(email);

    setState(() => _isLoading = false);

    if (!mounted) return;

    if (result['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message'] ?? 'OTP Code ကို အီးမေးလ်သို့ ပေးပို့လိုက်ပါပြီ။'),
          backgroundColor: const Color(0xff117992),
        ),
      );
      
      // Navigate to Reset Pin Screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResetPasswordScreen(email: email)),
      );
    } else {
      // Display error message returned from API (e.g., "ဤအီးမေးလ်ဖြင့် အကောင့် ရှာမတွေ့ပါ။")
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message'] ?? 'ဤအီးမေးလ်ဖြင့် အကောင့် ရှာမတွေ့ပါ။'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: PreferredSize(
  preferredSize: const Size.fromHeight(65.0),
  child: Container(
    margin: const EdgeInsets.only(top: 8, left: 12, right: 12),
    decoration: BoxDecoration(
      color: const Color(0xFF007A87),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF007A87).withOpacity(0.3),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: AppBar(
      automaticallyImplyLeading: false, // 👈 Add this line to hide the arrow icon
      title: const Padding(
        padding: EdgeInsets.only(bottom: 10.0),
        child: Text(
          'Password မေ့နေပါသလား',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
    ),
  ),
),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Form(
            key: _formKey,
            // Form Level မှာ autovalidateMode မထားပါ (အခြား Field များ အတူတူမတောင်းစေရန်)
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF007A87).withOpacity(0.12),
                          blurRadius: 20,
                          spreadRadius: 2,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.mark_email_unread_rounded,
                      size: 50,
                      color: Color(0xFF007A87),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                const Text(
                  'အကောင့်ဖွင့်ထားသော Email ကို ရိုက်ထည့်ပါ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),

                // Email Input Field
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: _emailController,
                    autovalidateMode: AutovalidateMode
                        .onUserInteraction, // ဒီ Field တစ်ခုတည်းကိုပဲ စစ်မည်
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: Colors.black87),

                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'[a-z0-9._%+-@]'),
                      ),
                    ],

                    decoration: InputDecoration(
                      labelText: 'အီးမေးလ် လိပ်စာ',
                      labelStyle: TextStyle(color: Colors.grey.shade600),
                      hintText: 'username@ucstt.edu.mm',
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      floatingLabelStyle: const TextStyle(
                        color: Color(0xFF007A87),
                        fontWeight: FontWeight.bold,
                      ),
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: Color(0xFF007A87),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 20,
                      ),
                      errorStyle: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.grey.shade200),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Color(0xFF007A87),
                          width: 2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Colors.redAccent),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Colors.redAccent,
                          width: 2,
                        ),
                      ),
                    ),

                    // မြန်မာလို Dynamic Suggestions/Errors
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return null;
                      }

                      if (!RegExp(r'^[a-z]').hasMatch(value)) {
                        return "အီးမေးလ်သည် စာလုံးအသေး (a-z) ဖြင့် စရပါမည် (ဥပမာ - thaet1)";
                      }

                      if (!value.contains("@")) {
                        return "Edu email တွင် @ ပါဝင်ရပါမည်";
                      }

                      if (!RegExp(
                        r'^[a-z][a-z0-9._%+-]*@ucstt\.edu\.mm$',
                      ).hasMatch(value)) {
                        return "username@ucstt.edu.mm ပုံစံအတိုင်း ရိုက်ထည့်ပါ";
                      }

                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 28),

                // Send OTP Button
                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleSendOtp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF007A87),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.teal.shade200,
                      elevation: 3,
                      shadowColor: const Color(0xFF007A87).withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
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
                        : const Text(
                            'OTP ပို့မည်',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
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