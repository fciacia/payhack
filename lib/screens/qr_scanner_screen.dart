import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 358,
          height: 212,
          decoration: ShapeDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 24,
                top: 24,
                child: Container(
                  width: 310,
                  height: 24,
                  decoration: ShapeDecoration(
                    color: Colors.black.withValues(alpha: 0),
                    shape: RoundedRectangleBorder(),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 3,
                        child: Icon(
                          Icons.lightbulb_outline,
                          size: 16,
                          color: Colors.white.withValues(alpha: 0.7),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        top: 0.56,
                        child: SizedBox(
                          width: 102,
                          height: 24,
                          child: Text(
                            'Scanning Tips',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 24,
                top: 64,
                child: Container(
                  width: 310,
                  height: 124,
                  decoration: ShapeDecoration(
                    color: Colors.black.withValues(alpha: 0),
                    shape: RoundedRectangleBorder(),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 310,
                          height: 40,
                          decoration: ShapeDecoration(
                            color: Colors.black.withValues(alpha: 0),
                            shape: RoundedRectangleBorder(),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 3.50,
                                child: Icon(
                                  Icons.phone_android,
                                  size: 12,
                                  color: Colors.white.withValues(alpha: 0.7),
                                ),
                              ),
                              Positioned(
                                left: 22.50,
                                top: 1.60,
                                child: SizedBox(
                                  width: 256,
                                  height: 40,
                                  child: Text(
                                    'Hold your device steady and ensure good lighting',
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.70),
                                      fontSize: 14,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 1.43,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 52,
                        child: Container(
                          width: 310,
                          height: 40,
                          decoration: ShapeDecoration(
                            color: Colors.black.withValues(alpha: 0),
                            shape: RoundedRectangleBorder(),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 3.50,
                                child: Icon(
                                  Icons.crop_free,
                                  size: 12,
                                  color: Colors.white.withValues(alpha: 0.7),
                                ),
                              ),
                              Positioned(
                                left: 22.50,
                                top: 1.60,
                                child: SizedBox(
                                  width: 215,
                                  height: 40,
                                  child: Text(
                                    'Keep the QR code within the frame boundaries',
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.70),
                                      fontSize: 14,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 1.43,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 104,
                        child: Container(
                          width: 310,
                          height: 20,
                          decoration: ShapeDecoration(
                            color: Colors.black.withValues(alpha: 0),
                            shape: RoundedRectangleBorder(),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 3.50,
                                child: Icon(
                                  Icons.cleaning_services,
                                  size: 12,
                                  color: Colors.white.withValues(alpha: 0.7),
                                ),
                              ),
                              Positioned(
                                left: 22.50,
                                top: -0.20,
                                child: SizedBox(
                                  width: 253,
                                  height: 20,
                                  child: Text(
                                    'Clean your camera lens for better results',
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.70),
                                      fontSize: 14,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 1.43,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _showTips = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _chooseFromGallery() {
    // Add your gallery selection logic here
    print('Opening gallery...');
    // You can use image_picker package:
    // final ImagePicker picker = ImagePicker();
    // final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Scan QR',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(_showTips ? Icons.close : Icons.help_outline),
            onPressed: () {
              setState(() {
                _showTips = !_showTips;
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Mock camera preview
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF232526), Color(0xFF414345)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Glassmorphic scan area
                Container(
                  width: 260,
                  height: 260,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha((0.10 * 255).round()),
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(
                      color: Colors.white.withAlpha((0.25 * 255).round()),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha((0.10 * 255).round()),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                ),
                // Animated scanning line
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Positioned(
                      top: 260 * _animation.value,
                      child: Container(
                        width: 220,
                        height: 4,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.deepPurpleAccent,
                              Colors.cyanAccent,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    );
                  },
                ),
                // Pulsing overlay
                Positioned.fill(
                  child: IgnorePointer(
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.deepPurpleAccent.withAlpha(
                                  (0.15 * 255 * (1 - _animation.value)).round(),
                                ),
                                blurRadius: 32 + 16 * _animation.value,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Scanning Tips Section
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            bottom: _showTips ? 80 : -240,
            left: 16,
            right: 16,
            child: Section(),
          ),
          // Bottom section with instructions and gallery button
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Instructions (only show when tips are hidden)
                  if (!_showTips)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: Text(
                        'Align the QR code within the frame',
                        style: TextStyle(
                          color: Colors.white.withAlpha((0.85 * 255).round()),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  // Gallery button
                  ElevatedButton.icon(
                    onPressed: _chooseFromGallery,
                    icon: const Icon(
                      Icons.photo_library,
                      color: Colors.white,
                      size: 20,
                    ),
                    label: const Text(
                      'Choose from Gallery',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withAlpha((0.15 * 255).round()),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                        side: BorderSide(
                          color: Colors.white.withAlpha((0.25 * 255).round()),
                          width: 1,
                        ),
                      ),
                      elevation: 0,
                    ),
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