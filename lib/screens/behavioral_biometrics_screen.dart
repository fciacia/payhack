import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class BehavioralBiometricsScreen extends StatefulWidget {
  const BehavioralBiometricsScreen({super.key});

  @override
  State<BehavioralBiometricsScreen> createState() => _BehavioralBiometricsScreenState();
}

class _BehavioralBiometricsScreenState extends State<BehavioralBiometricsScreen> {
  final TextEditingController _pinController = TextEditingController();
  final List<int> _keystrokeTimings = [];
  int? _lastKeyTime;

  double? _swipeVelocity;
  double? _tapForce;
  double? _tapVelocity;
  double? _scrollSpeed;
  double? _scrollDirection;

  // For scroll tracking
  double? _lastScrollOffset;
  int? _lastScrollTime;

  void recordKeystroke(String value, int now) {
    if (_lastKeyTime != null) {
      _keystrokeTimings.add(now - _lastKeyTime!);
    }
    _lastKeyTime = now;
    setState(() {});
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    setState(() {
      _swipeVelocity = details.primaryVelocity?.abs() ?? 0.0;
    });
  }

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _tapForce = 1.0; // Use default value for desktop/macOS
      _tapVelocity = null; // Not available directly
    });
  }

  void _onScroll(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      final now = DateTime.now().millisecondsSinceEpoch;
      if (_lastScrollOffset != null && _lastScrollTime != null) {
        final offsetDelta = (notification.metrics.pixels - _lastScrollOffset!).abs();
        final timeDelta = now - _lastScrollTime!;
        if (timeDelta > 0) {
          _scrollSpeed = offsetDelta / timeDelta;
          _scrollDirection = notification.metrics.pixels - _lastScrollOffset!;
        }
      }
      _lastScrollOffset = notification.metrics.pixels;
      _lastScrollTime = now;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Behavioral Biometrics Demo')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            _onScroll(notification);
            return false;
          },
          child: ListView(
            children: [
              const Text(
                'Passive Identity Validation',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text('Enter your Wallet PIN (for demo):'),
              TextField(
                controller: _pinController,
                obscureText: true,
                keyboardType: TextInputType.number,
                maxLength: 6,
                onChanged: (value) {
                  final now = DateTime.now().millisecondsSinceEpoch;
                  recordKeystroke(value, now);
                },
                decoration: const InputDecoration(labelText: "Enter Wallet PIN"),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onVerticalDragEnd: _onVerticalDragEnd,
                onTapDown: _onTapDown,
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text('Swipe or Tap Here', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Scroll this list to record scroll speed:'),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, i) => ListTile(title: Text('Item ${i + 1}')),
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                ),
              ),
              const SizedBox(height: 24),
              const Text('Collected Metrics:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Keystroke intervals (ms): ${_keystrokeTimings.join(", ")}'),
              Text('Swipe velocity: ${_swipeVelocity?.toStringAsFixed(2) ?? "-"}'),
              Text('Tap force: ${_tapForce?.toStringAsFixed(2) ?? "-"}'),
              Text('Scroll speed: ${_scrollSpeed?.toStringAsFixed(4) ?? "-"}'),
              Text('Scroll direction: ${_scrollDirection != null ? (_scrollDirection! > 0 ? "Down" : "Up") : "-"}'),
            ],
          ),
        ),
      ),
    );
  }
} 