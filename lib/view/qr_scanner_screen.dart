
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:smartcanteen/service/api_service.dart';
import 'package:smartcanteen/view/transfer_point_screen.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key, String? qrData});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  final MobileScannerController controller = MobileScannerController();
  final ImagePicker picker = ImagePicker();
  final ApiService _apiService = ApiService();

  File? pickedImage;
  bool isFlashOn = false;
  bool isProcessing = false;

  /// Utility to extract query payload (UCSTT pattern or Digit pattern)
  String? _parseQrPayload(String rawValue) {
    // 1. Check for 'UCSTT' pattern
    final ucsttIndex = rawValue.indexOf('UCSTT');
    if (ucsttIndex != -1) {
      return rawValue.substring(ucsttIndex);
    }

    // 2. Check for numeric digits pattern
    final digitRegExp = RegExp(r'\d+');
    final match = digitRegExp.firstMatch(rawValue);
    if (match != null) {
      return rawValue.substring(match.start);
    }

    return null;
  }

  /// Process raw QR string value
  Future<void> _processQrCode(String rawValue) async {
    if (isProcessing) return;

    final parsedPayload = _parseQrPayload(rawValue);
    if (parsedPayload == null || parsedPayload.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("QR Code မမှန်ကန်ပါ။")),
      );
      return;
    }

    setState(() {
      isProcessing = true;
    });

    // Pause scanner camera during API request
    controller.stop();

    // Fetch user data via API call
    RecipientModel? recipient = await _apiService.getUserByQr(parsedPayload);

    if (!mounted) return;

    setState(() {
      isProcessing = false;
    });

   if (recipient != null) {
  debugPrint("================= RECIPIENT DATA =================");
  debugPrint("User ID : ${recipient.userId}");
  debugPrint("Name    : ${recipient.name}");
  debugPrint("Phone   : ${recipient.phone}");
  debugPrint("Role    : ${recipient.role}");
  debugPrint("==================================================");

  // Navigate using GoRouter passing the recipient model via extra
  context.pushReplacement('/transfer-point', extra: recipient);
} else {
  debugPrint("❌ Failed to fetch user data for payload: $parsedPayload");
  controller.start(); // Resume camera scanning on failure
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("အသုံးပြုသူ အချက်အလက် ရှာမတွေ့ပါ။")),
  );
}
  }

  // Camera QR Scan
  void onDetect(BarcodeCapture capture) {
    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty && !isProcessing) {
      final value = barcodes.first.rawValue;
      if (value != null && value.isNotEmpty) {
        _processQrCode(value);
      }
    }
  }

  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final compressedFile = await FlutterImageCompress.compressAndGetFile(
      image.path,
      "${Directory.systemTemp.path}/qr_image.jpg",
      quality: 80,
      format: CompressFormat.jpeg,
    );

    if (compressedFile == null) return;

    setState(() {
      pickedImage = File(compressedFile.path);
    });

    try {
      final BarcodeCapture? result = await controller.analyzeImage(compressedFile.path);
      if (result != null && result.barcodes.isNotEmpty) {
        final value = result.barcodes.first.rawValue;
        if (value != null && value.isNotEmpty) {
          _processQrCode(value);
        }
      }
    } catch (e) {
      debugPrint("QR Scan Error: $e");
    }
  }

  Future<void> toggleFlash() async {
    await controller.toggleTorch();
    setState(() {
      isFlashOn = !isFlashOn;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: const Text(
    "Scan QR Code",
    style: TextStyle(color: Colors.white),
  ),
  backgroundColor: const Color(0xff0D6B80),
  iconTheme: const IconThemeData(
    color: Colors.white, // Makes all AppBar icons white
  ),
  leading: IconButton(
    onPressed: () => context.pop(),
    icon: const Icon(Icons.arrow_back_ios_new_rounded),
  ),
),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (pickedImage != null)
                        Image.file(
                          pickedImage!,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        )
                      else
                        MobileScanner(
                          controller: controller,
                          onDetect: onDetect,
                        ),

                      // BIGGER QR Frame Overlay
                      LayoutBuilder(
                        builder: (context, constraints) {
                          // Takes 75% of screen width (clamped between 290px and 360px)
                          final scanSize = (constraints.maxWidth * 0.75).clamp(290.0, 360.0);

                          return Container(
                            width: scanSize,
                            height: scanSize,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 3),
                              borderRadius: BorderRadius.circular(24),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 90,
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: toggleFlash,
                        icon: Icon(isFlashOn ? Icons.flash_on : Icons.flash_off),
                        label: Text(isFlashOn ? "Light On" : "Light"),
                      ),
                      ElevatedButton.icon(
                        onPressed: pickImage,
                        icon: const Icon(Icons.photo),
                        label: const Text("Album"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (isProcessing)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:go_router/go_router.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:smartcanteen/service/api_service.dart';
// import 'package:smartcanteen/view/transfer_point_screen.dart';

// class QrScannerScreen extends StatefulWidget {
//   const QrScannerScreen({super.key});

//   @override
//   State<QrScannerScreen> createState() => _QrScannerScreenState();
// }

// class _QrScannerScreenState extends State<QrScannerScreen>
//     with SingleTickerProviderStateMixin {
//   final MobileScannerController controller = MobileScannerController();
//   final ImagePicker picker = ImagePicker();
//   final ApiService _apiService = ApiService();

//   late AnimationController _animationController;

//   File? pickedImage;
//   bool isFlashOn = false;
//   bool isProcessing = false;

//   @override
//   void initState() {
//     super.initState();
//     // Laser scanning animation controller
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     )..repeat(reverse: true);
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     controller.dispose();
//     super.dispose();
//   }

//   /// Utility to extract query payload (UCSTT pattern or Digit pattern)
//   String? _parseQrPayload(String rawValue) {
//     final ucsttIndex = rawValue.indexOf('UCSTT');
//     if (ucsttIndex != -1) {
//       return rawValue.substring(ucsttIndex);
//     }

//     final digitRegExp = RegExp(r'\d+');
//     final match = digitRegExp.firstMatch(rawValue);
//     if (match != null) {
//       return rawValue.substring(match.start);
//     }

//     return null;
//   }

//   /// Process raw QR string value
//   Future<void> _processQrCode(String rawValue) async {
//     if (isProcessing) return;

//     final parsedPayload = _parseQrPayload(rawValue);
//     if (parsedPayload == null || parsedPayload.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("QR Code မမှန်ကန်ပါ။")),
//       );
//       return;
//     }

//     setState(() {
//       isProcessing = true;
//     });

//     // Pause scanner camera during API request
//     controller.stop();

//     // Fetch user data via API call
//     RecipientModel? recipient = await _apiService.getUserByQr(parsedPayload);

//     if (!mounted) return;

//     setState(() {
//       isProcessing = false;
//     });

//     if (recipient != null) {
//       context.pushReplacement('/transfer-point', extra: recipient);
//     } else {
//       controller.start(); // Resume camera scanning on failure
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("အသုံးပြုသူ အချက်အလက် ရှာမတွေ့ပါ။")),
//       );
//     }
//   }

//   // Camera QR Scan
//   void onDetect(BarcodeCapture capture) {
//     final List<Barcode> barcodes = capture.barcodes;
//     if (barcodes.isNotEmpty && !isProcessing) {
//       final value = barcodes.first.rawValue;
//       if (value != null && value.isNotEmpty) {
//         _processQrCode(value);
//       }
//     }
//   }

//   // Pick Image from Gallery / Album
//   Future<void> pickImage() async {
//     final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//     if (image == null) return;

//     final compressedFile = await FlutterImageCompress.compressAndGetFile(
//       image.path,
//       "${Directory.systemTemp.path}/qr_image.jpg",
//       quality: 80,
//       format: CompressFormat.jpeg,
//     );

//     if (compressedFile == null) return;

//     setState(() {
//       pickedImage = File(compressedFile.path);
//     });

//     try {
//       final BarcodeCapture? result =
//           await controller.analyzeImage(compressedFile.path);
//       if (result != null && result.barcodes.isNotEmpty) {
//         final value = result.barcodes.first.rawValue;
//         if (value != null && value.isNotEmpty) {
//           _processQrCode(value);
//         }
//       }
//     } catch (e) {
//       debugPrint("QR Scan Error: $e");
//     }
//   }

//   // Flashlight toggle
//   Future<void> toggleFlash() async {
//     await controller.toggleTorch();
//     setState(() {
//       isFlashOn = !isFlashOn;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     final double scanSize = screenSize.width * 0.72; // Frame size

//     final scanRect = Rect.fromCenter(
//       center: Offset(screenSize.width / 2, screenSize.height * 0.42),
//       width: scanSize,
//       height: scanSize,
//     );

//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           /// 1. REAL CAMERA SCANNER / PICKED IMAGE VIEW
//           if (pickedImage != null)
//             Positioned.fill(
//               child: Image.file(
//                 pickedImage!,
//                 fit: BoxFit.contain,
//               ),
//             )
//           else
//             MobileScanner(
//               controller: controller,
//               onDetect: onDetect,
//             ),

//           /// 2. WHITE OVERLAY WITH CUTOUT & BORDER
//           CustomPaint(
//             size: screenSize,
//             painter: ScannerOverlayPainter(scanRect: scanRect),
//           ),

//           /// 3. SCANNING LASER ANIMATION
//           if (pickedImage == null)
//             AnimatedBuilder(
//               animation: _animationController,
//               builder: (context, child) {
//                 final double topOffset = scanRect.top +
//                     (_animationController.value * (scanRect.height - 4));

//                 return Positioned(
//                   top: topOffset,
//                   left: scanRect.left + 12,
//                   width: scanRect.width - 24,
//                   child: Container(
//                     height: 3,
//                     decoration: BoxDecoration(
//                       color: const Color(0xff117992),
//                       borderRadius: BorderRadius.circular(2),
//                       boxShadow: [
//                         BoxShadow(
//                           color: const Color(0xff117992).withOpacity(0.8),
//                           blurRadius: 8,
//                           spreadRadius: 2,
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),

//           /// 4. TOP APP BAR
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               child: Row(
//                 children: [
//                   GestureDetector(
//                     onTap: () => context.go('/navigation'),
//                     child: const Icon(
//                       Icons.arrow_back_ios_new_rounded,
//                       color: Colors.white,
//                       size: 22,
//                     ),
//                   ),
//                   const Expanded(
//                     child: Text(
//                       "Scan QR Code",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 22),
//                 ],
//               ),
//             ),
//           ),

//           /// 5. BOTTOM BUTTONS (Light & Album)
//           Positioned(
//             bottom: 40,
//             left: 0,
//             right: 0,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 _ActionButton(
//                   icon: isFlashOn ? Icons.flash_on_rounded : Icons.flash_off_rounded,
//                   label: isFlashOn ? "Light On" : "Light",
//                   onTap: toggleFlash,
//                 ),
//                 const SizedBox(width: 20),
//                 _ActionButton(
//                   icon: Icons.photo_library_rounded,
//                   label: "Album",
//                   onTap: pickImage,
//                 ),
//               ],
//             ),
//           ),

//           /// 6. LOADING OVERLAY
//           if (isProcessing)
//             Container(
//               color: Colors.black.withOpacity(0.5),
//               child: const Center(
//                 child: CircularProgressIndicator(color: Colors.white),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// class _ActionButton extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final VoidCallback onTap;

//   const _ActionButton({
//     required this.icon,
//     required this.label,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//         decoration: BoxDecoration(
//           color: Colors.white.withOpacity(0.9),
//           borderRadius: BorderRadius.circular(30),
//         ),
//         child: Row(
//           children: [
//             Icon(icon, color: const Color(0xff117992), size: 20),
//             const SizedBox(width: 8),
//             Text(
//               label,
//               style: const TextStyle(
//                 color: Color(0xff117992),
//                 fontWeight: FontWeight.bold,
//                 fontSize: 14,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ScannerOverlayPainter extends CustomPainter {
//   final Rect scanRect;
//   final double borderRadius;

//   ScannerOverlayPainter({
//     required this.scanRect,
//     this.borderRadius = 24.0,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     final backgroundPath = Path()
//       ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

//     final cutoutPath = Path()
//       ..addRRect(
//         RRect.fromRectAndRadius(
//           scanRect,
//           Radius.circular(borderRadius),
//         ),
//       );

//     final overlayPath = Path.combine(
//       PathOperation.difference,
//       backgroundPath,
//       cutoutPath,
//     );

//     // Outside background color (adjust opacity for solid/semi-transparent white)
//     final overlayPaint = Paint()
//       ..color = Colors.white.withOpacity(0.65)
//       ..style = PaintingStyle.fill;

//     canvas.drawPath(overlayPath, overlayPaint);

//     // Rounded White Border
//     final borderPaint = Paint()
//       ..color = Colors.white
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 3.5;

//     canvas.drawRRect(
//       RRect.fromRectAndRadius(scanRect, Radius.circular(borderRadius)),
//       borderPaint,
//     );
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }