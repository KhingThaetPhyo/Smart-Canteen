
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:smartcanteen/service/secure_storage_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _contentController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    
    // Content entrance animation
    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _contentController,
      curve: Curves.easeOutCubic,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: Curves.easeOutCubic,
      ),
    );

    // Pulsing dots animation
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

     // Your animation setup...

  _contentController.forward();

  _navigate();
  }
Future<void> _navigate() async {
  await Future.delayed(const Duration(seconds: 3));

  if (!mounted) return;

  // // Show system UI again
  // SystemChrome.setEnabledSystemUIMode(
  //   SystemUiMode.edgeToEdge,
  // );

  final token = await SecureStorageService.getToken();

  if (!mounted) return;

  if (token != null && token.isNotEmpty) {
    context.go('/navigation');
  } else {
    context.go('/navigation');
  }
}
  @override
  void dispose() {
    _contentController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryContainer = Color(0xFF006D77);
    const Color textWhite = Colors.white;

    return Scaffold(
      backgroundColor: primaryContainer,
      body: Stack(
        children: [
          // ===========================
          // Student Splash Background
          // ===========================

          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: CustomPaint(
                painter: DotPatternPainter(),
              ),
            ),
          ),

          Positioned(
            top: -80,
            right: -80,
            child: Container(
              width: 256,
              height: 256,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: textWhite.withOpacity(0.05),
              ),
            ),
          ),

          Positioned(
            bottom: -80,
            left: -80,
            child: Container(
              width: 256,
              height: 256,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: textWhite.withOpacity(0.05),
              ),
            ),
          ),

          // ===========================
          // Main Content
          // ===========================

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 40,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 16),

                  SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Logo Card
                          Container(
  width: 230,
  height: 230,
  padding: const EdgeInsets.all(20),
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    color: textWhite.withOpacity(0.1),
    border: Border.all(
      color: textWhite.withOpacity(0.2),
      width: 2,
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.25),
        blurRadius: 25,
        offset: const Offset(0, 10),
      ),
    ],
  ),
  child: ClipOval(
    child: Image.asset(
      'assets/image/user_logo.jpg',
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(
          Icons.storefront,
          size: 80,
          color: Colors.white,
        );
      },
    ),
  ),
),
                          const SizedBox(height: 24),

                          const Text(
                            'SMARTCANTEEN',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: textWhite,
                              fontSize: 32,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.5,
                              
                            ),
                          ),

                          const SizedBox(height: 8),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 32,
                                height: 1,
                                color: textWhite.withOpacity(0.4),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  'USER EDITION',
                                  style: TextStyle(
                                    color: Colors.white60,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 2,
                                    
                                  ),
                                ),
                              ),
                              Container(
                                width: 32,
                                height: 1,
                                color: textWhite.withOpacity(0.4),
                              ),
                            ],
                          ),
                                                    const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),

                  // Bottom Loader
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedPulsingDots(controller: _pulseController),
                      const SizedBox(height: 16),
                      Text(
                        'LOADING CAMPUS MENUS...',
                        style: TextStyle(
                          color: textWhite.withOpacity(0.5),
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                          
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================
// Animated Loading Dots
// ==========================

class AnimatedPulsingDots extends StatelessWidget {
  final AnimationController controller;

  const AnimatedPulsingDots({
    super.key,
    required this.controller,
  });

  Widget _buildDot(double delayOffset) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final double value = (controller.value - delayOffset) % 1.0;

        final double opacity = value < 0.5
            ? (value * 2) * 0.7 + 0.3
            : (1.0 - value) * 2 * 0.7 + 0.3;

        final double scale = value < 0.5
            ? 0.8 + (value * 2) * 0.2
            : 1.0 - (value - 0.5) * 2 * 0.2;

        return Transform.scale(
          scale: scale,
          child: Opacity(
            opacity: opacity.clamp(0.3, 1.0),
            child: Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildDot(0.0),
        const SizedBox(width: 8),
        _buildDot(0.15),
        const SizedBox(width: 8),
        _buildDot(0.30),
      ],
    );
  }
}

// ==========================
// Student Splash Background
// ==========================

class DotPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    const double spacing = 28.0;
    const double radius = 0.8;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(
          Offset(x, y),
          radius,
          paint,
        );

        canvas.drawCircle(
          Offset(
            x + spacing / 2,
            y + spacing / 2,
          ),
          radius,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}