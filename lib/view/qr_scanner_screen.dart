// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';

// class QrScannerScreen extends StatefulWidget {
//   const QrScannerScreen({super.key});

//   @override
//   State<QrScannerScreen> createState() => _QrScannerScreenState();
// }

// class _QrScannerScreenState extends State<QrScannerScreen> {
//   final MobileScannerController controller = MobileScannerController();

//   bool isFlashOn = false;

//   Future<void> _pickFromGallery() async {
//     final ImagePicker picker = ImagePicker();

//     final XFile? image = await picker.pickImage(
//       source: ImageSource.gallery,
//     );

//     if (image != null) {
//       final BarcodeCapture? result =
//           await controller.analyzeImage(image.path);

//       if (result != null && result.barcodes.isNotEmpty) {
//         final String? code = result.barcodes.first.rawValue;

//         if (code != null && mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('QR Code: $code')),
//           );
//         }
//       } else if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('No QR code found in image'),
//           ),
//         );
//       }
//     }
//   }

//   Future<void> _toggleFlash() async {
//     await controller.toggleTorch();

//     setState(() {
//       isFlashOn = !isFlashOn;
//     });
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           // QR Scanner
//           MobileScanner(
//             controller: controller,
//             onDetect: (capture) {
//               final Barcode barcode = capture.barcodes.first;
//               final String? code = barcode.rawValue;

//               if (code != null) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('QR Code: $code')),
//                 );
//               }
//             },
//           ),

//           // Bottom buttons
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 30,
//                 vertical: 25,
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.black.withOpacity(0.5),
//                 borderRadius: const BorderRadius.vertical(
//                   top: Radius.circular(25),
//                 ),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   // Flash Light Button
//                   Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       GestureDetector(
//                         onTap: _toggleFlash,
//                         child: CircleAvatar(
//                           radius: 28,
//                           backgroundColor: Colors.white,
//                           child: Icon(
//                             isFlashOn
//                                 ? Icons.flash_on
//                                 : Icons.flash_off,
//                             color: Colors.black,
//                             size: 28,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         isFlashOn ? 'Light On' : 'Light',
//                         style: const TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),

//                   // Album/Gallery Button
//                   Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       GestureDetector(
//                         onTap: _pickFromGallery,
//                         child: const CircleAvatar(
//                           radius: 28,
//                           backgroundColor: Colors.white,
//                           child: Icon(
//                             Icons.photo_library,
//                             color: Colors.black,
//                             size: 28,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       const Text(
//                         'Album',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';


class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}


class _QrScannerScreenState extends State<QrScannerScreen> {

  final MobileScannerController controller =
      MobileScannerController();

  final ImagePicker picker = ImagePicker();


  File? pickedImage;

  bool isFlashOn = false;

  String qrResult = "";


  // Camera QR Scan
  void onDetect(BarcodeCapture capture) {

    final List<Barcode> barcodes = capture.barcodes;

    if(barcodes.isNotEmpty){

      final value = barcodes.first.rawValue;

      if(value != null){

        setState(() {
          qrResult = value;
        });

      }
    }

  }

Future<void> pickImage() async {

  final XFile? image =
      await picker.pickImage(
        source: ImageSource.gallery,
      );


  if(image == null) return;


  // Compress image
  final compressedFile =
      await FlutterImageCompress.compressAndGetFile(
        image.path,
        "${Directory.systemTemp.path}/qr_image.jpg",
        quality: 80,
        format: CompressFormat.jpeg,
      );


  if(compressedFile == null) return;


  setState(() {

    pickedImage = File(compressedFile.path);

  });



  try {

    final BarcodeCapture? result =
        await controller.analyzeImage(
          compressedFile.path,
        );


    if(result != null &&
       result.barcodes.isNotEmpty){


      setState(() {

        qrResult =
          result.barcodes.first.rawValue ?? "";

      });


    }


  } catch(e){

    debugPrint(
      "QR Scan Error: $e",
    );

  }

}

  // Flash control
  Future<void> toggleFlash() async {

    await controller.toggleTorch();

    setState(() {

      isFlashOn = !isFlashOn;

    });

  }



  @override
  void dispose(){

    controller.dispose();

    super.dispose();

  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Scan QR Code",
        ),
      ),


      body: Column(

        children: [


          Expanded(

            child: Stack(

              alignment: Alignment.center,

              children: [


                // Show picked image
                if(pickedImage != null)

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



                // QR Scanner border

                Container(

                  width: 230,

                  height: 230,

                  decoration: BoxDecoration(

                    border: Border.all(

                      color: Colors.white,

                      width: 3,

                    ),

                    borderRadius:
                    BorderRadius.circular(20),

                  ),

                ),


              ],

            ),

          ),



          if(qrResult.isNotEmpty)

            Padding(

              padding: const EdgeInsets.all(10),

              child: Text(

                "Result: $qrResult",

                style: const TextStyle(

                  fontSize: 16,

                  fontWeight: FontWeight.bold,

                ),

              ),

            ),



          // Bottom buttons

          Container(

            height: 90,

            padding: const EdgeInsets.all(15),

            child: Row(

              mainAxisAlignment:
              MainAxisAlignment.spaceEvenly,

              children: [


                // Flash

                ElevatedButton.icon(

                  onPressed: toggleFlash,

                  icon: Icon(

                    isFlashOn

                        ? Icons.flash_on

                        : Icons.flash_off,

                  ),

                  label: Text(

                    isFlashOn

                        ? "Light On"

                        : "Light",

                  ),

                ),



                // Album

                ElevatedButton.icon(

                  onPressed: pickImage,

                  icon: const Icon(

                    Icons.photo,

                  ),

                  label: const Text(

                    "Album",

                  ),

                ),


              ],

            ),

          ),


        ],

      ),

    );

  }

}