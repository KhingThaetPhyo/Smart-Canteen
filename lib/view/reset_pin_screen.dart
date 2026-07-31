
// import 'package:flutter/material.dart';
// import 'package:smartcanteen/service/api_service.dart';

// class ResetPinScreen extends StatefulWidget {
//   final String email;

//   const ResetPinScreen({Key? key, required this.email}) : super(key: key);

//   @override
//   State<ResetPinScreen> createState() => _ResetPinScreenState();
// }

// class _ResetPinScreenState extends State<ResetPinScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _otpController = TextEditingController();
//   final _newPinController = TextEditingController();
//   final _service = ApiService();
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     // Screen ပွင့်လာတာနဲ့ စခရင်အလယ်မှာ OTP ပို့ပြီးကြောင်း လှလှပပ Dialog/Alert Box ပြမည်
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _showCenterNotification();
//     });
//   }

//   // စခရင်အလယ်မှာ ပေါ်မည့် လှပသော Notification Box
//   void _showCenterNotification() {
//     showDialog(
//       context: context,
//       barrierDismissible: true,
//       builder: (BuildContext context) {
//         // ၅ စက္ကန့်ပြည့်ရင် အလိုအလျောက် ပိတ်သွားမည်
//         Future.delayed(const Duration(seconds: 4), () {
//           if (mounted && Navigator.canPop(context)) {
//             Navigator.of(context).pop();
//           }
//         });

//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           elevation: 10,
//           backgroundColor: Colors.white,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF007A87).withOpacity(0.1),
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(
//                     Icons.mark_email_read_rounded,
//                     color: Color(0xFF007A87),
//                     size: 40,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 const Text(
//                   'OTP ပို့ပြီးပါပြီ',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF007A87),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 const Text(
//                   'OTP နံပါတ်ကို အီးမေးလ်သို့ ပို့လိုက်ပါပြီ။\nကျေးဇူးပြု၍ စစ်ဆေးပေးပါ။',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.black87,
//                     height: 1.4,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void _handleResetPin() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() => _isLoading = true);
//     final result = await _service.resetPin(
//       email: widget.email,
//       otp: _otpController.text.trim(),
//       newPin: _newPinController.text.trim(),
//     );
//     setState(() => _isLoading = false);

//     if (!mounted) return;

//     if (result['success'] == true) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('PIN အသစ်ပြောင်းလဲခြင်း အောင်မြင်ပါသည်။'),
//           backgroundColor: Color(0xFF007A87),
//         ),
//       );
//       Navigator.popUntil(context, (route) => route.isFirst);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(result['message'] ?? 'ခေတ္တချို့ယွင်းချက်ရှိနေပါသည်။'),
//           backgroundColor: Colors.redAccent,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8FAFC),
//       // EnterEmailScreen နှင့် ပုံစံတူ Teal Card AppBar
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
//               'Reset Wallet PIN',
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
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 const SizedBox(height: 12),

//                 // Icon Circle Card Header
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
//                       Icons.lock_reset_rounded,
//                       size: 48,
//                       color: Color(0xFF007A87),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 // Email Display Container (အရင်ထက် ပိုသပ်ရပ်ပြီး အသွင်ဆန်းသွားပါမည်)
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 16,
//                     vertical: 14,
//                   ),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF007A87).withOpacity(0.06),
//                     borderRadius: BorderRadius.circular(16),
//                     border: Border.all(
//                       color: const Color(0xFF007A87).withOpacity(0.15),
//                     ),
//                   ),
//                   child: Row(
//                     children: [
//                       const Icon(
//                         Icons.account_circle_outlined,
//                         color: Color(0xFF007A87),
//                         size: 24,
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Email Address',
//                               style: TextStyle(
//                                 fontSize: 11,
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.grey.shade600,
//                               ),
//                             ),
//                             const SizedBox(height: 2),
//                             Text(
//                               widget.email,
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black87,
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 24),

//                 // OTP & PIN Input Card Box
//                 Container(
//                   padding: const EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.04),
//                         blurRadius: 15,
//                         offset: const Offset(0, 5),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     children: [
//                       // OTP Input Field
//                       TextFormField(
//                         controller: _otpController,
//                         keyboardType: TextInputType.number,
//                         style: const TextStyle(
//                           color: Colors.black87,
//                           fontWeight: FontWeight.w600,
//                         ),
//                         decoration: InputDecoration(
//                           labelText: 'OTP Code',
//                           labelStyle: TextStyle(color: Colors.grey.shade600),
//                           hintText: '၆ လုံးဂဏန်း ရိုက်ထည့်ပါ',
//                           hintStyle: TextStyle(
//                             color: Colors.grey.shade400,
//                             fontSize: 13,
//                           ),
//                           prefixIcon: const Icon(
//                             Icons.lock_clock_outlined,
//                             color: Color(0xFF007A87),
//                           ),
//                           filled: true,
//                           fillColor: const Color(0xFFF8FAFC),
//                           contentPadding: const EdgeInsets.symmetric(
//                             vertical: 16,
//                             horizontal: 16,
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(14),
//                             borderSide: BorderSide.none,
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(14),
//                             borderSide: BorderSide(color: Colors.grey.shade200),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(14),
//                             borderSide: const BorderSide(
//                               color: Color(0xFF007A87),
//                               width: 2,
//                             ),
//                           ),
//                         ),
//                         validator: (val) => val == null || val.isEmpty
//                             ? 'OTP ရိုက်ထည့်ပါ'
//                             : null,
//                       ),
//                       const SizedBox(height: 16),

//                       // New PIN Input Field
//                       TextFormField(
//                         controller: _newPinController,
//                         keyboardType: TextInputType.number,
//                         obscureText: true,
//                         maxLength: 6,
//                         style: const TextStyle(
//                           color: Colors.black87,
//                           fontWeight: FontWeight.w600,
//                         ),
//                         decoration: InputDecoration(
//                           labelText: 'New PIN',
//                           labelStyle: TextStyle(color: Colors.grey.shade600),
//                           hintText: 'PIN အသစ် (၆ လုံး)',
//                           hintStyle: TextStyle(
//                             color: Colors.grey.shade400,
//                             fontSize: 13,
//                           ),
//                           counterText:
//                               "", // maxLength ဂဏန်းစာသားကို ဖျောက်ထားသည်
//                           prefixIcon: const Icon(
//                             Icons.key_outlined,
//                             color: Color(0xFF007A87),
//                           ),
//                           filled: true,
//                           fillColor: const Color(0xFFF8FAFC),
//                           contentPadding: const EdgeInsets.symmetric(
//                             vertical: 16,
//                             horizontal: 16,
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(14),
//                             borderSide: BorderSide.none,
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(14),
//                             borderSide: BorderSide(color: Colors.grey.shade200),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(14),
//                             borderSide: const BorderSide(
//                               color: Color(0xFF007A87),
//                               width: 2,
//                             ),
//                           ),
//                         ),
//                         validator: (val) {
//                           if (val == null || val.isEmpty) {
//                             return 'PIN အသစ် ရိုက်ထည့်ပါ';
//                           }
//                           if (val.length < 6) {
//                             return 'PIN သည် အနည်းဆုံး ၆ လုံး ရှိရပါမည်';
//                           }
//                           return null;
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 28),

//                 // Submit Button
//                 SizedBox(
//                   height: 52,
//                   child: ElevatedButton(
//                     onPressed: _isLoading ? null : _handleResetPin,
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
//                             'Reset PIN',
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
import 'package:smartcanteen/service/api_service.dart';

class ResetPinScreen extends StatefulWidget {
  final String email;

  const ResetPinScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<ResetPinScreen> createState() => _ResetPinScreenState();
}

class _ResetPinScreenState extends State<ResetPinScreen> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  final _newPinController = TextEditingController();
  final _service = ApiService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showCenterNotification();
    });
  }

  void _showCenterNotification() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 4), () {
          if (mounted && Navigator.canPop(context)) {
            Navigator.of(context).pop();
          }
        });

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 10,
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF007A87).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.mark_email_read_rounded,
                    color: Color(0xFF007A87),
                    size: 40,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'OTP ပို့ပြီးပါပြီ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF007A87),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'OTP နံပါတ်ကို အီးမေးလ်သို့ ပို့လိုက်ပါပြီ။\nကျေးဇူးပြု၍ စစ်ဆေးပေးပါ။',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleResetPin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    final result = await _service.resetPin(
      email: widget.email,
      otp: _otpController.text.trim(),
      newPin: _newPinController.text.trim(),
    );
    setState(() => _isLoading = false);

    if (!mounted) return;

    if (result['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('PIN အသစ်ပြောင်းလဲခြင်း အောင်မြင်ပါသည်။[cite: 19]'),
          backgroundColor: Color(0xFF007A87),
        ),
      );
      Navigator.popUntil(context, (route) => route.isFirst);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message'] ?? 'ခေတ္တချို့ယွင်းချက်ရှိနေပါသည်။[cite: 19]'),
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
              'Reset Wallet PIN',
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 12),
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
                      Icons.lock_reset_rounded,
                      size: 48,
                      color: Color(0xFF007A87),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF007A87).withOpacity(0.06),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFF007A87).withOpacity(0.15),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.account_circle_outlined,
                        color: Color(0xFF007A87),
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email Address',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              widget.email,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _otpController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: InputDecoration(
                          labelText: 'OTP Code',
                          labelStyle: TextStyle(color: Colors.grey.shade600),
                          hintText: '၆ လုံးဂဏန်း ရိုက်ထည့်ပါ',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 13,
                          ),
                          prefixIcon: const Icon(
                            Icons.lock_clock_outlined,
                            color: Color(0xFF007A87),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF8FAFC),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: Colors.grey.shade200),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(
                              color: Color(0xFF007A87),
                              width: 2,
                            ),
                          ),
                        ),
                        validator: (val) => val == null || val.isEmpty
                            ? 'OTP ရိုက်ထည့်ပါ'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _newPinController,
                        keyboardType: TextInputType.number,
                        obscureText: true,
                        maxLength: 6,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: InputDecoration(
                          labelText: 'New PIN',
                          labelStyle: TextStyle(color: Colors.grey.shade600),
                          hintText: 'PIN အသစ် (၆ လုံး)',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 13,
                          ),
                          counterText: "",
                          prefixIcon: const Icon(
                            Icons.key_outlined,
                            color: Color(0xFF007A87),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF8FAFC),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: Colors.grey.shade200),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(
                              color: Color(0xFF007A87),
                              width: 2,
                            ),
                          ),
                        ),
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'PIN အသစ် ရိုက်ထည့်ပါ';
                          }
                          if (val.length < 6) {
                            return 'PIN သည် အနည်းဆုံး ၆ လုံး ရှိရပါမည်';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleResetPin,
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
                            'Reset PIN',
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