// // // import 'package:flutter/material.dart';
// // // import 'package:qr_flutter/qr_flutter.dart';

// // // class UserQrScreen extends StatelessWidget {
// // //   final String qrData;

// // //   const UserQrScreen({
// // //     super.key,
// // //     required this.qrData,
// // //   });

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: const Text('My QR Code'),
// // //         centerTitle: true,
// // //       ),
// // //       body: Center(
// // //         child: Card(
// // //           elevation: 8,
// // //           shape: RoundedRectangleBorder(
// // //             borderRadius: BorderRadius.circular(20),
// // //           ),
// // //           child: Padding(
// // //             padding: const EdgeInsets.all(24.0),
// // //             child: Column(
// // //               mainAxisSize: MainAxisSize.min,
// // //               children: [
// // //                 const Text(
// // //                   'SmartCanteen QR',
// // //                   style: TextStyle(
// // //                     fontSize: 22,
// // //                     fontWeight: FontWeight.bold,
// // //                   ),
// // //                 ),
// // //                 const SizedBox(height: 20),

// // //                 // QR Code
// // //                 QrImageView(
// // //                   data: qrData,
// // //                   version: QrVersions.auto,
// // //                   size: 220.0,
// // //                   backgroundColor: Colors.white,
// // //                 ),

// // //                 // const SizedBox(height: 20),

// // //                 // Text(
// // //                 //   qrData,
// // //                 //   textAlign: TextAlign.center,
// // //                 //   style: const TextStyle(fontSize: 14),
// // //                 // ),
// // //               ],
// // //             ),
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// // import 'package:flutter/material.dart';
// // import 'package:go_router/go_router.dart';
// // import 'package:qr_flutter/qr_flutter.dart';

// // class UserQrScreen extends StatelessWidget {
// //   final String qrData;

// //   const UserQrScreen({
// //     super.key,
// //     required this.qrData,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     const Color brandColor = Color(0xFF006D77);

// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: PreferredSize(
// //         // Gives the AppBar a taller, comfortable standard height
// //         preferredSize: const Size.fromHeight(90.0), 
// //         child: AppBar(
// //           toolbarHeight: 90,
// //           backgroundColor: brandColor,
// //           elevation: 2,
// //           leading: IconButton(
// //             icon: const Icon(Icons.arrow_back, color: Colors.white),
// //             onPressed: () {
// //               context.go('/navigation');
// //             },
// //           ),
// //           title: const Text(
// //             'My QR Code',
// //             style: TextStyle(
// //               color: Colors.white,
// //               fontSize: 20,
// //               fontWeight: FontWeight.w600,
// //             ),
// //           ),
// //           centerTitle: true,
// //         ),
// //       ),
// //       body: Center(
// //         child: SingleChildScrollView(
// //           padding: const EdgeInsets.all(24.0),
// //           child: Card(
// //             //elevation: 8,
// //             shadowColor: Colors.black12,
// //             shape: RoundedRectangleBorder(
// //               borderRadius: BorderRadius.circular(24),
// //             ),
// //             child: Container(
// //               width: 300,
// //               padding: const EdgeInsets.symmetric(
// //                 vertical: 10.0,
// //                 horizontal: 20.0,
// //               ),
// //               child: Column(
// //                 mainAxisSize: MainAxisSize.min,
// //                 children: [
// //                   Image.asset(
// //                     'assets/image/user_logo-removebg.png',
// //                     height: 100,
// //                     width: 100,
// //                     fit: BoxFit.cover,
// //                   ),
// //                   const Text(
// //                     'SmartCanteen',
// //                     style: TextStyle(
// //                       fontSize: 16,
// //                       fontWeight: FontWeight.bold,
// //                       color: brandColor,
// //                     ),
// //                   ),
// //                   const SizedBox(height: 24),
// //                   QrImageView(
// //                     data: qrData,
// //                     version: QrVersions.auto,
// //                     size: 200.0,
// //                     backgroundColor: Colors.white,
// //                     padding: EdgeInsets.zero,
// //                   ),
// //                   const SizedBox(height: 24),
// //                   Text(
// //                     "Scan QR to transfer...",
// //                     textAlign: TextAlign.center,
// //                     maxLines: 1,
// //                     overflow: TextOverflow.ellipsis,
// //                     style: TextStyle(
// //                       fontSize: 12,
// //                       color: Colors.grey.shade500,
// //                       fontWeight: FontWeight.w400,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'dart:ui' as ui;
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:gal/gal.dart';
// import 'package:go_router/go_router.dart';
// import 'package:qr_flutter/qr_flutter.dart';

// class UserQrScreen extends StatefulWidget {
//   final String qrData;

//   const UserQrScreen({
//     super.key,
//     required this.qrData,
//   });

//   @override
//   State<UserQrScreen> createState() => _UserQrScreenState();
// }

// class _UserQrScreenState extends State<UserQrScreen> {
//   // GlobalKey to capture the widget into an image
//   final GlobalKey _qrCardKey = GlobalKey();
//   bool _isSaving = false;

//   Future<void> _saveQrCode() async {
//     setState(() => _isSaving = true);

//     try {
//       // 1. Capture the widget area using RepaintBoundary
//       final boundary =
//           _qrCardKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
//       if (boundary == null) return;

//       final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
//       final ByteData? byteData =
//           await image.toByteData(format: ui.ImageByteFormat.png);

//       if (byteData != null) {
//         final Uint8List pngBytes = byteData.buffer.asUint8List();

//         // 2. Save the image bytes to gallery using 'gal'
//         await Gal.putImageBytes(pngBytes);

//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('QR Code saved to gallery successfully!'),
//               backgroundColor: Color(0xFF006D77),
//             ),
//           );
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Failed to save QR Code: ${e.toString()}'),
//             backgroundColor: Colors.redAccent,
//           ),
//         );
//       }
//     } finally {
//       if (mounted) {
//         setState(() => _isSaving = false);
//       }
//     }  
//   }

//   @override
//   Widget build(BuildContext context) {
//     const Color brandColor = Color(0xFF006D77);
//     final Size screenSize = MediaQuery.of(context).size;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         toolbarHeight: 90,
//         backgroundColor: brandColor,
//         elevation: 2,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => context.go('/navigation'),
//         ),
//         title: const Text(
//           'My QR Code',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             // Calculate responsive dimensions dynamically based on available width
//             final double cardWidth = constraints.maxWidth * 0.85 > 360.0
//                 ? 360.0
//                 : constraints.maxWidth * 0.85;

//             final double qrSize = cardWidth * 0.6;
//             final double logoSize = cardWidth * 0.25;

//             return Center(
//               child: SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // RepaintBoundary captures everything inside it
//                     RepaintBoundary(
//                       key: _qrCardKey,
//                       child: Card(
//                         color: Colors.white,
//                         elevation: 4,
//                         shadowColor: Colors.black12,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(24),
//                         ),
//                         child: Container(
//                           width: cardWidth,
//                           padding: const EdgeInsets.symmetric(
//                             vertical: 24.0,
//                             horizontal: 20.0,
//                           ),
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Image.asset(
//                                 'assets/image/user_logo-removebg.png',
//                                 height: logoSize,
//                                 width: logoSize,
//                                 fit: BoxFit.contain,
//                                 errorBuilder: (context, error, stackTrace) =>
//                                     Icon(Icons.person, size: logoSize, color: brandColor),
//                               ),
//                               const SizedBox(height: 8),
//                               const Text(
//                                 'SmartCanteen',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                   color: brandColor,
//                                 ),
//                               ),
//                               const SizedBox(height: 20),
//                               QrImageView(
//                                 data: widget.qrData,
//                                 version: QrVersions.auto,
//                                 size: qrSize,
//                                 backgroundColor: Colors.white,
//                                 padding: EdgeInsets.zero,
//                               ),
//                               const SizedBox(height: 20),
//                               Text(
//                                 "Scan QR to transfer...",
//                                 textAlign: TextAlign.center,
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: TextStyle(
//                                   fontSize: 13,
//                                   color: Colors.grey.shade600,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 28),
//                     // Action Button to Save Image
//                     SizedBox(
//                       width: cardWidth,
//                       height: 50,
//                       child: ElevatedButton.icon(
//                         onPressed: _isSaving ? null : _saveQrCode,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: brandColor,
//                           foregroundColor: Colors.white,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                           elevation: 2,
//                         ),
//                         icon: _isSaving
//                             ? const SizedBox(
//                                 width: 20,
//                                 height: 20,
//                                 child: CircularProgressIndicator(
//                                   strokeWidth: 2,
//                                   color: Colors.white,
//                                 ),
//                               )
//                             : const Icon(Icons.download_rounded),
//                         label: Text(
//                           _isSaving ? 'Saving...' : 'Save QR Code',
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gal/gal.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:smartcanteen/service/secure_storage_service.dart';

class UserQrScreen extends StatefulWidget {
  final String qrData;

  const UserQrScreen({
    super.key,
    required this.qrData,
  });

  @override
  State<UserQrScreen> createState() => _UserQrScreenState();
}

class _UserQrScreenState extends State<UserQrScreen> {
  final GlobalKey _qrCardKey = GlobalKey();
  bool _isSaving = false;
  
  // State variables for QR data handling
  late String _activeQrData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _resolveQrData();
  }

  Future<void> _resolveQrData() async {
    // If passed parameter is not empty, use it directly
    if (widget.qrData.trim().isNotEmpty) {
      if (mounted) {
        setState(() {
          _activeQrData = widget.qrData;
          _isLoading = false;
        });
      }
      return;
    }

    // Otherwise, fallback to reading saved JSON from SecureStorage
    final savedQr = await SecureStorageService.getQrData();
    if (mounted) {
      setState(() {
        _activeQrData = savedQr ?? '';
        _isLoading = false;
      });
    }
  }

  Future<void> _saveQrCode() async {
    setState(() => _isSaving = true);

    try {
      final boundary =
          _qrCardKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return;

      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData != null) {
        final Uint8List pngBytes = byteData.buffer.asUint8List();
        await Gal.putImageBytes(pngBytes);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('QR Code saved to gallery successfully!'),
              backgroundColor: Color(0xFF006D77),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save QR Code: ${e.toString()}'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }  
  }

  @override
  Widget build(BuildContext context) {
    const Color brandColor = Color(0xFF006D77);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: brandColor,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => context.go('/navigation'),
        ),
        title: const Text(
          'My QR Code',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator(color: brandColor))
            : LayoutBuilder(
                builder: (context, constraints) {
                  final double cardWidth = constraints.maxWidth * 0.85 > 360.0
                      ? 360.0
                      : constraints.maxWidth * 0.85;

                  final double qrSize = cardWidth * 0.6;
                  final double logoSize = cardWidth * 0.25;

                  return Center(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RepaintBoundary(
                            key: _qrCardKey,
                            child: Card(
                              color: Colors.white,
                              elevation: 4,
                              shadowColor: Colors.black12,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Container(
                                width: cardWidth,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 24.0,
                                  horizontal: 20.0,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      'assets/image/user_logo-removebg.png',
                                      height: logoSize,
                                      width: logoSize,
                                      fit: BoxFit.contain,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Icon(Icons.person,
                                                  size: logoSize,
                                                  color: brandColor),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'SmartCanteen',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: brandColor,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    
                                    // Render QR Code using verified fallback data
                                    if (_activeQrData.isNotEmpty)
                                      QrImageView(
                                        data: _activeQrData,
                                        version: QrVersions.auto,
                                        size: qrSize,
                                        backgroundColor: Colors.white,
                                        padding: EdgeInsets.zero,
                                      )
                                    else
                                      const Padding(
                                        padding: EdgeInsets.all(20.0),
                                        child: Text(
                                          'No QR Data Found',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                      
                                    const SizedBox(height: 20),
                                    Text(
                                      "Scan QR to transfer...",
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 28),
                          SizedBox(
                            width: cardWidth,
                            height: 50,
                            child: ElevatedButton.icon(
                              onPressed: (_isSaving || _activeQrData.isEmpty)
                                  ? null
                                  : _saveQrCode,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: brandColor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 2,
                              ),
                              icon: _isSaving
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Icon(Icons.download_rounded),
                              label: Text(
                                _isSaving ? 'Saving...' : 'Save QR Code',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}