import 'package:flutter/material.dart';

void showPickUpCodeDialog(BuildContext context, String code) {
  const Color primaryColor = Color(0xff117992);

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        backgroundColor: Color.alphaBlend(
          primaryColor.withOpacity(0.05),
          const Color(0xffF8FAFC),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// HEADER SECTION
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.grid_view_rounded,
                            size: 18,
                            color: primaryColor,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          "Customer's pickup QR",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff1E293B),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        child: const Icon(
                          Icons.close_rounded,
                          size: 22,
                          color: Color(0xff64748B),
                        ),
                      ),
                    ),
                  ],
                ),
          
                const SizedBox(height: 16),
                const Divider(height: 1, color: Color(0xffE2E8F0), thickness: 1),
                const SizedBox(height: 20),
          
                /// QR CODE CARD CONTAINER
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 28,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff0F172A).withOpacity(0.05),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: CustomPaint(
                          painter: _MockQrCodePainter(themeColor: primaryColor),
                        ),
                      ),
                      const SizedBox(height: 24),
          
                      /// PICKUP CODE BADGE
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 9,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: primaryColor.withOpacity(0.25),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          code,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: primaryColor,
                            letterSpacing: 0.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

/// Custom painter to generate a sharp, realistic QR code matching the primary theme
class _MockQrCodePainter extends CustomPainter {
  final Color themeColor;

  _MockQrCodePainter({required this.themeColor});

  @override
  void paint(Canvas canvas, Size size) {
    // Dark color with a subtle tint of primary theme for extra polish
    final Color qrColor = Color.alphaBlend(
      themeColor.withOpacity(0.15),
      const Color(0xff0F172A),
    );

    final paint = Paint()
      ..color = qrColor
      ..style = PaintingStyle.fill;

    final double unit = size.width / 21; // Standard 21x21 QR Grid

    void drawSquare(int x, int y, int w, int h) {
      canvas.drawRect(
        Rect.fromLTWH(x * unit, y * unit, w * unit, h * unit),
        paint,
      );
    }

    // Top-Left Finder Pattern
    drawSquare(0, 0, 7, 7);
    paint.color = Colors.white;
    drawSquare(1, 1, 5, 5);
    paint.color = qrColor;
    drawSquare(2, 2, 3, 3);

    // Top-Right Finder Pattern
    drawSquare(14, 0, 7, 7);
    paint.color = Colors.white;
    drawSquare(15, 1, 5, 5);
    paint.color = qrColor;
    drawSquare(16, 2, 3, 3);

    // Bottom-Left Finder Pattern
    drawSquare(0, 14, 7, 7);
    paint.color = Colors.white;
    drawSquare(1, 15, 5, 5);
    paint.color = qrColor;
    drawSquare(2, 16, 3, 3);

    // Dynamic QR Data Blocks matching the visual layout
    final dataBlocks = [
      // Top Center Data
      [9, 0, 3, 2], [9, 3, 2, 4], [12, 4, 1, 3],
      // Center Body
      [0, 8, 3, 2], [3, 9, 2, 3], [7, 8, 4, 2],
      [12, 8, 2, 3], [15, 8, 3, 1], [18, 9, 3, 2],
      [8, 11, 4, 2], [14, 10, 2, 4], [18, 12, 3, 2],
      // Bottom Right Data
      [9, 14, 2, 5], [12, 15, 2, 3], [15, 15, 6, 2],
      [15, 18, 6, 2], [12, 19, 2, 2],
    ];

    for (var b in dataBlocks) {
      drawSquare(b[0], b[1], b[2], b[3]);
    }
  }

  @override
  bool shouldRepaint(covariant _MockQrCodePainter oldDelegate) =>
      oldDelegate.themeColor != themeColor;
}