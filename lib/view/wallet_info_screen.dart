

// import 'dart:convert';
// import 'dart:ui';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:smartcanteen/model/user_model.dart';
// import 'package:smartcanteen/service/api_service.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:smartcanteen/service/secure_storage_service.dart';
// import 'package:smartcanteen/service/shared_preferences_service.dart';

// class WalletInfoScreen extends StatefulWidget {
//   final UserModel user;

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
//     // 6 လုံးပြည့်ပါက ထပ်မံရိုက်နှိပ်၍ မရအောင် ခွင့်ပြုထားပါသည်
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

//   void _showRegistrationFailedDialog(BuildContext context, String message) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (_) {
//         return Dialog(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           child: Container(
//             width: 300,
//             padding: const EdgeInsets.all(22),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(30),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(.08),
//                   blurRadius: 30,
//                   spreadRadius: 5,
//                   offset: const Offset(0, 15),
//                 ),
//               ],
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 /// Emoji
//                 Container(
//                   width: 90,
//                   height: 90,
//                   decoration: BoxDecoration(
//                     color: Colors.yellow.shade300,
//                     shape: BoxShape.circle,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.yellow.withOpacity(.5),
//                         blurRadius: 20,
//                       ),
//                     ],
//                   ),
//                   child: const Center(
//                     child: Text("☹️", style: TextStyle(fontSize: 48)),
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 const Text(
//                   "အကောင့်ဖွင့်ခြင်း မအောင်မြင်ပါ!",
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xff2E3A59),
//                   ),
//                 ),

//                 const SizedBox(height: 10),

//                 Text(
//                   message,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(color: Colors.grey, fontSize: 15),
//                 ),

//                 const SizedBox(height: 30),

//                 Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(25),
//                     gradient: const LinearGradient(
//                       colors: [Color(0xff64B5F6), Color(0xff1976D2)],
//                     ),
//                   ),
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.transparent,
//                       shadowColor: Colors.transparent,
//                       minimumSize: const Size(double.infinity, 48),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                     ),
//                     onPressed: () {
//                       Navigator.pop(context);
//                       context.go("/register");
//                     },
//                     child: const Text(
//                       "လက်ခံသည်",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void _handleComplete() async {
//     print("========== HANDLE COMPLETE ==========");
//     print("PIN: $_pin");
//     print("Length: ${_pin.length}");
//     print("Loading: $_isLoading");
//     print("Success: $_isSuccess");
//     print("====================================");

//     if (_pin.length == _maxPinLength && !_isLoading && !_isSuccess) {
//       print("Entered _handleComplete");
//       print("Calling registerUser");

//       setState(() {
//         _isLoading = true;
//       });
//       try {
//         String? fcmToken = await FirebaseMessaging.instance.getToken();

//         print("====================================");
//         print("User Device FCM Token:");
//         print(fcmToken);
//         print("====================================");

//         final result = await ApiService().registerUser(
//           name: widget.user.userName,
//           email: widget.user.userEmail,
//           phone: widget.user.userPhone,
//           password: widget.user.userPassword ?? "",
//           role: widget.user.roleName,
//           studentId: widget.user.student?.studentId,
//           semester: widget.user.student?.semester,
//           academicYear: widget.user.student?.academicYear,
//           yearLevel: widget.user.student?.yearLevel,
//           walletPin: _pin,
//           fcmToken: fcmToken,
//         );
//         setState(() {
//           _isLoading = false;
//         });

//         // Registration Success
//         if (result != null && result.success) {
//           setState(() {
//             _isSuccess = true;
//           });

//           if (result.user != null) {
//             await SharedPreferencesService.saveUser(result.user!);
//           }

//           if (result.token != null) {
//             await SecureStorageService.saveToken(result.token!);
//           }

//           if (result.user?.fcmToken != null) {
//             await SecureStorageService.saveFcmToken(result.user!.fcmToken!);
//           }

//           if (!mounted) return;
//         final userName = result.user?.userName ?? '';
//         final studentId = result.user?.student?.studentId ?? '';
        
//         // Combine them with a space (or format them however you need)
//         final qrData = '$userName $studentId'.trim();
//           print("User QR Data -------  {$qrData}");
//           await SecureStorageService.saveQrData(qrData);
//           final savedQr = await SecureStorageService.getQrData();

//           print("========== QR STORAGE ==========");
//           print(savedQr);
//           print("================================");

//           context.go('/navigation', extra: qrData);
//         } else {
//           if (!mounted) return;

//           _showRegistrationFailedDialog(
//             context,
//             result?.message ?? "အကောင့်ဖွင့်ခြင်း မအောင်မြင်ပါ။",
//           );
//         }
//       } catch (e) {
//         setState(() {
//           _isLoading = false;
//         });

//         if (!mounted) return;

//         _showRegistrationFailedDialog(context, e.toString());
//       }
//     } else {
//       print("Condition Failed");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {
//             context.go("/register");
//           },
//         ),
//         shadowColor: Colors.transparent,
//         elevation: 0,
//         surfaceTintColor: Colors.transparent,
//         backgroundColor: Color(0xFFF7F9FE),
//       ),

//       body: SafeArea(
//         child: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [Color(0xFFF7F9FE), Color(0xFFECEEF3), Color(0xFFD3E5F2)],
//               stops: [0.0, 0.6, 1.0],
//             ),
//           ),
        
//           child: Stack(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: const Color(0xFFB7EAFF).withOpacity(0.3),
//                 ),
        
//                 child: BackdropFilter(
//                   filter: ImageFilter.blur(sigmaX: 120, sigmaY: 120),
        
//                   child: const SizedBox.shrink(),
//                 ),
//               ),
        
//               LayoutBuilder(
//                 builder: (context, constraints) {
//                   final bool isShortScreen = constraints.maxHeight < 720;
              
//                   return Column(
//                     children: [
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 24.0),
              
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
              
//                             children: [
//                               Center(
//                                 child: Stack(
//                                   alignment: Alignment.center,
              
//                                   children: [
//                                     Container(
//                                       width: isShortScreen ? 90 : 130,
              
//                                       height: isShortScreen ? 90 : 130,
              
//                                       decoration: BoxDecoration(
//                                         color: const Color(
//                                           0xff0D6B80,
//                                         ).withOpacity(0.04),
              
//                                         shape: BoxShape.circle,
//                                       ),
//                                     ),
              
//                                     ClipRRect(
//                                       borderRadius: BorderRadius.circular(
//                                         isShortScreen ? 24 : 36,
//                                       ),
              
//                                       child: BackdropFilter(
//                                         filter: ImageFilter.blur(
//                                           sigmaX: 20,
//                                           sigmaY: 20,
//                                         ),
              
//                                         child: Container(
//                                           width: isShortScreen ? 76 : 110,
              
//                                           height: isShortScreen ? 76 : 110,
              
//                                           decoration: BoxDecoration(
//                                             color: Colors.white.withOpacity(
//                                               0.65,
//                                             ),
              
//                                             borderRadius: BorderRadius.circular(
//                                               isShortScreen ? 24 : 36,
//                                             ),
              
//                                             border: Border.all(
//                                               color: const Color(
//                                                 0xff0D6B80,
//                                               ).withOpacity(0.15),
              
//                                               width: 1.5,
//                                             ),
              
//                                             boxShadow: [
//                                               BoxShadow(
//                                                 color: const Color(
//                                                   0xff0D6B80,
//                                                 ).withOpacity(0.06),
              
//                                                 blurRadius: 32,
              
//                                                 offset: const Offset(0, 8),
//                                               ),
//                                             ],
//                                           ),
              
//                                           padding: EdgeInsets.all(
//                                             isShortScreen ? 16 : 22,
//                                           ),
              
//                                           child: FittedBox(
//                                             fit: BoxFit.contain,
              
//                                             child: Icon(
//                                               Icons.lock_outline_rounded,
              
//                                               color: const Color(0xff0D6B80),
              
//                                               size: isShortScreen ? 32 : 44,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
              
//                               // const Spacer(flex: 2),
//                               // Text(
//                               //   'ပိုက်ဆံအိတ်အား လုံခြုံစွာထားပါ',
//                               //   textAlign: TextAlign.center,
//                               //   style: TextStyle(
//                               //     fontSize: isShortScreen ? 20 : 22,
//                               //     fontWeight: FontWeight.w600,
//                               //     color: const Color(0xFF181C20),
//                               //     letterSpacing: -0.5,
//                               //   ),
//                               // ),
//                               const SizedBox(height: 6),
              
//                               SizedBox(
//                                 width: 280,
//                                 child: Text(
//                                   'ငွေပေးချေမှုများပြုလုပ်ရန်အတွက် ၆ လုံးပါ PIN နံပါတ်တစ်ခု ဖန်တီးပါ။',
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     fontSize: isShortScreen ? 14 : 15,
//                                     height: 1.4,
//                                     color: const Color(0xff0D6B80),
//                                   ),
//                                 ),
//                               ),
              
//                               const Spacer(flex: 3),
              
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
              
//                                 children: List.generate(_maxPinLength, (index) {
//                                   bool isActive = index < _pin.length;
              
//                                   return AnimatedContainer(
//                                     duration: const Duration(milliseconds: 200),
              
//                                     margin: const EdgeInsets.symmetric(
//                                       horizontal: 8,
//                                     ),
              
//                                     width: isShortScreen ? 12 : 14,
              
//                                     height: isShortScreen ? 12 : 14,
              
//                                     decoration: BoxDecoration(
//                                       shape: BoxShape.circle,
              
//                                       color: isActive
//                                           ? const Color(0xff0D6B80)
//                                           : Colors.white.withOpacity(0.4),
              
//                                       border: Border.all(
//                                         color: isActive
//                                             ? const Color(0xff0D6B80)
//                                             : const Color(
//                                                 0xFF747687,
//                                               ).withOpacity(0.3),
              
//                                         width: 1,
//                                       ),
              
//                                       boxShadow: isActive
//                                           ? [
//                                               BoxShadow(
//                                                 color: const Color(
//                                                   0xff0D6B80,
//                                                 ).withOpacity(0.4),
              
//                                                 blurRadius: 5,
//                                               ),
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
              
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 24.0),
              
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
              
//                           children: [
//                             SizedBox(
//                               width: 260,
              
//                               child: GridView.builder(
//                                 shrinkWrap: true,
              
//                                 padding: EdgeInsets.zero,
              
//                                 physics: const NeverScrollableScrollPhysics(),
              
//                                 gridDelegate:
//                                     SliverGridDelegateWithFixedCrossAxisCount(
//                                       crossAxisCount: 3,
              
//                                       mainAxisSpacing: isShortScreen ? 12 : 18,
              
//                                       crossAxisSpacing: isShortScreen ? 12 : 18,
              
//                                       childAspectRatio: 1,
//                                     ),
              
//                                 itemCount: 12,
              
//                                 itemBuilder: (context, index) {
//                                   if (index == 9) {
//                                     return const SizedBox.shrink();
//                                   }
              
//                                   if (index == 11) {
//                                     return ElevatedButton(
//                                       onPressed: _deleteKey,
              
//                                       child: const Icon(
//                                         Icons.backspace_outlined,
              
//                                         size: 20,
              
//                                         color: Color(0xff0D6B80),
//                                       ),
//                                     );
//                                   }
              
//                                   String keyText = index == 10
//                                       ? "0"
//                                       : "${index + 1}";
              
//                                   return ElevatedButton(
//                                     onPressed: () => _pressKey(keyText),
              
//                                     child: Text(
//                                       keyText,
              
//                                       style: const TextStyle(
//                                         fontSize: 22,
              
//                                         fontWeight: FontWeight.bold,
              
//                                         color: Color(0xff0D6B80),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
              
//                             SizedBox(height: isShortScreen ? 16 : 28),
              
//                             Padding(
//                               padding: const EdgeInsets.only(bottom: 16),
              
//                               child: SizedBox(
//                                 width: double.infinity,
              
//                                 height: isShortScreen ? 54 : 60,
              
//                                 child: ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor:
//                                         _pin.length == _maxPinLength
//                                         ? const Color(0xff0D6B80)
//                                         : Colors.grey.shade300,
//                                     disabledBackgroundColor:
//                                         Colors.grey.shade300,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(30),
//                                     ),
//                                   ),
//                                   onPressed: (_pin.length == _maxPinLength)
//                                       ? _handleComplete
//                                       : null,
              
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
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildButtonContent() {
//     if (_isLoading) {
//       return const SizedBox(
//         width: 24,
//         height: 24,

//         child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
//       );
//     }

//     if (_isSuccess) {
//       return const Row(
//         mainAxisAlignment: MainAxisAlignment.center,

//         children: [
//           Icon(Icons.check_circle, color: Colors.white),

//           SizedBox(width: 8),

//           Text(
//             'PIN သတ်မှတ်မှု အောင်မြင်ပါသည်',

//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//         ],
//       );
//     }

//     return Text(
//       'အကောင့်ဖွင့်ခြင်း ပြီးစီးပါပြီ',

//       style: TextStyle(
//         fontSize: 16,

//         fontWeight: FontWeight.bold,

//         color: _pin.length == _maxPinLength
//             ? Colors.white
//             : const Color(0xFF747687),
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
import 'package:smartcanteen/service/shared_preferences_service.dart';

class WalletInfoScreen extends StatefulWidget {
  final UserModel user;

  const WalletInfoScreen({super.key, required this.user});

  @override
  State<WalletInfoScreen> createState() => _WalletInfoScreenState();
}

class _WalletInfoScreenState extends State<WalletInfoScreen> {
  String _pin = "";
  final int _maxPinLength = 6;

  bool _isLoading = false;
  bool _isSuccess = false;

  void _pressKey(String num) {
    if (_pin.length < _maxPinLength && !_isLoading && !_isSuccess) {
      setState(() {
        _pin += num;
      });
    }
  }

  void _deleteKey() {
    if (_pin.isNotEmpty && !_isLoading && !_isSuccess) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
      });
    }
  }

  void _showRegistrationFailedDialog(BuildContext context, String message) {
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
                    child: Text("☹️", style: TextStyle(fontSize: 48)),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "အကောင့်ဖွင့်ခြင်း မအောင်မြင်ပါ!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff2E3A59),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey, fontSize: 15),
                ),
                const SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: const LinearGradient(
                      colors: [Color(0xff64B5F6), Color(0xff1976D2)],
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
                      "လက်ခံသည်",
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
    if (_pin.length == _maxPinLength && !_isLoading && !_isSuccess) {
      setState(() {
        _isLoading = true;
      });
      try {
        String? fcmToken = await FirebaseMessaging.instance.getToken();

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
          fcmToken: fcmToken,
        );
        setState(() {
          _isLoading = false;
        });

        if (result != null && result.success) {
          setState(() {
            _isSuccess = true;
          });

          if (result.user != null) {
            await SharedPreferencesService.saveUser(result.user!);
          }

          if (result.token != null) {
            await SecureStorageService.saveToken(result.token!);
          }

          if (result.user?.fcmToken != null) {
            await SecureStorageService.saveFcmToken(result.user!.fcmToken!);
          }

          if (!mounted) return;
          final userName = result.user?.userName ?? '';
          final studentId = result.user?.student?.studentId ?? result.user?.userId;
          final qrData = '$userName $studentId'.trim();
          
          await SecureStorageService.saveQrData(qrData);
          context.go('/navigation', extra: qrData);
        } else {
          if (!mounted) return;
          _showRegistrationFailedDialog(
            context,
            result?.message ?? "အကောင့်ဖွင့်ခြင်း မအောင်မြင်ပါ။",
          );
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });

        if (!mounted) return;
        _showRegistrationFailedDialog(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back, color: Colors.black),
      //     onPressed: () {
      //       context.go("/register");
      //     },
      //   ),
      //   shadowColor: Colors.transparent,
      //   elevation: 0,
      //   surfaceTintColor: Colors.transparent,
      //   backgroundColor: const Color(0xFFF7F9FE),
      // ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF7F9FE), Color(0xFFECEEF3), Color(0xFFD3E5F2)],
            stops: [0.0, 0.6, 1.0],
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFB7EAFF).withOpacity(0.3),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 120, sigmaY: 120),
                  child: const SizedBox.shrink(),
                ),
              ),
            ),
            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final bool isShortScreen = constraints.maxHeight < 720;

                  return SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Lock Icon Container
                            Center(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: isShortScreen ? 80 : 110,
                                    height: isShortScreen ? 80 : 110,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff0D6B80).withOpacity(0.04),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(isShortScreen ? 20 : 32),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                                      child: Container(
                                        width: isShortScreen ? 68 : 95,
                                        height: isShortScreen ? 68 : 95,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.65),
                                          borderRadius: BorderRadius.circular(isShortScreen ? 20 : 32),
                                          border: Border.all(
                                            color: const Color(0xff0D6B80).withOpacity(0.15),
                                            width: 1.5,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xff0D6B80).withOpacity(0.06),
                                              blurRadius: 32,
                                              offset: const Offset(0, 8),
                                            ),
                                          ],
                                        ),
                                        padding: EdgeInsets.all(isShortScreen ? 14 : 18),
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Icon(
                                            Icons.lock_outline_rounded,
                                            color: const Color(0xff0D6B80),
                                            size: isShortScreen ? 28 : 38,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: 280,
                              child: Text(
                                'ငွေပေးချေမှုများပြုလုပ်ရန်အတွက် ၆ လုံးပါ PIN နံပါတ်တစ်ခု ဖန်တီးပါ။',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: isShortScreen ? 13 : 15,
                                  height: 1.4,
                                  color: const Color(0xff0D6B80),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            // PIN Dots
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(_maxPinLength, (index) {
                                bool isActive = index < _pin.length;
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  margin: const EdgeInsets.symmetric(horizontal: 6),
                                  width: isShortScreen ? 10 : 14,
                                  height: isShortScreen ? 10 : 14,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isActive
                                        ? const Color(0xff0D6B80)
                                        : Colors.white.withOpacity(0.4),
                                    border: Border.all(
                                      color: isActive
                                          ? const Color(0xff0D6B80)
                                          : const Color(0xFF747687).withOpacity(0.3),
                                      width: 1,
                                    ),
                                    boxShadow: isActive
                                        ? [
                                            BoxShadow(
                                              color: const Color(0xff0D6B80).withOpacity(0.4),
                                              blurRadius: 5,
                                            ),
                                          ]
                                        : [],
                                  ),
                                );
                              }),
                            ),
                            const SizedBox(height: 24),
                            // Keypad Grid
                            SizedBox(
                              width: 260,
                              child: GridView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: isShortScreen ? 8 : 14,
                                  crossAxisSpacing: isShortScreen ? 8 : 14,
                                  childAspectRatio: 1.2,
                                ),
                                itemCount: 12,
                                itemBuilder: (context, index) {
                                  if (index == 9) {
                                    return const SizedBox.shrink();
                                  }
                                  if (index == 11) {
                                    return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        elevation: 1,
                                      ),
                                      onPressed: _deleteKey,
                                      child: const Icon(
                                        Icons.backspace_outlined,
                                        size: 20,
                                        color: Color(0xff0D6B80),
                                      ),
                                    );
                                  }
                                  String keyText = index == 10 ? "0" : "${index + 1}";
                                  return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      elevation: 1,
                                    ),
                                    onPressed: () => _pressKey(keyText),
                                    child: Text(
                                      keyText,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff0D6B80),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 24),
                            // Action Button
                            SizedBox(
                              width: double.infinity,
                              height: isShortScreen ? 50 : 56,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _pin.length == _maxPinLength
                                      ? const Color(0xff0D6B80)
                                      : Colors.grey.shade300,
                                  disabledBackgroundColor: Colors.grey.shade300,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                onPressed: (_pin.length == _maxPinLength)
                                    ? _handleComplete
                                    : null,
                                child: _buildButtonContent(),
                              ),
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    ),
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
        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
      );
    }

    if (_isSuccess) {
      return const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle, color: Colors.white),
          SizedBox(width: 8),
          Text(
            'PIN သတ်မှတ်မှု အောင်မြင်ပါသည်',
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
      'အကောင့်ဖွင့်ခြင်း ပြီးစီးပါပြီ',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: _pin.length == _maxPinLength
            ? Colors.white
            : const Color(0xFF747687),
      ),
    );
  }
}