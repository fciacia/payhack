import 'package:flutter/material.dart';

class OfflineModeScreen extends StatefulWidget {
  const OfflineModeScreen({super.key});

  @override
  OfflineModeScreenState createState() => OfflineModeScreenState();
}

class OfflineModeScreenState extends State<OfflineModeScreen> {
  int queuedTransactions = 3;
  // Mock: Each queued transaction retains its eco-pulse/round-up info
  final List<Map<String, dynamic>> queuedTxs = [
    {
      'amount': 'RM500',
      'recipient': '@Felicia',
      'ecoPulse': true,
      'roundUp': true,
      'cause': 'Trees',
      'roundUpAmount': '0.60',
    },
    {'amount': 'RM200', 'recipient': '@Cafe', 'ecoPulse': false},
    {
      'amount': 'RM100',
      'recipient': '@LocalStore',
      'ecoPulse': true,
      'roundUp': true,
      'cause': 'Clean Oceans',
      'roundUpAmount': '0.40',
    },
  ];

  void _confirmTransfer() {
    setState(() {
      queuedTransactions++;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Transaction queued. Will sync when online.')),
    );
  }

  void _scanRecipient() {
    setState(() {
      queuedTransactions++;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Recipient scanned. Transaction queued!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Offline Mode')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Icon(Icons.wifi_off, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            const Text(
              'No internet detected – no problem!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Send via NFC/Bluetooth or scan recipient below.',
              style: TextStyle(fontSize: 15, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const Divider(height: 32),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.bluetooth),
                    label: const Text('Send via NFC / Bluetooth'),
                    onPressed: _confirmTransfer,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.qr_code_scanner),
                    label: const Text('Scan Recipient'),
                    onPressed: _scanRecipient,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Card(
              color: Colors.grey[50],
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.lock, color: Colors.deepPurple),
                        const SizedBox(width: 10),
                        Text(
                          '🔐 $queuedTransactions transaction${queuedTransactions > 1 ? 's' : ''} queued',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Make the queued transactions scrollable with a max height
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 120),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: queuedTxs.length,
                        itemBuilder: (context, idx) {
                          final tx = queuedTxs[idx];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              children: [
                                Icon(
                                  tx['ecoPulse'] == true
                                      ? Icons.eco
                                      : Icons.sync,
                                  color: tx['ecoPulse'] == true
                                      ? Colors.green
                                      : Colors.grey,
                                  size: 18,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    tx['ecoPulse'] == true &&
                                            tx['roundUp'] == true
                                        ? '${tx['amount']} to ${tx['recipient']}  |  Round-up: RM${tx['roundUpAmount']} to ${tx['cause']}'
                                        : '${tx['amount']} to ${tx['recipient']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: tx['ecoPulse'] == true
                                          ? Colors.green
                                          : Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Will sync when online.',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 12),
                    Tooltip(
                      message:
                          'Backup node is holding your hash receipt securely.',
                      child: Row(
                        children: const [
                          Icon(
                            Icons.info_outline,
                            color: Colors.blue,
                            size: 18,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Stand-in node active',
                            style: TextStyle(color: Colors.blue, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            const Text(
              'Your transactions are safe and will be processed automatically once you are back online.',
              style: TextStyle(fontSize: 13, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.eco, color: Colors.green, size: 16),
                SizedBox(width: 6),
                Flexible(
                  child: Text(
                    'Eco-Pulse impact and round-up data will sync to your Impact Dashboard once online.',
                    style: TextStyle(fontSize: 13, color: Colors.green),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ], // closes children list for Column
        ), // closes Column
      ), // closes Padding
    ); // closes Scaffold
  }
}
