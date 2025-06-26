import 'package:flutter/material.dart';

class ReceivedFundsScreen extends StatefulWidget {
  const ReceivedFundsScreen({super.key});

  @override
  State<ReceivedFundsScreen> createState() => _ReceivedFundsScreenState();
}

class _ReceivedFundsScreenState extends State<ReceivedFundsScreen> {
  String? selectedMethod;

  final List<Map<String, dynamic>> methods = [
    {
      'label': 'Local Bank',
      'icon': Icons.account_balance_rounded,
      'value': 'bank',
    },
    {
      'label': 'Stablecoin (USDT/DAI)',
      'icon': Icons.currency_bitcoin_rounded,
      'value': 'stablecoin',
    },
    {
      'label': 'Convert to Gold Token',
      'icon': Icons.monetization_on_rounded,
      'value': 'gold',
    },
  ];

  String _getMethodLabel(String value) {
    final method = methods.firstWhere((m) => m['value'] == value);
    return method['label'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Receive Money', style: TextStyle(fontWeight: FontWeight.bold)),
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
              "You've received RM 200 from @Nigerian Prince",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 25),

            // Smart suggestion banner
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.yellow[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  Icon(Icons.info_outline_rounded, color: Colors.black87),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Keep in Basket Coin? FX is volatile right now.',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            const Text(
              'Choose how to receive',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            // Options list
            ...methods.map((method) {
              final isSelected = selectedMethod == method['value'];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GestureDetector(
                  onTap: () {
                    setState(() => selectedMethod = method['value']);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                          : Theme.of(context).colorScheme.surface,
                      border: Border.all(
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                    child: Row(
                      children: [
                        Icon(method['icon'], size: 28),
                        const SizedBox(width: 16),
                        Text(method['label'],
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                        const Spacer(),
                        if (isSelected)
                          Icon(Icons.check_circle,
                              color: Theme.of(context).colorScheme.primary),
                      ],
                    ),
                  ),
                ),
              );
            }),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedMethod == null
                    ? null
                    : () {
                        Navigator.pushNamed(context, '/transaction_invoice', arguments: {
                          'amount': 'RM 200',
                          'date': DateTime.now().toString().split(' ')[0],
                          'status': 'Completed',
                          'type': 'Received via ${_getMethodLabel(selectedMethod!)}',
                          'from': '@Nigerian Prince',
                          'method': selectedMethod,
                        });
                      },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Confirm & View Receipt',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}