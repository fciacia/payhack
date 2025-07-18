import 'package:flutter/material.dart';
import 'widgets/glass_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ConfirmTransferScreen extends StatelessWidget {
  const ConfirmTransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final avatar = args?['avatar'];
    final username = args?['username'] ?? '@Felicia';
    final amount = args?['amount'] ?? '500';
    final currency = args?['currency'] ?? 'USD';
    final roundUp = args?['roundUp'] ?? false;
    final roundUpAmount = args?['roundUpAmount'] ?? 0.0;
    final cause = args?['cause'] ?? 'Trees';
    final carbon = args?['carbon'] ?? '0.05kg CO₂';

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
                      backgroundImage: avatar != null
                          ? NetworkImage(avatar)
                          : null,
                      child: avatar == null
                          ? const Text(
                              'F',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '@$username',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
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
            GlassCard(
              child: _ImpactSummaryContent(
                amount: amount,
                currency: currency,
                roundUp: roundUp,
                roundUpAmount: roundUpAmount,
                cause: cause,
                carbon: carbon,
              ),
            ),
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

class _ImpactSummaryContent extends StatelessWidget {
  final String amount;
  final String currency;
  final bool roundUp;
  final dynamic roundUpAmount;
  final String cause;
  final String carbon;

  const _ImpactSummaryContent({
    required this.amount,
    required this.currency,
    required this.roundUp,
    required this.roundUpAmount,
    required this.cause,
    required this.carbon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.send, color: Colors.deepPurple, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Transferring RM$amount to $currency.',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        if (roundUp && roundUpAmount != null && roundUpAmount > 0)
          Row(
            children: [
              const Icon(Icons.eco, color: Colors.green, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Round-up contribution: RM${(roundUpAmount is double ? roundUpAmount.toStringAsFixed(2) : roundUpAmount)} to $cause.',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        if (roundUp && roundUpAmount != null && roundUpAmount > 0)
          const SizedBox(height: 10),
        Row(
          children: [
            const Icon(Icons.cloud, color: Colors.blueGrey, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Est. carbon footprint of transfer: $carbon',
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            const Icon(Icons.insights, color: Colors.amber, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Tooltip(
                message:
                    "You're making a greener choice by avoiding traditional SWIFT!",
                child: const Text(
                  'Smart Insights: Greener route selected (blockchain-based)',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.amber,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        // FX Rate and info
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.currency_exchange,
                  size: 18,
                  color: Colors.deepPurple,
                ),
                const SizedBox(width: 8),
                const Text(
                  'FX Rate:',
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  '1 RM = 0.217 $currency',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
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
}
