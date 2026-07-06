import 'dart:ui';
import 'package:flutter/material.dart';

class WalletInfoScreen extends StatefulWidget {
  const WalletInfoScreen({super.key});

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

  void _handleComplete() async {
    if (_pin.length == _maxPinLength && !_isLoading && !_isSuccess) {
      setState(() {
        _isLoading = true;
      });

      await Future.delayed(const Duration(milliseconds: 1200));

      setState(() {
        _isLoading = false;
        _isSuccess = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
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
            // Decorative Background Blobs
            // Center(
            //   child: Container(
            //     decoration: BoxDecoration(
            //       shape: BoxShape.circle,
            //       color: const Color(0xFFB7C4FF).withOpacity(0.25),
            //     ),
            //     child: BackdropFilter(
            //       filter: ImageFilter.blur(sigmaX: 120, sigmaY: 120),
            //       child: const SizedBox.shrink(),
            //     ),
            //   ),
            // ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFB7EAFF).withOpacity(0.3),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 120, sigmaY: 120),
                child: const SizedBox.shrink(),
              ),
            ),

            // Main UI Layout (Guaranteed No Scroll)
            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Detects smaller/shorter device screens (e.g., iPhone SE)
                  final bool isShortScreen = constraints.maxHeight < 720;

                  return Column(
                    children: [
                      // Dynamic Upper Section (Flexes to fill available space)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //const Spacer(flex: 2),
                              
                              // Adaptive Lock Glass Container
                              Center(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: isShortScreen ? 90 : 130,
                                      height: isShortScreen ? 90 : 130,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF0039B7).withOpacity(0.04),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(isShortScreen ? 24 : 36),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                                        child: Container(
                                          width: isShortScreen ? 76 : 110,
                                          height: isShortScreen ? 76 : 110,
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.65),
                                            borderRadius: BorderRadius.circular(isShortScreen ? 24 : 36),
                                            border: Border.all(
                                              color: const Color(0xFF004CEE).withOpacity(0.15),
                                              width: 1.5,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(0xFF004CEE).withOpacity(0.06),
                                                blurRadius: 32,
                                                offset: const Offset(0, 8),
                                              )
                                            ],
                                          ),
                                          padding: EdgeInsets.all(isShortScreen ? 16 : 22),
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Icon(
                                              Icons.lock_outline_rounded,
                                              color: const Color(0xFF004CEE),
                                              size: isShortScreen ? 32 : 44,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              const Spacer(flex: 2),

                              // Header Texts
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
                                    fontSize: isShortScreen ? 14 : 15,
                                    height: 1.4,
                                    color: const Color(0xFF434656),
                                  ),
                                ),
                              ),
                              
                              const Spacer(flex: 3),

                              // PIN Input Indicators
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(_maxPinLength, (index) {
                                  bool isActive = index < _pin.length;
                                  return AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    margin: const EdgeInsets.symmetric(horizontal: 8),
                                    width: isShortScreen ? 12 : 14,
                                    height: isShortScreen ? 12 : 14,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isActive ? const Color(0xFF004CED) : Colors.white.withOpacity(0.4),
                                      border: Border.all(
                                        color: isActive ? const Color(0xFF004CED) : const Color(0xFF747687).withOpacity(0.3),
                                        width: 1,
                                      ),
                                      boxShadow: isActive
                                          ? [
                                              BoxShadow(
                                                color: const Color(0xFF004CED).withOpacity(0.4),
                                                blurRadius: 5,
                                              )
                                            ]
                                          : [],
                                    ),
                                  );
                                }),
                              ),
                              
                              const Spacer(flex: 2),
                            ],
                          ),
                        ),
                      ),

                      // Fixed Bottom Segment (Keypad + CTA Button)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Keypad Grid
                            SizedBox(
                              width: 260,
                              child: GridView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: isShortScreen ? 12 : 18,
                                  crossAxisSpacing: isShortScreen ? 12 : 18,
                                  childAspectRatio: 1,
                                ),
                                itemCount: 12,
                                itemBuilder: (context, index) {
                                  if (index == 9) return const SizedBox.shrink();
                                  if (index == 11) {
                                    return _KeypadButton(
                                      child: const Icon(Icons.backspace_outlined, size: 20, color: Color(0xFF0039B7)),
                                      onPressed: _deleteKey,
                                    );
                                  }
                                  String keyText = index == 10 ? "0" : "${index + 1}";
                                  return _KeypadButton(
                                    child: Text(
                                      keyText,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF0039B7), // Turned text dark blue for better contrast against light blue
                                      ),
                                    ),
                                    onPressed: () => _pressKey(keyText),
                                  );
                                },
                              ),
                            ),
                            
                            SizedBox(height: isShortScreen ? 16 : 28),

                            // CTA Action Button
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: double.infinity,
                                height: isShortScreen ? 54 : 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: _isSuccess
                                      ? const Color(0xFF22C55E)
                                      : (_pin.length == _maxPinLength ? const Color(0xFF004CED) : const Color(0xFFE0E2E7)),
                                  boxShadow: _pin.length == _maxPinLength && !_isSuccess
                                      ? [
                                          BoxShadow(
                                            color: const Color(0xFF004CEE).withOpacity(0.3),
                                            blurRadius: 24,
                                            offset: const Offset(0, 8),
                                          )
                                        ]
                                      : _isSuccess
                                          ? [
                                              BoxShadow(
                                                color: const Color(0xFF22C55E).withOpacity(0.2),
                                                blurRadius: 24,
                                                offset: const Offset(0, 8),
                                              )
                                            ]
                                          : [],
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                    disabledForegroundColor: const Color(0xFF747687),
                                  ),
                                  onPressed: (_pin.length == _maxPinLength) ? _handleComplete : null,
                                  child: _buildButtonContent(),
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
        child: CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 2.5,
        ),
      );
    }
    if (_isSuccess) {
      return const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle, color: Colors.white),
          SizedBox(width: 8),
          Text(
            'PIN Setup Successful',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      );
    }
    return Text(
      'Complete Registration',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: _pin.length == _maxPinLength ? Colors.white : const Color(0xFF747687),
      ),
    );
  }
}

class _KeypadButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;

  const _KeypadButton({required this.child, required this.onPressed});

  @override
  State<_KeypadButton> createState() => _KeypadButtonState();
}

class _KeypadButtonState extends State<_KeypadButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) {
          _controller.reverse();
          widget.onPressed();
        },
        onTapCancel: () => _controller.reverse(),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // Changed from translucent white to translucent light blue
            color: const Color(0xFFE3F2FD).withOpacity(0.6), 
            border: Border.all(
              color: const Color(0xFF004CEE).withOpacity(0.08),
              width: 1,
            ),
          ),
          child: Center(child: widget.child),
        ),
      ),
    );
  }
}