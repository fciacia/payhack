import 'package:flutter/material.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Example transaction data
    final transactions = [
    {
      'amount': 'RM 150',
      'date': '2025-06-24',
      'status': 'Pending',
      'type': 'Sent',
      'to': '@Abu',
    },
    {
      'amount': 'RM 300',
      'date': '2025-06-23',
      'status': 'Completed',
      'type': 'Received',
      'from': '@Ali',
      'receivedType': 'Stablecoin (USDT)',
    },
    {
      'amount': 'RM 100',
      'date': '2025-06-22',
      'status': 'Completed',
      'type': 'Sent',
      'to': '@Muthu',
    },
  ];


    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Transaction History', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Transaction History',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 25),

            // Button to view pending received funds
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/received_funds');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('View Pending Received Funds'),
            ),
            const SizedBox(height: 30),

            // Transaction List
            Expanded(
              child: ListView.separated(
                itemCount: transactions.length,
                separatorBuilder: (_, __) => const SizedBox(height: 15),
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/transaction_invoice',
                        arguments: {
                          'amount': transaction['amount'] ?? '',
                          'date': transaction['date'] ?? '',
                          'status': transaction['status'] ?? '',
                          'type': transaction['type'] ?? '',
                          'from': transaction['from'] ?? '',
                          'to': transaction['to'] ?? '',
                          'receivedType': transaction['receivedType'] ?? '',
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            transaction['type'] == 'Received'
                                ? Icons.arrow_downward_rounded
                                : Icons.arrow_upward_rounded,
                            color: transaction['type'] == 'Received'
                                ? Colors.green
                                : Colors.red,
                            size: 30,
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Amount: ${transaction['amount']}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Date: ${transaction['date']}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            transaction['status']!,
                            style: TextStyle(
                              color: transaction['status'] == 'Completed'
                                  ? Colors.green
                                  : Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}