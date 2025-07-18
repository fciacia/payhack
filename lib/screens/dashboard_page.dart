import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data
    final int transactionsToday = 23;
    final double totalAmount = 1250.50;
    final integrations = [
      {'icon': Icons.qr_code, 'name': 'DuitNow QR'},
      {'icon': Icons.account_balance, 'name': 'Maybank'},
      {'icon': Icons.account_balance_wallet, 'name': 'TNG Wallet'},
    ];
    final greenScore = 78;
    final tier = 'Silver';
    final eligible = true;
    final rate = '3.5–4.2%';
    final invoices = [
      {'id': '#INV1002', 'amount': 350.0, 'status': 'Paid'},
      {'id': '#INV1003', 'amount': 600.0, 'status': 'Unpaid'},
      {'id': '#INV1004', 'amount': 1200.0, 'status': 'Pending'},
    ];
    final bizProfile = {
      'bizId': 'BIZ20230921A',
      'name': 'Eco Mart',
      'category': 'Retail',
      'verified': true,
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Business Dashboard')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Transactions Today
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const Icon(Icons.show_chart, color: Colors.deepPurple, size: 36),
                    const SizedBox(width: 18),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('RM ${totalAmount.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                        Text('from $transactionsToday transactions', style: const TextStyle(fontSize: 15)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 22),
            // 2. Latest Integrations
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Latest Integrations', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 48,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: integrations.length + 1,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, i) {
                          if (i < integrations.length) {
                            final item = integrations[i];
                            return Chip(
                              avatar: Icon(item['icon'] as IconData, size: 20, color: Colors.deepPurple),
                              label: Text(item['name'] as String),
                              backgroundColor: Colors.deepPurple[50],
                            );
                          } else {
                            return ActionChip(
                              avatar: const Icon(Icons.add, color: Colors.deepPurple),
                              label: const Text('Add Integration'),
                              onPressed: () {},
                              backgroundColor: Colors.deepPurple[100],
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 22),
            // 3. Loan Eligibility Status
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Loan Eligibility Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.eco, color: Colors.green[700], size: 28),
                        const SizedBox(width: 8),
                        Text('Green Score: $greenScore', style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(width: 16),
                        Chip(
                          label: Text(tier),
                          backgroundColor: tier == 'Gold' ? Colors.amber[100] : tier == 'Silver' ? Colors.blue[100] : Colors.grey[200],
                        ),
                      ],
                    ),
                    if (eligible) ...[
                      const SizedBox(height: 8),
                      Text('Eligible for $rate Green Loan', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, '/green_loan'),
                        child: const Text('View Green Loan Details'),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 22),
            // 4. Invoices Generated
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Invoices Generated', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 10),
                    ...invoices.take(3).map((inv) => ListTile(
                          leading: Icon(
                            inv['status'] == 'Paid'
                                ? Icons.check_circle
                                : inv['status'] == 'Unpaid'
                                    ? Icons.cancel
                                    : Icons.hourglass_bottom,
                            color: inv['status'] == 'Paid'
                                ? Colors.green
                                : inv['status'] == 'Unpaid'
                                    ? Colors.red
                                    : Colors.amber,
                          ),
                          title: Text('${inv['id']} – RM${(inv['amount'] as double).toStringAsFixed(2)}'),
                          subtitle: Text(inv['status'] as String),
                        )),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.add),
                      label: const Text('Generate New Invoice'),
                      onPressed: () => Navigator.pushNamed(context, '/einvoicing_screen'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 22),
            // 5. Manage BizID Profile
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Manage BizID Profile', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.verified, color: (bizProfile['verified'] as bool) ? Colors.green : Colors.grey, size: 28),
                        const SizedBox(width: 8),
                        Text('BizID: ${bizProfile['bizId']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text('Name: ${bizProfile['name']}'),
                    Text('Category: ${bizProfile['category']}'),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Implement navigation to BizProfilePage
                      },
                      child: const Text('Manage Profile'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 22),
          ],
        ),
      ),
    );
  }
} 