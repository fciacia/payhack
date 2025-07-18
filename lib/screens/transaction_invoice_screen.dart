import 'package:flutter/material.dart';

class TransactionInvoiceScreen extends StatelessWidget {
  const TransactionInvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Object? args = ModalRoute.of(context)?.settings.arguments;

    if (args == null || args is! Map) {
      return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: const Text('Transaction Invoice', style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.onBackground,
        ),
        body: const Center(child: Text('No transaction details available.')),
      );
    }

    final Map<String, dynamic> transaction = Map<String, dynamic>.from(args);

    final bool isFromReceivedFunds = transaction.containsKey('from') && transaction.containsKey('method');

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Transaction Invoice', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.receipt_rounded,
                    size: 50,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Transaction Receipt',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Transaction processed successfully',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Transaction Details Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Transaction Details',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  _buildDetailRow('Amount', transaction['amount'] ?? 'N/A', Icons.attach_money_rounded),
                  const SizedBox(height: 15),
                  _buildDetailRow('Date', transaction['date'] ?? 'N/A', Icons.calendar_today_rounded),
                  const SizedBox(height: 15),
                  _buildDetailRow('Status', transaction['status'] ?? 'N/A', Icons.info_outline_rounded),
                  const SizedBox(height: 15),
                  _buildDetailRow('Type', transaction['type'] ?? 'N/A', Icons.swap_horiz_rounded),

                  // Show "From" and "Received Type" for received transactions
                  if ((transaction['type'] ?? '').toString().toLowerCase() == 'received') ...[
                    const SizedBox(height: 15),
                    _buildDetailRow('From', transaction['from'] ?? 'N/A', Icons.person_rounded),
                    if ((transaction['receivedType'] ?? '').toString().isNotEmpty) ...[
                      const SizedBox(height: 15),
                      _buildDetailRow('Received Type', transaction['receivedType'], Icons.account_balance_wallet_rounded),
                    ],
                  ],

                  // Show "To" for sent transactions (pending or completed)
                  if ((transaction['type'] ?? '').toString().toLowerCase() == 'sent') ...[
                    const SizedBox(height: 15),
                    _buildDetailRow('To', transaction['to'] ?? 'N/A', Icons.person_rounded),
                  ],
                ],
              ),
            ),


            const SizedBox(height: 30),

            if (isFromReceivedFunds) ...[
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, '/transaction_history', (route) => false);
                  },
                  icon: const Icon(Icons.home_rounded),
                  label: const Text('Back to History'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Export functionality coming soon!')),
                  );
                },
                icon: const Icon(Icons.share_rounded),
                label: const Text('Share Receipt'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.w500)),
              const SizedBox(height: 2),
              Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ],
    );
  }
}