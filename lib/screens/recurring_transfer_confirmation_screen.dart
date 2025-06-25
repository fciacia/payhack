import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecurringTransferConfirmationScreen extends StatelessWidget {
  const RecurringTransferConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nextTransferDate = DateFormat('MMMM d, yyyy').format(DateTime.now().add(const Duration(days: 30)));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recurring Transfer Set!'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Icon(Icons.check_circle_outline, color: Theme.of(context).colorScheme.primary, size: 80),
            const SizedBox(height: 20),
            const Text(
              "Your recurring transfer to @MAMA for RM 500 every 1st of the month has been set.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 40),
            _buildSummaryCard(context, nextTransferDate),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                },
                child: const Text(
                  'Done',
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

  Widget _buildSummaryCard(BuildContext context, String nextTransferDate) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        children: [
          _buildSummaryRow('Next Transfer Date:', nextTransferDate),
          const SizedBox(height: 15),
          _buildSummaryRow('Recipient:', '@MAMA'),
          const SizedBox(height: 15),
          _buildSummaryRow('Amount:', 'RM 500'),
          const SizedBox(height: 15),
          _buildSummaryRow('Frequency:', 'Every 1st of the month'),
          const SizedBox(height: 15),
          _buildSummaryRow('FX Rate Option:', 'Locked'),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }
} 