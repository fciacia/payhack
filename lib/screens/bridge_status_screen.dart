import 'package:flutter/material.dart';
import '../app_colors.dart';
import 'package:flutter/services.dart';

class BridgeStatusScreen extends StatefulWidget {
  const BridgeStatusScreen({super.key});

  @override
  State<BridgeStatusScreen> createState() => _BridgeStatusScreenState();
}

class _BridgeStatusScreenState extends State<BridgeStatusScreen>
    with SingleTickerProviderStateMixin {
  int _currentStep = 0;
  bool refreshing = false;
  String txHash = '0xA1B2...C3D4';
  final String sourceLogo =
      'https://cryptologos.cc/logos/ethereum-eth-logo.png';
  final String destLogo = 'https://cryptologos.cc/logos/polygon-matic-logo.png';
  final List<String> steps = [
    'Initiating',
    'Sending',
    'Bridging',
    'Validating',
    'Completed',
  ];
  final List<String> estTimes = ['2s', '5s', '12s', '3s', 'Done'];
  final List<String?> errors = [null, null, 'Delay detected', null, null];

  void _refresh() async {
    setState(() => refreshing = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => refreshing = false);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 800), _nextStep);
  }

  void _nextStep() {
    if (_currentStep < steps.length - 1) {
      setState(() => _currentStep++);
      Future.delayed(const Duration(seconds: 2), _nextStep);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bridge Status'),
        backgroundColor: AppColors.lace,
        foregroundColor: AppColors.sapphire,
        elevation: 0,
        actions: [
          IconButton(
            icon: refreshing
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.sapphire,
                    ),
                  )
                : const Icon(Icons.refresh, color: AppColors.sapphire),
            onPressed: refreshing ? null : _refresh,
            tooltip: 'Refresh',
          ),
        ],
      ),
      backgroundColor: AppColors.lace,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Source and destination chains
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ChainLogo(url: sourceLogo),
                const SizedBox(width: 18),
                const Icon(
                  Icons.arrow_forward,
                  color: AppColors.sapphire,
                  size: 28,
                ),
                const SizedBox(width: 18),
                _ChainLogo(url: destLogo),
              ],
            ),
            const SizedBox(height: 24),
            // Step progress bar
            SizedBox(
              height: 90,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: steps.length,
                separatorBuilder: (context, i) => const SizedBox(width: 24),
                itemBuilder: (context, i) {
                  final isActive = i <= _currentStep;
                  return Column(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: isActive ? AppColors.sapphire : AppColors.lace,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isActive
                                ? AppColors.sapphire
                                : AppColors.sapphire.withAlpha(60),
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            i == 0
                                ? Icons.play_arrow
                                : i == 1
                                ? Icons.send
                                : i == 2
                                ? Icons.compare_arrows
                                : i == 3
                                ? Icons.verified
                                : Icons.check_circle,
                            color: isActive
                                ? Colors.white
                                : AppColors.sapphire.withAlpha(120),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            steps[i],
                            style: TextStyle(
                              color: isActive
                                  ? AppColors.sapphire
                                  : AppColors.sapphire.withAlpha(120),
                              fontWeight: isActive
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                          if (errors[i] != null)
                            Tooltip(
                              message: errors[i]!,
                              child: const Padding(
                                padding: EdgeInsets.only(left: 4),
                                child: Icon(
                                  Icons.error,
                                  color: AppColors.amber,
                                  size: 16,
                                ),
                              ),
                            ),
                        ],
                      ),
                      if (estTimes[i] != 'Done')
                        Text(
                          '~${estTimes[i]}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.sapphire,
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
            // Lottie/bridge animation placeholder
            Container(
              width: 120,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.petal,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.sapphire.withAlpha(18),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.animation,
                  color: AppColors.sapphire,
                  size: 48,
                ),
              ),
            ),
            const SizedBox(height: 32),
            // TX hash, copy, and estimated time
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'TX Hash:',
                  style: TextStyle(
                    color: AppColors.sapphire,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                SelectableText(
                  txHash,
                  style: const TextStyle(color: AppColors.sapphire),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.copy,
                    color: AppColors.sapphire,
                    size: 20,
                  ),
                  tooltip: 'Copy TX Hash',
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: txHash));
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('Copied!')));
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Estimated Completion: ~${estTimes[_currentStep]}',
              style: const TextStyle(color: AppColors.sapphire),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChainLogo extends StatelessWidget {
  final String url;
  const _ChainLogo({required this.url});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        url,
        width: 44,
        height: 44,
        errorBuilder: (c, e, s) =>
            Icon(Icons.broken_image, color: AppColors.sapphire),
      ),
    );
  }
}
