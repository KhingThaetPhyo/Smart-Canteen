
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';


// class QrScannerScreen extends StatefulWidget {
//   const QrScannerScreen({super.key});

//   @override
//   State<QrScannerScreen> createState() => _QrScannerScreenState();
// }


// class _QrScannerScreenState extends State<QrScannerScreen> {

//   final MobileScannerController controller =
//       MobileScannerController();

//   final ImagePicker picker = ImagePicker();


//   File? pickedImage;

//   bool isFlashOn = false;

//   String qrResult = "";


//   // Camera QR Scan
//   void onDetect(BarcodeCapture capture) {

//     final List<Barcode> barcodes = capture.barcodes;

//     if(barcodes.isNotEmpty){

//       final value = barcodes.first.rawValue;

//       if(value != null){

//         setState(() {
//           qrResult = value;
//         });

//       }
//     }

//   }

// Future<void> pickImage() async {

//   final XFile? image =
//       await picker.pickImage(
//         source: ImageSource.gallery,
//       );


//   if(image == null) return;


//   // Compress image
//   final compressedFile =
//       await FlutterImageCompress.compressAndGetFile(
//         image.path,
//         "${Directory.systemTemp.path}/qr_image.jpg",
//         quality: 80,
//         format: CompressFormat.jpeg,
//       );


//   if(compressedFile == null) return;


//   setState(() {

//     pickedImage = File(compressedFile.path);

//   });



//   try {

//     final BarcodeCapture? result =
//         await controller.analyzeImage(
//           compressedFile.path,
//         );


//     if(result != null &&
//        result.barcodes.isNotEmpty){


//       setState(() {

//         qrResult =
//           result.barcodes.first.rawValue ?? "";

//       });


//     }


//   } catch(e){

//     debugPrint(
//       "QR Scan Error: $e",
//     );

//   }

// }

//   // Flash control
//   Future<void> toggleFlash() async {

//     await controller.toggleTorch();

//     setState(() {

//       isFlashOn = !isFlashOn;

//     });

//   }



//   @override
//   void dispose(){

//     controller.dispose();

//     super.dispose();

//   }



//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(

//       appBar: AppBar(
//         title: const Text(
//           "Scan QR Code",
//         ),
//       ),


//       body: Column(

//         children: [


//           Expanded(

//             child: Stack(

//               alignment: Alignment.center,

//               children: [


//                 // Show picked image
//                 if(pickedImage != null)

//                   Image.file(

//                     pickedImage!,

//                     width: double.infinity,

//                     fit: BoxFit.contain,

//                   )


//                 else


//                   MobileScanner(

//                     controller: controller,

//                     onDetect: onDetect,

//                   ),



//                 // QR Scanner border

//                 Container(

//                   width: 230,

//                   height: 230,

//                   decoration: BoxDecoration(

//                     border: Border.all(

//                       color: Colors.white,

//                       width: 3,

//                     ),

//                     borderRadius:
//                     BorderRadius.circular(20),

//                   ),

//                 ),


//               ],

//             ),

//           ),



//           if(qrResult.isNotEmpty)

//             Padding(

//               padding: const EdgeInsets.all(10),

//               child: Text(

//                 "Result: $qrResult",

//                 style: const TextStyle(

//                   fontSize: 16,

//                   fontWeight: FontWeight.bold,

//                 ),

//               ),

//             ),



//           // Bottom buttons

//           Container(

//             height: 90,

//             padding: const EdgeInsets.all(15),

//             child: Row(

//               mainAxisAlignment:
//               MainAxisAlignment.spaceEvenly,

//               children: [


//                 // Flash

//                 ElevatedButton.icon(

//                   onPressed: toggleFlash,

//                   icon: Icon(

//                     isFlashOn

//                         ? Icons.flash_on

//                         : Icons.flash_off,

//                   ),

//                   label: Text(

//                     isFlashOn

//                         ? "Light On"

//                         : "Light",

//                   ),

//                 ),



//                 // Album

//                 ElevatedButton.icon(

//                   onPressed: pickImage,

//                   icon: const Icon(

//                     Icons.photo,

//                   ),

//                   label: const Text(

//                     "Album",

//                   ),

//                 ),


//               ],

//             ),

//           ),


//         ],

//       ),

//     );

//   }

// }
import 'package:flutter/material.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  static const Color primaryColor = Color(0xff117992);
  bool isFlashOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          /// SIMULATED CAMERA VIEWFINDER BACKDROP
          Container(
            color: const Color(0xff0F172A),
            child: Center(
              child: Icon(
                Icons.camera_alt_outlined,
                size: 80,
                color: Colors.white.withOpacity(0.08),
              ),
            ),
          ),

          /// RETICLE VIEWPORT OVERLAY
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    /// TARGET SCAN AREA
                    Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: primaryColor.withOpacity(0.6),
                          width: 2,
                        ),
                      ),
                    ),

                    /// CORNER RETICLE ACCENTS
                    SizedBox(
                      width: 260,
                      height: 260,
                      child: CustomPaint(
                        painter: ScannerCornerPainter(color: primaryColor),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                Text(
                  "Align QR code within the frame to pay",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          /// TOP BAR WITH CONTROLS
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// SCREEN LABEL
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.qr_code_scanner_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Scan Canteen QR",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                /// FLASH TOGGLE
                IconButton(
                  onPressed: () {
                    setState(() {
                      isFlashOn = !isFlashOn;
                    });
                  },
                  icon: Icon(
                    isFlashOn
                        ? Icons.flash_on_rounded
                        : Icons.flash_off_rounded,
                    color: isFlashOn ? Colors.amber : Colors.white,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black.withOpacity(0.4),
                  ),
                ),
              ],
            ),
          ),

          /// BOTTOM GALLERY PICKER ACTION
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  // Action for picking QR image from gallery
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.25)),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.photo_library_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Upload from Gallery",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// CUSTOM PAINTER FOR RETICLE CORNERS
class ScannerCornerPainter extends CustomPainter {
  final Color color;

  ScannerCornerPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const cornerLength = 24.0;

    // Top Left
    canvas.drawPath(
      Path()
        ..moveTo(0, cornerLength)
        ..lineTo(0, 0)
        ..lineTo(cornerLength, 0),
      paint,
    );

    // Top Right
    canvas.drawPath(
      Path()
        ..moveTo(size.width - cornerLength, 0)
        ..lineTo(size.width, 0)
        ..lineTo(size.width, cornerLength),
      paint,
    );

    // Bottom Left
    canvas.drawPath(
      Path()
        ..moveTo(0, size.height - cornerLength)
        ..lineTo(0, size.height)
        ..lineTo(cornerLength, size.height),
      paint,
    );

    // Bottom Right
    canvas.drawPath(
      Path()
        ..moveTo(size.width - cornerLength, size.height)
        ..lineTo(size.width, size.height)
        ..lineTo(size.width, size.height - cornerLength),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}