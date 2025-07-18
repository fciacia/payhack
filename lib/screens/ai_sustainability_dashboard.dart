import 'package:flutter/material.dart';

class AISustainabilityDashboard extends StatelessWidget {
  const AISustainabilityDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Sustainability Dashboard'),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            '🌱 AI Sustainability Insights',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          const SizedBox(height: 12),
          Card(
            color: Colors.green[50],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Personalized Green Summary',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Your recent activities have contributed to a positive environmental impact. You have reduced your carbon footprint by 12% this month, supported 8 local green merchants, and made 3 donations to environmental causes.',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Your top sustainable actions:',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  SizedBox(height: 4),
                  Text('• Used public transport for 60% of your trips'),
                  Text('• Chose eco-friendly merchants for 80% of purchases'),
                  Text('• Participated in a local tree-planting event'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          Card(
            color: Colors.blue[50],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'How You Can Improve',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                  SizedBox(height: 8),
                  Text('• Try to increase your use of renewable energy at home.'),
                  Text('• Reduce single-use plastics by bringing your own bags and bottles.'),
                  Text('• Support more local and fair-trade businesses.'),
                  Text('• Offset your carbon emissions by contributing to certified projects.'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          Card(
            color: Colors.amber[50],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'AI Recommendations',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.amber),
                  ),
                  SizedBox(height: 8),
                  Text('• Join upcoming community clean-up events.'),
                  Text('• Explore green investment opportunities.'),
                  Text('• Take educational modules to learn more about sustainability.'),
                  Text('• Invite friends to join and multiply your impact!'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: Text(
              'Together, we can make a difference for a greener future! 🌏',
              style: TextStyle(fontSize: 15, color: Colors.green, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
} 