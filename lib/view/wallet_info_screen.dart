// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:smartcanteen/model/user_model.dart';
// import 'package:smartcanteen/service/api_service.dart';

// class WalletInfoScreen extends StatefulWidget {
//    final UserModel user;
//   const WalletInfoScreen({super.key, required this.user});

//   @override
//   State<WalletInfoScreen> createState() => _WalletInfoScreenState();
// }

// class _WalletInfoScreenState extends State<WalletInfoScreen> {
//   String _pin = "";
//   final int _maxPinLength = 6;
//   bool _isLoading = false;
//   bool _isSuccess = false;

//   void _pressKey(String num) {
//     if (_pin.length < _maxPinLength && !_isLoading && !_isSuccess) {
//       setState(() {
//         _pin += num;
//       });
//     }
//   }

//   void _deleteKey() {
//     if (_pin.isNotEmpty && !_isLoading && !_isSuccess) {
//       setState(() {
//         _pin = _pin.substring(0, _pin.length - 1);
//       });
//     }
//   }

//   void _handleComplete() async {
//     if (_pin.length == _maxPinLength && !_isLoading && !_isSuccess) {
//       setState(() {
//         _isLoading = true;
//       });

//       //await Future.delayed(const Duration(milliseconds: 1200));
//       final result = await ApiService().registerUser(
//   name: widget.user.userName,
//   email: widget.user.userEmail,
//   phone: widget.user.userPhone,
//   password: widget.user.userPassword,
//   role: widget.user.roleName,
//   studentId: widget.user.student!.studentId,
//   semester: widget.user.student!.semester,
//   academicYear: widget.user.student!.academicYear,
//   yearLevel: widget.user.student!.yearLevel,
//   walletPin: _pin,
// );

// if(result != null && result.success){
//    setState(() {
//       _isLoading=false;
//       _isSuccess=true;
//    });
// }
// else{
//    setState(() {
//       _isLoading=false;
//    });

//    ScaffoldMessenger.of(context).showSnackBar(
//      const SnackBar(
//        content: Text("Registration Failed"),
//      ),
//    );
// }

//   @override
//   Widget build(BuildContext context) {
//     print(widget.user.userName);
//   print(widget.user.userEmail);
//   print(widget.user.userPhone);
//  print(widget.user.student!.studentId);
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//     icon: const Icon(
//       Icons.arrow_back,
//       color: Colors.black,
//     ),
//     onPressed: () {
//       context.go("/register");
//     },
//   ),
//         shadowColor: Colors.transparent,
//         elevation: 0,
//         surfaceTintColor: Colors.transparent,
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Color(0xFFF7F9FE),
//               Color(0xFFECEEF3),
//               Color(0xFFD3E5F2),
//             ],
//             stops: [0.0, 0.6, 1.0],
//           ),
//         ),
//         child: Stack(
//           children: [
//             // Decorative Background Blobs
//             // Center(
//             //   child: Container(
//             //     decoration: BoxDecoration(
//             //       shape: BoxShape.circle,
//             //       color: const Color(0xFFB7C4FF).withOpacity(0.25),
//             //     ),
//             //     child: BackdropFilter(
//             //       filter: ImageFilter.blur(sigmaX: 120, sigmaY: 120),
//             //       child: const SizedBox.shrink(),
//             //     ),
//             //   ),
//             // ),
//             Container(
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: const Color(0xFFB7EAFF).withOpacity(0.3),
//               ),
//               child: BackdropFilter(
//                 filter: ImageFilter.blur(sigmaX: 120, sigmaY: 120),
//                 child: const SizedBox.shrink(),
//               ),
//             ),

//             // Main UI Layout (Guaranteed No Scroll)
//             SafeArea(
//               child: LayoutBuilder(
//                 builder: (context, constraints) {
//                   // Detects smaller/shorter device screens (e.g., iPhone SE)
//                   final bool isShortScreen = constraints.maxHeight < 720;

//                   return Column(
//                     children: [
//                       // Dynamic Upper Section (Flexes to fill available space)
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               //const Spacer(flex: 2),
                              
//                               // Adaptive Lock Glass Container
//                               Center(
//                                 child: Stack(
//                                   alignment: Alignment.center,
//                                   children: [
//                                     Container(
//                                       width: isShortScreen ? 90 : 130,
//                                       height: isShortScreen ? 90 : 130,
//                                       decoration: BoxDecoration(
//                                         color: const Color(0xFF0039B7).withOpacity(0.04),
//                                         shape: BoxShape.circle,
//                                       ),
//                                     ),
//                                     ClipRRect(
//                                       borderRadius: BorderRadius.circular(isShortScreen ? 24 : 36),
//                                       child: BackdropFilter(
//                                         filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//                                         child: Container(
//                                           width: isShortScreen ? 76 : 110,
//                                           height: isShortScreen ? 76 : 110,
//                                           decoration: BoxDecoration(
//                                             color: Colors.white.withOpacity(0.65),
//                                             borderRadius: BorderRadius.circular(isShortScreen ? 24 : 36),
//                                             border: Border.all(
//                                               color: const Color(0xFF004CEE).withOpacity(0.15),
//                                               width: 1.5,
//                                             ),
//                                             boxShadow: [
//                                               BoxShadow(
//                                                 color: const Color(0xFF004CEE).withOpacity(0.06),
//                                                 blurRadius: 32,
//                                                 offset: const Offset(0, 8),
//                                               )
//                                             ],
//                                           ),
//                                           padding: EdgeInsets.all(isShortScreen ? 16 : 22),
//                                           child: FittedBox(
//                                             fit: BoxFit.contain,
//                                             child: Icon(
//                                               Icons.lock_outline_rounded,
//                                               color: const Color(0xFF004CEE),
//                                               size: isShortScreen ? 32 : 44,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
                              
//                               const Spacer(flex: 2),

//                               // Header Texts
//                               Text(
//                                 'Secure Your Wallet',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   fontSize: isShortScreen ? 20 : 22,
//                                   fontWeight: FontWeight.w600,
//                                   color: const Color(0xFF181C20),
//                                   letterSpacing: -0.5,
//                                 ),
//                               ),
//                               const SizedBox(height: 6),
//                               SizedBox(
//                                 width: 280,
//                                 child: Text(
//                                   'Create a 6-digit PIN to authorize payments and keep your funds safe.',
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     fontSize: isShortScreen ? 14 : 15,
//                                     height: 1.4,
//                                     color: const Color(0xFF434656),
//                                   ),
//                                 ),
//                               ),
                              
//                               const Spacer(flex: 3),

//                               // PIN Input Indicators
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: List.generate(_maxPinLength, (index) {
//                                   bool isActive = index < _pin.length;
//                                   return AnimatedContainer(
//                                     duration: const Duration(milliseconds: 200),
//                                     margin: const EdgeInsets.symmetric(horizontal: 8),
//                                     width: isShortScreen ? 12 : 14,
//                                     height: isShortScreen ? 12 : 14,
//                                     decoration: BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       color: isActive ? const Color(0xFF004CED) : Colors.white.withOpacity(0.4),
//                                       border: Border.all(
//                                         color: isActive ? const Color(0xFF004CED) : const Color(0xFF747687).withOpacity(0.3),
//                                         width: 1,
//                                       ),
//                                       boxShadow: isActive
//                                           ? [
//                                               BoxShadow(
//                                                 color: const Color(0xFF004CED).withOpacity(0.4),
//                                                 blurRadius: 5,
//                                               )
//                                             ]
//                                           : [],
//                                     ),
//                                   );
//                                 }),
//                               ),
                              
//                               const Spacer(flex: 2),
//                             ],
//                           ),
//                         ),
//                       ),

//                       // Fixed Bottom Segment (Keypad + CTA Button)
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             // Keypad Grid
//                             SizedBox(
//                               width: 260,
//                               child: GridView.builder(
//                                 shrinkWrap: true,
//                                 padding: EdgeInsets.zero,
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: 3,
//                                   mainAxisSpacing: isShortScreen ? 12 : 18,
//                                   crossAxisSpacing: isShortScreen ? 12 : 18,
//                                   childAspectRatio: 1,
//                                 ),
//                                 itemCount: 12,
//                                 itemBuilder: (context, index) {
//                                   if (index == 9) return const SizedBox.shrink();
//                                   if (index == 11) {
//                                     return ElevatedButton(
//                                       child: const Icon(Icons.backspace_outlined, size: 20, color: Color(0xFF0039B7)),
//                                       onPressed: _deleteKey,
//                                     );
//                                   }
//                                   String keyText = index == 10 ? "0" : "${index + 1}";
//                                   return ElevatedButton(
//                                     child: Text(
//                                       keyText,
//                                       style: const TextStyle(
//                                         fontSize: 22,
//                                         fontWeight: FontWeight.bold,
//                                         color: Color(0xFF0039B7), // Turned text dark blue for better contrast against light blue
//                                       ),
//                                     ),
//                                     onPressed: () => _pressKey(keyText),
//                                   );
//                                 },
//                               ),
//                             ),
                            
//                             SizedBox(height: isShortScreen ? 16 : 28),

//                             // CTA Action Button
//                             Padding(
//                               padding: const EdgeInsets.only(bottom: 16.0),
//                               child: AnimatedContainer(
//                                 duration: const Duration(milliseconds: 300),
//                                 width: double.infinity,
//                                 height: isShortScreen ? 54 : 60,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(16),
//                                   color: _isSuccess
//                                       ? const Color(0xFF22C55E)
//                                       : (_pin.length == _maxPinLength ? const Color(0xFF004CED) : const Color(0xFFE0E2E7)),
//                                   boxShadow: _pin.length == _maxPinLength && !_isSuccess
//                                       ? [
//                                           BoxShadow(
//                                             color: const Color(0xFF004CEE).withOpacity(0.3),
//                                             blurRadius: 24,
//                                             offset: const Offset(0, 8),
//                                           )
//                                         ]
//                                       : _isSuccess
//                                           ? [
//                                               BoxShadow(
//                                                 color: const Color(0xFF22C55E).withOpacity(0.2),
//                                                 blurRadius: 24,
//                                                 offset: const Offset(0, 8),
//                                               )
//                                             ]
//                                           : [],
//                                 ),
//                                 child: ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.transparent,
//                                     shadowColor: Colors.transparent,
//                                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//                                     disabledForegroundColor: const Color(0xFF747687),
//                                   ),
//                                   onPressed: (_pin.length == _maxPinLength) ? _handleComplete : null,
//                                   child: _buildButtonContent(),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildButtonContent() {
//     if (_isLoading) {
//       return const SizedBox(
//         width: 24,
//         height: 24,
//         child: CircularProgressIndicator(
//           color: Colors.white,
//           strokeWidth: 2.5,
//         ),
//       );
//     }
//     if (_isSuccess) {
//       return const Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.check_circle, color: Colors.white),
//           SizedBox(width: 8),
//           Text(
//             'PIN Setup Successful',
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
//           ),
//         ],
//       );
//     }
//     return Text(
//       'Complete Registration',
//       style: TextStyle(
//         fontSize: 16,
//         fontWeight: FontWeight.bold,
//         color: _pin.length == _maxPinLength ? Colors.white : const Color(0xFF747687),
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'dart:ui';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smartcanteen/model/user_model.dart';
import 'package:smartcanteen/service/api_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:smartcanteen/service/secure_storage_service.dart';

class WalletInfoScreen extends StatefulWidget {
  final UserModel user;

  const WalletInfoScreen({
    super.key,
    required this.user,
  });

  @override
  State<WalletInfoScreen> createState() => _WalletInfoScreenState();
}

class _WalletInfoScreenState extends State<WalletInfoScreen> {
  String _pin = "";
  final int _maxPinLength = 6;

  bool _isLoading = false;
  bool _isSuccess = false;


  void _pressKey(String num) {

    if (_pin.length <= _maxPinLength &&
        !_isLoading &&
        !_isSuccess) {
      setState(() {
        _pin += num;
      });
    }
  }


  void _deleteKey() {
    if (_pin.isNotEmpty &&
        !_isLoading &&
        !_isSuccess) {
      setState(() {
        _pin =
            _pin.substring(0, _pin.length - 1);
      });
    }
  }

void _showRegistrationFailedDialog(
  BuildContext context,
  String message,
) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.08),
                blurRadius: 30,
                spreadRadius: 5,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              /// Emoji
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.yellow.shade300,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.yellow.withOpacity(.5),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    "☹️",
                    style: TextStyle(fontSize: 48),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Registration Failed!!!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff2E3A59),
                ),
              ),

              const SizedBox(height: 10),

              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 30),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff64B5F6),
                      Color(0xff1976D2),
                    ],
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    context.go("/register");
                  },
                  child: const Text(
                    "OK",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
  void _handleComplete() async {

  print("========== HANDLE COMPLETE ==========");
  
  print("PIN: $_pin");
  print("Length: ${_pin.length}");
  print("Loading: $_isLoading");
  print("Success: $_isSuccess");
  print("====================================");

  if (_pin.length == _maxPinLength &&
      !_isLoading &&
      !_isSuccess) {

    print("Entered _handleComplete");
    print("Calling registerUser");

    setState(() {
  _isLoading = true;
});
try {
      // FCM token ယူခြင်း
      String? fcmToken = await FirebaseMessaging.instance.getToken();

      // Console မှာ user device token print ထုတ်ခြင်း
      print("====================================");
      print("User Device FCM Token:");
      print(fcmToken);
      print("====================================");

      final result = await ApiService().registerUser(
        name: widget.user.userName,
        email: widget.user.userEmail,
        phone: widget.user.userPhone,
        password: widget.user.userPassword ?? "",
        role: widget.user.roleName,
        studentId: widget.user.student?.studentId,
        semester: widget.user.student?.semester,
        academicYear: widget.user.student?.academicYear,
        yearLevel: widget.user.student?.yearLevel,
        walletPin: _pin,
        fcmToken: fcmToken, // API ကို token ပို့ခြင်း
      );
  setState(() {
    _isLoading = false;
  });

  // Registration Success
if (result != null && result.success) {
  setState(() {
    _isSuccess = true;
  });

  // Save auth token
  if (result.token != null) {
    await SecureStorageService.saveToken(result.token!);
  }

  // Save FCM token
  if (result.user?.fcmToken != null) {
    await SecureStorageService.saveFcmToken(result.user!.fcmToken!);
  }

  if (!mounted) return;

//   // Create unique QR data for the user
// final qrData = result.user?.userId != null
//     ? 'SMARTCANTEEN_USER_${result.user!.userId}'
//     : 'SMARTCANTEEN_USER';

// // Navigate to QR screen
// context.go(
//   '/user_qr',
//   extra: qrData,
// );
// Create QR data with username and student ID
var qrData = jsonEncode({
  'user_name': result.user?.userName ?? '',
  'student_id': result.user?.student?.studentId ?? '',
});
print("User QR Data -------  {$qrData}");
await SecureStorageService.saveQrData(qrData);
 final savedQr =
        await SecureStorageService.getQrData();


    print("========== QR STORAGE ==========");
    print(savedQr);
    print("================================");
// Navigate to QR screen
context.go(
  '/navigation',
  extra: qrData,
);
}
  // Registration Failed
  else {
    if (!mounted) return;

    _showRegistrationFailedDialog(
  context,
  result?.message ?? "Registration failed.",
);
  }
} catch (e) {
  setState(() {
    _isLoading = false;
  });

  if (!mounted) return;

  _showRegistrationFailedDialog(
     context,
    e.toString(),
  );
}

  } else {

    print("Condition Failed");
    print("_pin.length == $_maxPinLength ? ${_pin.length == _maxPinLength}");
    print("!_isLoading = ${!_isLoading}");
    print("!_isSuccess = ${!_isSuccess}");
  }
}
  @override
  Widget build(BuildContext context) {

    print("name"+widget.user.userName);
    print("email"+widget.user.userEmail);
    print("phone"+widget.user.userPhone);
    print(widget.user.userId);
    print(widget.user.userPassword);
    print("rolename"+widget.user.roleName);
print("studentid: ${widget.user.student?.studentId}");
print("academicId: ${widget.user.student?.academicId}");
print("academic year: ${widget.user.student?.academicYear}");
print("semester: ${widget.user.student?.semester}");
print("userId: ${widget.user.student?.userId}");
    return Scaffold(
            appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            context.go("/register");
          },
        ),
        shadowColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF7F9FE),
              Color(0xFFECEEF3),
              Color(0xFFD3E5F2),
            ],
            stops: [0.0, 0.6, 1.0],
          ),
        ),

        child: Stack(
          children: [

            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFB7EAFF)
                    .withOpacity(0.3),
              ),

              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 120,
                  sigmaY: 120,
                ),

                child: const SizedBox.shrink(),
              ),
            ),


            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {

                  final bool isShortScreen =
                      constraints.maxHeight < 720;


                  return Column(
                    children: [

                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(
                                  horizontal: 24.0),

                          child: Column(
                            mainAxisAlignment:
                                MainAxisAlignment.center,

                            children: [


                              Center(
                                child: Stack(
                                  alignment:
                                      Alignment.center,

                                  children: [

                                    Container(
                                      width: isShortScreen
                                          ? 90
                                          : 130,

                                      height: isShortScreen
                                          ? 90
                                          : 130,

                                      decoration:
                                          BoxDecoration(
                                        color: const Color(
                                                0xFF0039B7)
                                            .withOpacity(
                                                0.04),

                                        shape:
                                            BoxShape.circle,
                                      ),
                                    ),


                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(
                                        isShortScreen
                                            ? 24
                                            : 36,
                                      ),

                                      child:
                                          BackdropFilter(
                                        filter:
                                            ImageFilter.blur(
                                          sigmaX: 20,
                                          sigmaY: 20,
                                        ),

                                        child: Container(
                                          width:
                                              isShortScreen
                                                  ? 76
                                                  : 110,

                                          height:
                                              isShortScreen
                                                  ? 76
                                                  : 110,

                                          decoration:
                                              BoxDecoration(

                                            color: Colors
                                                .white
                                                .withOpacity(
                                                    0.65),

                                            borderRadius:
                                                BorderRadius
                                                    .circular(
                                              isShortScreen
                                                  ? 24
                                                  : 36,
                                            ),

                                            border:
                                                Border.all(
                                              color:
                                                  const Color(
                                                          0xFF004CEE)
                                                      .withOpacity(
                                                          0.15),

                                              width: 1.5,
                                            ),

                                            boxShadow: [
                                              BoxShadow(
                                                color:
                                                    const Color(
                                                            0xFF004CEE)
                                                        .withOpacity(
                                                            0.06),

                                                blurRadius:
                                                    32,

                                                offset:
                                                    const Offset(
                                                        0, 8),
                                              )
                                            ],
                                          ),


                                          padding:
                                              EdgeInsets.all(
                                            isShortScreen
                                                ? 16
                                                : 22,
                                          ),


                                          child: FittedBox(
                                            fit: BoxFit.contain,

                                            child: Icon(
                                              Icons
                                                  .lock_outline_rounded,

                                              color:
                                                  const Color(
                                                      0xFF004CEE),

                                              size:
                                                  isShortScreen
                                                      ? 32
                                                      : 44,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),


                              const Spacer(flex: 2),
                                                            Text(
                                'Secure Your Wallet',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: isShortScreen ? 20 : 22,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF181C20),
                                  letterSpacing: -0.5,
                                ),
                              ),

                              const SizedBox(height: 6),

                              SizedBox(
                                width: 280,
                                child: Text(
                                  'Create a 6-digit PIN to authorize payments and keep your funds safe.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize:
                                        isShortScreen ? 14 : 15,
                                    height: 1.4,
                                    color:
                                        const Color(0xFF434656),
                                  ),
                                ),
                              ),


                              const Spacer(flex: 3),


                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,

                                children:
                                    List.generate(
                                  _maxPinLength,
                                  (index) {

                                    bool isActive =
                                        index < _pin.length;

                                    return AnimatedContainer(
                                      duration:
                                          const Duration(
                                              milliseconds:
                                                  200),

                                      margin:
                                          const EdgeInsets
                                              .symmetric(
                                              horizontal: 8),

                                      width: isShortScreen
                                          ? 12
                                          : 14,

                                      height: isShortScreen
                                          ? 12
                                          : 14,

                                      decoration:
                                          BoxDecoration(

                                        shape:
                                            BoxShape.circle,

                                        color: isActive
                                            ? const Color(
                                                0xFF004CED)
                                            : Colors.white
                                                .withOpacity(
                                                    0.4),

                                        border:
                                            Border.all(
                                          color: isActive
                                              ? const Color(
                                                  0xFF004CED)
                                              : const Color(
                                                      0xFF747687)
                                                  .withOpacity(
                                                      0.3),

                                          width: 1,
                                        ),

                                        boxShadow: isActive
                                            ? [
                                                BoxShadow(
                                                  color: const Color(
                                                          0xFF004CED)
                                                      .withOpacity(
                                                          0.4),

                                                  blurRadius: 5,
                                                )
                                              ]
                                            : [],
                                      ),
                                    );
                                  },
                                ),
                              ),


                              const Spacer(flex: 2),
                            ],
                          ),
                        ),
                      ),



                      Padding(
                        padding:
                            const EdgeInsets.symmetric(
                                horizontal: 24.0),

                        child: Column(
                          mainAxisSize:
                              MainAxisSize.min,

                          children: [

                            SizedBox(
                              width: 260,

                              child: GridView.builder(
                                shrinkWrap: true,

                                padding: EdgeInsets.zero,

                                physics:
                                    const NeverScrollableScrollPhysics(),

                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,

                                  mainAxisSpacing:
                                      isShortScreen
                                          ? 12
                                          : 18,

                                  crossAxisSpacing:
                                      isShortScreen
                                          ? 12
                                          : 18,

                                  childAspectRatio: 1,
                                ),

                                itemCount: 12,


                                itemBuilder:
                                    (context, index) {


                                  if (index == 9) {
                                    return const SizedBox
                                        .shrink();
                                  }


                                  if (index == 11) {

                                    return ElevatedButton(
                                      onPressed:
                                          _deleteKey,

                                      child: const Icon(
                                        Icons
                                            .backspace_outlined,

                                        size: 20,

                                        color:
                                            Color(0xFF0039B7),
                                      ),
                                    );
                                  }


                                  String keyText =
                                      index == 10
                                          ? "0"
                                          : "${index + 1}";


                                  return ElevatedButton(

                                    onPressed: () =>
                                        _pressKey(
                                            keyText),

                                    child: Text(
                                      keyText,

                                      style:
                                          const TextStyle(
                                        fontSize: 22,

                                        fontWeight:
                                            FontWeight.bold,

                                        color:
                                            Color(0xFF0039B7),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),



                            SizedBox(
                              height:
                                  isShortScreen ? 16 : 28,
                            ),



                            Padding(
                              padding:
                                  const EdgeInsets.only(
                                      bottom: 16),

                              child: SizedBox(
                                width:
                                    double.infinity,

                                height:
                                    isShortScreen
                                        ? 54
                                        : 60,

                                child: ElevatedButton(

                                  onPressed:
                                      (_pin.length ==
                                              _maxPinLength)
                                          ? _handleComplete
                                          : null,


                                  child:
                                      _buildButtonContent(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget _buildButtonContent() {

    if (_isLoading) {

      return const SizedBox(
        width: 24,
        height: 24,

        child:
            CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 2.5,
        ),
      );
    }


    if (_isSuccess) {

      return const Row(
        mainAxisAlignment:
            MainAxisAlignment.center,

        children: [

          Icon(
            Icons.check_circle,
            color: Colors.white,
          ),

          SizedBox(width: 8),

          Text(
            'PIN Setup Successful',

            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      );
    }


    return Text(
      'Complete Registration',

      style: TextStyle(
        fontSize: 16,

        fontWeight:
            FontWeight.bold,

        color:
            _pin.length == _maxPinLength
                ? Colors.white
                : const Color(0xFF747687),
      ),
    );
  }
}


