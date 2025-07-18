import 'package:flutter/material.dart';
import 'widgets/glass_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ConfirmTransferScreen extends StatelessWidget {
  const ConfirmTransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Transfer'),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Center(
              child: Column(
                children: [
                  Hero(
                    tag: 'recipient-avatar',
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.primary.withAlpha((0.1 * 255).round()),
                      child: const Text(
                        'F',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '@Felicia',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Transfer summary',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            GlassCard(child: _SummaryCardContent()),
            const Spacer(),
            _buildGradientButton(context),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientButton(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(
              context,
            ).colorScheme.primary.withAlpha((0.18 * 255).round()),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {
            _showRouteOptimizerModal(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FaIcon(
                FontAwesomeIcons.champagneGlasses,
                color: Colors.white,
                size: 22,
              ),
              const SizedBox(width: 12),
              const Text(
                'Pay using glass transaction?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRouteOptimizerModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Transaction Route'),
          content: const Text(
            'Optimize your transaction route for best rates and speed.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showRouteDetailsModal(context);
              },
              child: const Text('[See Route]'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showRouteDetailsModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Transaction Route'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRouteStep(
                context,
                'Polygon',
                'Initiate transaction on Polygon network',
              ),
              _buildArrow(context),
              _buildRouteStep(
                context,
                'Chainlink FX Oracle',
                'Get real-time FX rate',
              ),
              _buildArrow(context),
              _buildRouteStep(
                context,
                'Avalanche',
                'Bridge and process payment',
              ),
              _buildArrow(context),
              _buildRouteStep(
                context,
                'Bank',
                "Funds delivered to recipient's bank",
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Got it'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRouteStep(
    BuildContext context,
    String title,
    String explanation,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          if (explanation.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 2.0),
              child: Text(
                explanation,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildArrow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Center(
        child: Text(
          '↓',
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}

class _SummaryCardContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSummaryRow(
          context,
          'Amount:',
          'RM 500',
          icon: FontAwesomeIcons.moneyBillWave,
        ),
        const SizedBox(height: 20),
        _buildSummaryRow(
          context,
          'Will receive:',
          'USD 108.50',
          icon: FontAwesomeIcons.wallet,
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const FaIcon(
                  FontAwesomeIcons.chartLine,
                  size: 20,
                  color: Colors.deepPurple,
                ),
                const SizedBox(width: 15),
                const Text(
                  'FX Rate:',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  '1 RM = 0.217 USD',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('FX Rate Information'),
                        content: const Text(
                          "You're saving RM12 vs bank FX rate",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.info_outline,
                    size: 18,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSummaryRow(
    BuildContext context,
    String title,
    String value, {
    required IconData icon,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            FaIcon(
              icon,
              color: Theme.of(context).colorScheme.primary,
              size: 20,
            ),
            const SizedBox(width: 15),
            Text(
              title,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
