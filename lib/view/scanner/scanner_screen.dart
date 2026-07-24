import 'package:flutter/material.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen>
    with SingleTickerProviderStateMixin {
  static const Color primaryColor = Color(0xff117992);
  bool isFlashOn = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Simulated scan success handler
  void _simulateSuccessfulScan() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xff10B981).withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_rounded,
                color: Color(0xff10B981),
                size: 32,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "QR Code Detected",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff1E293B),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "Coffee Corner Canteen • ID: CC-8921",
              style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close sheet
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Proceed to Pay",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0F172A),
      body: Stack(
        children: [
          /// SIMULATED CAMERA VIEWFINDER BACKDROP
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff090D16), Color(0xff0F172A)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.camera_alt_outlined,
                  size: 90,
                  color: Colors.white.withOpacity(0.04),
                ),
              ),
            ),
          ),

          /// RETICLE VIEWPORT OVERLAY
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: _simulateSuccessfulScan, // Tap frame to test scan
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      /// TARGET SCAN AREA BACKGROUND
                      Container(
                        width: 260,
                        height: 260,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.03),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: primaryColor.withOpacity(0.4),
                            width: 1.5,
                          ),
                        ),
                      ),

                      /// ANIMATED SCANNING LINE
                      AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          return SizedBox(
                            width: 240,
                            height: 240,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 240 * _animationController.value,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height: 2,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.transparent,
                                          primaryColor,
                                          Colors.transparent,
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: primaryColor.withOpacity(0.8),
                                          blurRadius: 8,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      /// CORNER RETICLE ACCENTS
                      SizedBox(
                        width: 272,
                        height: 272,
                        child: CustomPaint(
                          painter: ScannerCornerPainter(color: primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Color(0xff10B981),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Align QR code within the frame to pay",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// TOP BAR WITH CONTROLS (Back button removed)
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
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.15)),
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
                    size: 20,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black.withOpacity(0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// BOTTOM GALLERY PICKER ACTION (Added extra bottom padding to clear the navigation bar)
          Positioned(
            bottom: 110,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Opening photo gallery..."),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(22),
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

    const cornerLength = 28.0;

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
