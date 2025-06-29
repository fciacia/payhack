import 'package:flutter/material.dart';

class ScheduleTransferScreen extends StatefulWidget {
  const ScheduleTransferScreen({super.key});

  @override
  State<ScheduleTransferScreen> createState() => _ScheduleTransferScreenState();
}

class _ScheduleTransferScreenState extends State<ScheduleTransferScreen> {
  String _selectedFrequency = 'Every 1st of month';
  String _selectedFxOption = 'Lock FX rate now';
  final List<String> _frequencies = [
    'Every 1st of month',
    'Weekly',
    'Bi-weekly',
    'Monthly',
    'Quarterly',
    'Annually',
    'Custom...',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Recurring Transfer'),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Row(
              children: const [
                CircleAvatar(
                  radius: 22,
                  child: Text(
                    'M',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  '@MAMA',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              'Amount',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: '500',
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixText: 'RM ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 12,
                ),
              ),
              enabled: false,
            ),
            const SizedBox(height: 30),
            const Text(
              'Frequency',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedFrequency,
              items: _frequencies
                  .map(
                    (freq) => DropdownMenuItem(value: freq, child: Text(freq)),
                  )
                  .toList(),
              onChanged: (val) {
                setState(() {
                  _selectedFrequency = val!;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 12,
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'FX Rate',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            RadioListTile<String>(
              value: 'Lock FX rate now',
              groupValue: _selectedFxOption,
              onChanged: (val) {
                setState(() {
                  _selectedFxOption = val!;
                });
              },
              title: const Text('Lock FX rate now'),
              activeColor: Theme.of(context).colorScheme.primary,
            ),
            RadioListTile<String>(
              value: 'Use market rate at time of transfer',
              groupValue: _selectedFxOption,
              onChanged: (val) {
                setState(() {
                  _selectedFxOption = val!;
                });
              },
              title: const Text('Use market rate at time of transfer'),
              activeColor: Theme.of(context).colorScheme.primary,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 2,
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/recurring_transfer_confirmation',
                  );
                },
                child: const Text(
                  'Set Recurring Transfer',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
