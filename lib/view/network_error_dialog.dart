// import 'dart:ui';
// import 'package:flutter/material.dart';

// void showNetworkErrorDialog(BuildContext context, VoidCallback onRetry) {
//   showDialog(
//     context: context,
//     barrierDismissible: false, // Prevents closing without clicking retry
//     barrierColor: Colors.black.withOpacity(0.3), // Darkened overlay under the blur
//     builder: (context) => NetworkErrorDialog(onRetry: onRetry),
//   );
// }
// class NetworkErrorDialog extends StatelessWidget {
//   final VoidCallback onRetry;

//   const NetworkErrorDialog({super.key, required this.onRetry});

//   @override
//   Widget build(BuildContext context) {
//     return BackdropFilter(
//       // 1. Applies the background blur effect
//       filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
//       child: Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20.0),
//         ),
//         elevation: 0,
//         backgroundColor: Colors.white,
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // Error Icon
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: const BoxDecoration(
//                   color: Color(0xffFEE2E2),
//                   shape: BoxShape.circle,
//                 ),
//                 child: const Icon(
//                   Icons.wifi_off_rounded,
//                   color: Color(0xffEF4444),
//                   size: 36,
//                 ),
//               ),
//               const SizedBox(height: 16),

//               // Title
//               const Text(
//                 "ချိတ်ဆက်၍ မရပါ",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xff1E293B),
//                 ),
//               ),
//               const SizedBox(height: 8),

//               // Description
//               Text(
//                 "Server နှင့် ချိတ်ဆက်ရာတွင် အဆင်မပြေပါ။ ကျေးဇူးပြု၍ အင်တာနက် ချိတ်ဆက်မှုကို စစ်ဆေးပြီး ပြန်လည် ကြိုးစားပါ။",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 13,
//                   color: Colors.grey.shade600,
//                   height: 1.4,
//                 ),
//               ),
//               const SizedBox(height: 24),

//               // Retry Button
//               SizedBox(
//                 width: double.infinity,
//                 height: 44,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).pop(); // Close dialog
//                     onRetry(); // Trigger retry action
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xff117992),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     elevation: 0,
//                   ),
//                   child: const Text(
//                     "ပြန်လည်ကြိုးစားမည်",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }