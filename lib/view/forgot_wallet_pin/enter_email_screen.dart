// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:smartcanteen/view/forgot_wallet_pin/forgot_pin_service.dart';

// import 'reset_pin_screen.dart';

// class EnterEmailScreen extends StatefulWidget {
//   const EnterEmailScreen({Key? key}) : super(key: key);

//   @override
//   State<EnterEmailScreen> createState() => _EnterEmailScreenState();
// }

// class _EnterEmailScreenState extends State<EnterEmailScreen> {
//   final _emailController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   final _service = ForgotPinService();
//   bool _isLoading = false;

//   void _handleSendOtp() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() => _isLoading = true);
//     final email = _emailController.text.trim();

//     final result = await _service.sendOtp(email);

//     setState(() => _isLoading = false);

//     if (!mounted) return;

//     if (result['success'] == true) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('OTP နံပါတ်ကို အီးမေးလ်သို့ ပို့လိုက်ပါပြီ။'),
//           backgroundColor: Color(0xFF007A87),
//         ),
//       );
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => ResetPinScreen(email: email)),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(result['message'] ?? 'Error occurred.'),
//           backgroundColor: Colors.redAccent,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8FAFC),
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(65.0),
//         child: Container(
//           margin: const EdgeInsets.only(top: 8, left: 12, right: 12),
//           decoration: BoxDecoration(
//             color: const Color(0xFF007A87),
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                 color: const Color(0xFF007A87).withOpacity(0.3),
//                 blurRadius: 12,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: AppBar(
//             title: const Text(
//               'Forgot Wallet PIN',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18,
//               ),
//             ),
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//             centerTitle: true,
//             iconTheme: const IconThemeData(color: Colors.white),
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
//           child: Form(
//             key: _formKey,
//             autovalidateMode: AutovalidateMode
//                 .onUserInteraction, // ရိုက်လိုက်တာနဲ့ Dynamic Validation ပြပေးမည်
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 const SizedBox(height: 20), // အပေါ်ဘက်သို့ တင်ပေးထားပါသည်
//                 // Icon Card Header
//                 Center(
//                   child: Container(
//                     padding: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       shape: BoxShape.circle,
//                       boxShadow: [
//                         BoxShadow(
//                           color: const Color(0xFF007A87).withOpacity(0.12),
//                           blurRadius: 20,
//                           spreadRadius: 2,
//                           offset: const Offset(0, 6),
//                         ),
//                       ],
//                     ),
//                     child: const Icon(
//                       Icons.mark_email_unread_rounded,
//                       size: 50,
//                       color: Color(0xFF007A87),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 24),

//                 const Text(
//                   'အကောင့်ဖွင့်ထားသော Email ကို ရိုက်ထည့်ပါ',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 // Email Input Field Container
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.03),
//                         blurRadius: 10,
//                         offset: const Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: TextFormField(
//                     controller: _emailController,
//                     keyboardType: TextInputType.emailAddress,
//                     style: const TextStyle(color: Colors.black87),

//                     // စာလုံးအသေး (lowercase) သာ ရိုက်ခွင့်ပေးမည်
//                     inputFormatters: [
//                       FilteringTextInputFormatter.allow(
//                         RegExp(r'[a-z0-9._%+-@]'),
//                       ),
//                     ],

//                     decoration: InputDecoration(
//                       labelText: 'Email Address',
//                       labelStyle: TextStyle(color: Colors.grey.shade600),
//                       hintText: 'username@ucstt.edu.mm',

//                       // helperText ကို ဖြုတ်ထားပါသည် (စာမရိုက်ခင် Suggestion မပေါ်စေရန်)
//                       prefixIcon: const Icon(
//                         Icons.email_outlined,
//                         color: Color(0xFF007A87),
//                       ),
//                       filled: true,
//                       fillColor: Colors.white,
//                       contentPadding: const EdgeInsets.symmetric(
//                         vertical: 16,
//                         horizontal: 20,
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(16),
//                         borderSide: BorderSide(color: Colors.grey.shade200),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(16),
//                         borderSide: BorderSide(color: Colors.grey.shade300),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(16),
//                         borderSide: const BorderSide(
//                           color: Color(0xFF007A87),
//                           width: 2,
//                         ),
//                       ),
//                       errorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(16),
//                         borderSide: const BorderSide(color: Colors.redAccent),
//                       ),
//                       focusedErrorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(16),
//                         borderSide: const BorderSide(
//                           color: Colors.redAccent,
//                           width: 2,
//                         ),
//                       ),
//                     ),

//                     // Dynamic Validation Rules (စာရိုက်မှသာ ပေါ်မည်)
//                     validator: (value) {
//                       // ၁။ စာဘာမှ မရိုက်ရသေးလျှင်/ကွက်လပ်ဖြစ်နေလျှင် ဘာမှမပြပါ
//                       if (value == null || value.isEmpty) {
//                         return null;
//                       }

//                       // ၂။ စာလုံး (a-z) နဲ့ မစဘဲ ဂဏန်း သို့မဟုတ် သင်္ကေတနဲ့ စထားပါက
//                       if (!RegExp(r'^[a-z]').hasMatch(value)) {
//                         return "Must start with letters (e.g. thaet1)";
//                       }

//                       // ၃။ '@' မပါသေးပါက
//                       if (!value.contains("@")) {
//                         return "Edu mail must contain @";
//                       }

//                       // ၄။ '@' ပါပြီး Domain နာမည် မပြည့်စုံပါက
//                       if (!RegExp(
//                         r'^[a-z][a-z0-9._%+-]*@ucstt\.edu\.mm$',
//                       ).hasMatch(value)) {
//                         return "Use username@ucstt.edu.mm";
//                       }

//                       // မှန်ကန်သွားပါက အနီရောင်စာတန်း မပြတော့ပါ
//                       return null;
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: 28),

//                 // Send OTP Button
//                 SizedBox(
//                   height: 52,
//                   child: ElevatedButton(
//                     onPressed: _isLoading ? null : _handleSendOtp,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF007A87),
//                       foregroundColor: Colors.white,
//                       disabledBackgroundColor: Colors.teal.shade200,
//                       elevation: 3,
//                       shadowColor: const Color(0xFF007A87).withOpacity(0.3),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                     ),
//                     child: _isLoading
//                         ? const SizedBox(
//                             width: 24,
//                             height: 24,
//                             child: CircularProgressIndicator(
//                               color: Colors.white,
//                               strokeWidth: 2.5,
//                             ),
//                           )
//                         : const Text(
//                             'Send OTP',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               letterSpacing: 0.5,
//                             ),
//                           ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartcanteen/view/forgot_wallet_pin/forgot_pin_service.dart';

import 'reset_pin_screen.dart';

class EnterEmailScreen extends StatefulWidget {
  const EnterEmailScreen({Key? key}) : super(key: key);

  @override
  State<EnterEmailScreen> createState() => _EnterEmailScreenState();
}

class _EnterEmailScreenState extends State<EnterEmailScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _service = ForgotPinService();
  bool _isLoading = false;

  void _handleSendOtp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    final email = _emailController.text.trim();

    final result = await _service.sendOtp(email);

    setState(() => _isLoading = false);

    if (!mounted) return;

    if (result['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('OTP နံပါတ်ကို အီးမေးလ်သို့ ပို့လိုက်ပါပြီ။'),
          backgroundColor: Color(0xFF007A87),
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResetPinScreen(email: email)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message'] ?? 'အမှားတစ်ခု ဖြစ်ပေါ်နေပါသည်။'),
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
            title: const Text(
              'Wallet PIN မေ့နေပါသလား',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.white),
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
