import 'package:flutter/material.dart';
import '../app_colors.dart';

class GasFeeComparisonScreen extends StatefulWidget {
  const GasFeeComparisonScreen({super.key});

  @override
  State<GasFeeComparisonScreen> createState() => _GasFeeComparisonScreenState();
}

class _GasFeeComparisonScreenState extends State<GasFeeComparisonScreen>
    with SingleTickerProviderStateMixin {
  String timeRange = '1h';
  bool refreshing = false;
  List<Map<String, dynamic>> gasFees = [
    {
      'chain': 'Ethereum',
      'fee': 18.2,
      'base': 16.0,
      'priority': 2.2,
      'preferred': false,
    },
    {
      'chain': 'BNB',
      'fee': 0.12,
      'base': 0.10,
      'priority': 0.02,
      'preferred': false,
    },
    {
      'chain': 'Polygon',
      'fee': 0.03,
      'base': 0.02,
      'priority': 0.01,
      'preferred': true,
    },
    {
      'chain': 'Avalanche',
      'fee': 0.15,
      'base': 0.13,
      'priority': 0.02,
      'preferred': false,
    },
  ];
  Map<String, List<double>> historicalFees = {
    'Ethereum': [18.2, 17.5, 19.0, 18.0, 18.7, 18.2, 17.9],
    'BNB': [0.12, 0.13, 0.11, 0.12, 0.12, 0.13, 0.12],
    'Polygon': [0.03, 0.04, 0.03, 0.03, 0.02, 0.03, 0.03],
    'Avalanche': [0.15, 0.14, 0.16, 0.15, 0.15, 0.14, 0.15],
  };

  void _refresh() async {
    setState(() => refreshing = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => refreshing = false);
  }

  void _togglePreferred(int i) {
    setState(() {
      gasFees[i]['preferred'] = !(gasFees[i]['preferred'] as bool);
    });
  }

  @override
  Widget build(BuildContext context) {
    final maxFee = gasFees
        .map((e) => e['fee'] as double)
        .reduce((a, b) => a > b ? a : b);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gas Fee Comparison'),
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Time range tabs
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: ['1h', '1d', '7d']
                  .map(
                    (r) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ChoiceChip(
                        label: Text(
                          r,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.sapphire,
                          ),
                        ),
                        selected: timeRange == r,
                        selectedColor: AppColors.sapphire,
                        backgroundColor: AppColors.petal,
                        onSelected: (_) => setState(() => timeRange = r),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: timeRange == r ? 2 : 0,
                        labelStyle: TextStyle(
                          color: timeRange == r
                              ? AppColors.lace
                              : AppColors.sapphire,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 24),
            // Line chart (historical)
            Expanded(
              flex: 2,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: _LineChart(
                  key: ValueKey(timeRange),
                  historicalFees: historicalFees,
                  timeRange: timeRange,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Bar chart (current)
            Expanded(
              flex: 2,
              child: _BarChart(
                gasFees: gasFees,
                maxFee: maxFee,
                onBarTap: (i) {
                  final fee = gasFees[i];
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: AppColors.lace,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      title: Text('${fee['chain']} Fee Breakdown'),
                      content: Text(
                        'Base: ${fee['base']}\nPriority: ${fee['priority']}',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            // Preferred toggle
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 18,
              children: List.generate(
                gasFees.length,
                (i) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        gasFees[i]['preferred']
                            ? Icons.star
                            : Icons.star_border,
                        color: gasFees[i]['preferred']
                            ? AppColors.amber
                            : AppColors.sapphire,
                      ),
                      tooltip: gasFees[i]['preferred']
                          ? 'Unmark Preferred'
                          : 'Mark as Preferred',
                      onPressed: () => _togglePreferred(i),
                    ),
                    Text(
                      gasFees[i]['chain'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.sapphire,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BarChart extends StatelessWidget {
  final List<Map<String, dynamic>> gasFees;
  final double maxFee;
  final void Function(int) onBarTap;
  const _BarChart({
    required this.gasFees,
    required this.maxFee,
    required this.onBarTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final barWidth = constraints.maxWidth / (gasFees.length * 2);
        return Stack(
          children: [
            for (int i = 0; i < gasFees.length; i++)
              Positioned(
                left: barWidth + i * barWidth * 2,
                bottom: 0,
                child: GestureDetector(
                  onTap: () => onBarTap(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    width: barWidth,
                    height:
                        ((gasFees[i]['fee'] as double) / maxFee) *
                        (constraints.maxHeight * 0.7),
                    decoration: BoxDecoration(
                      color: AppColors.sapphire,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.sapphire.withAlpha(30),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        gasFees[i]['fee'].toStringAsFixed(2),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _LineChart extends StatelessWidget {
  final Map<String, List<double>> historicalFees;
  final String timeRange;
  const _LineChart({
    required Key key,
    required this.historicalFees,
    required this.timeRange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _LineChartPainter(historicalFees),
      child: Container(),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  final Map<String, List<double>> historicalFees;
  _LineChartPainter(this.historicalFees);

  @override
  void paint(Canvas canvas, Size size) {
    final colors = [
      AppColors.sapphire,
      AppColors.lavender,
      AppColors.amber,
      AppColors.green,
    ];
    final chains = historicalFees.keys.toList();
    final maxVal = historicalFees.values
        .expand((l) => l)
        .reduce((a, b) => a > b ? a : b);
    final n = historicalFees[chains[0]]!.length;
    for (int c = 0; c < chains.length; c++) {
      final points = historicalFees[chains[c]]!;
      final paint = Paint()
        ..color = colors[c % colors.length]
        ..strokeWidth = 3
        ..style = PaintingStyle.stroke;
      final path = Path();
      for (int i = 0; i < points.length; i++) {
        final x = (i / (n - 1)) * size.width;
        final y = size.height - (points[i] / maxVal) * (size.height * 0.8);
        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
