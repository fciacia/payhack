import 'package:flutter/material.dart';

enum PaymentResultType { success, failure }

class PaymentResultScreen extends StatelessWidget {
  final PaymentResultType type;
  final String username;
  final String chain;
  final String amount;

  const PaymentResultScreen({
    super.key,
    required this.type,
    required this.username,
    required this.chain,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    final isSuccess = type == PaymentResultType.success;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          isSuccess ? 'Payment Success' : 'Payment Failed',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSuccess
                ? [const Color(0xFF43E97B), const Color(0xFF38F9D7)]
                : [const Color(0xFFFF5858), const Color(0xFFFFAE53)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: GlassmorphicCard(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 24),
                AnimatedIconWidget(isSuccess: isSuccess),
                const SizedBox(height: 24),
                Text(
                  isSuccess ? 'Payment Successful!' : 'Payment Failed',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: isSuccess ? Colors.green[700] : Colors.red[700],
                  ),
                ),
                const SizedBox(height: 16),
                _SummaryRow(label: 'To', value: username),
                _SummaryRow(label: 'Chain', value: chain),
                _SummaryRow(label: 'Amount', value: amount),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSuccess ? Colors.green : Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Done'),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GlassmorphicCard extends StatelessWidget {
  final Widget child;
  const GlassmorphicCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha((0.15 * 255).round()),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.08 * 255).round()),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: Colors.white.withAlpha((0.2 * 255).round()),
          width: 1.5,
        ),
      ),
      child: child,
    );
  }
}

class AnimatedIconWidget extends StatefulWidget {
  final bool isSuccess;
  const AnimatedIconWidget({super.key, required this.isSuccess});

  @override
  State<AnimatedIconWidget> createState() => _AnimatedIconWidgetState();
}

class _AnimatedIconWidgetState extends State<AnimatedIconWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _controller.value,
          child: Transform.scale(
            scale: 0.7 + 0.3 * _controller.value,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.isSuccess ? Colors.green[100] : Colors.red[100],
                boxShadow: [
                  BoxShadow(
                    color: (widget.isSuccess ? Colors.green : Colors.red)
                        .withAlpha((0.2 * 255).round()),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Icon(
                widget.isSuccess ? Icons.check_rounded : Icons.close_rounded,
                color: widget.isSuccess ? Colors.green : Colors.red,
                size: 48,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  const _SummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: const TextStyle(fontSize: 15, color: Colors.black54),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
