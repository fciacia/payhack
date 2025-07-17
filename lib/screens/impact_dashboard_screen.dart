import 'package:flutter/material.dart';

class ImpactDashboardScreen extends StatelessWidget {
  const ImpactDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data
    final Map<String, double> breakdown = {
      'Carbon': 40,
      'Ethical': 35,
      'Social': 25,
    };
    final List<Map<String, dynamic>> monthly = [
      {'label': 'Low-Carbon %', 'value': 68, 'color': Colors.green},
      {'label': 'Donations (RM)', 'value': 12.5, 'color': Colors.amber},
      {'label': 'Merchants Supported', 'value': 8, 'color': Colors.blue},
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Impact Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Your Impact Breakdown',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 16),
          Center(
            child: SizedBox(
              height: 120,
              width: 120,
              child: CustomPaint(painter: _ImpactPieChartPainter(breakdown)),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _legendDot(Colors.green, 'Carbon'),
              const SizedBox(width: 12),
              _legendDot(Colors.blue, 'Ethical'),
              const SizedBox(width: 12),
              _legendDot(Colors.amber, 'Social'),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Monthly Summary',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          ...monthly.map(
            (item) => Card(
              child: ListTile(
                leading: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: item['color'],
                    shape: BoxShape.circle,
                  ),
                ),
                title: Text(item['label']),
                trailing: Text(
                  item['value'].toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Card(
            color: Colors.blue[50],
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: const [
                  Icon(Icons.sync, color: Colors.blue),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Impact data is synced when online. Offline activity will update automatically.',
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          // --- Intuitive Infographics and Personalized Insights ---
          Card(
            color: Colors.green[50],
            child: ListTile(
              leading: const Icon(Icons.directions_bus, color: Colors.green),
              title: const Text('Transport Impact'),
              subtitle: const Text(
                '30% of your transport spending was on public transport (low carbon)',
              ),
            ),
          ),
          Card(
            color: Colors.amber[50],
            child: ListTile(
              leading: const Icon(Icons.store, color: Colors.amber),
              title: const Text('Local Business Support'),
              subtitle: const Text(
                'You contributed RM 25 to local businesses this month.',
              ),
            ),
          ),
          Card(
            color: Colors.blue[50],
            child: ListTile(
              leading: const Icon(Icons.restaurant, color: Colors.blue),
              title: const Text('Food Spending'),
              subtitle: const Text(
                '80% of your food spending was at sustainable merchants.',
              ),
            ),
          ),
          const SizedBox(height: 24),
          // --- Pie Chart for Transport Breakdown ---
          const Text(
            'Transport Breakdown',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          Center(
            child: SizedBox(
              height: 100,
              width: 100,
              child: CustomPaint(
                painter: _ImpactPieChartPainter({
                  'Public Transport': 30,
                  'Private Car': 50,
                  'Ride Sharing': 20,
                }),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _legendDot(Colors.green, 'Public Transport'),
              const SizedBox(width: 8),
              _legendDot(Colors.grey, 'Private Car'),
              const SizedBox(width: 8),
              _legendDot(Colors.amber, 'Ride Sharing'),
            ],
          ),
        ],
      ),
    );
  }
}

// Reuse legendDot and _ImpactPieChartPainter from dashboard file
Widget _legendDot(Color color, String label) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      const SizedBox(width: 4),
      Text(label, style: const TextStyle(fontSize: 11)),
    ],
  );
}

class _ImpactPieChartPainter extends CustomPainter {
  final Map<String, double> breakdown;
  _ImpactPieChartPainter(this.breakdown);
  @override
  void paint(Canvas canvas, Size size) {
    final total = breakdown.values.fold(0.0, (a, b) => a + b);
    double start = -90;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 2;
    final colors = [Colors.green, Colors.blue, Colors.amber];
    int i = 0;
    for (final value in breakdown.values) {
      final sweep = 360 * (value / total);
      paint.color = colors[i % colors.length];
      canvas.drawArc(
        Rect.fromLTWH(0, 0, size.width, size.height),
        start * 3.1415926 / 180,
        sweep * 3.1415926 / 180,
        false,
        paint,
      );
      start += sweep;
      i++;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
