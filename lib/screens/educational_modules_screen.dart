import 'package:flutter/material.dart';

class EducationalModulesScreen extends StatelessWidget {
  const EducationalModulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> modules = [
      {
        'icon': Icons.eco,
        'title': 'What is a Carbon Footprint?',
        'desc':
            'Learn how your daily choices impact the environment and how to reduce your carbon footprint.',
      },
      {
        'icon': Icons.volunteer_activism,
        'title': 'How Micro-Donations Work',
        'desc':
            'Discover how small donations can add up to big change for social and environmental causes.',
      },
      {
        'icon': Icons.store,
        'title': 'Why Support Local Businesses?',
        'desc': 'See how spending locally helps your community and the planet.',
      },
      {
        'icon': Icons.account_balance_wallet,
        'title': 'Basics of Financial Literacy',
        'desc':
            'Understand saving, budgeting, and making smart payment choices.',
      },
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Educational Modules')),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: modules.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, i) {
          final module = modules[i];
          return Card(
            child: ListTile(
              leading: Icon(module['icon'], color: Colors.blue),
              title: Text(module['title']),
              subtitle: Text(module['desc']),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Row(
                      children: [
                        Icon(module['icon'], color: Colors.blue),
                        const SizedBox(width: 8),
                        Text(
                          module['title'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    content: Text(module['desc']),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Mark as Complete'),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
