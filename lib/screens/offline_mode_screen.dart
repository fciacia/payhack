import 'package:flutter/material.dart';

class OfflineModeScreen extends StatefulWidget {
  @override
  _OfflineModeScreenState createState() => _OfflineModeScreenState();
}

class _OfflineModeScreenState extends State<OfflineModeScreen> {
  int queuedTransactions = 3;

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.bluetooth),
                  label: const Text('Send via NFC / Bluetooth'),
                  onPressed: _confirmTransfer,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  ),
                ),
                const SizedBox(width: 16),
                OutlinedButton.icon(
                  icon: const Icon(Icons.qr_code_scanner),
                  label: const Text('Scan Recipient'),
                  onPressed: _scanRecipient,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Card(
              color: Colors.grey[50],
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Will sync when online.',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 12),
                    Tooltip(
                      message: 'Backup node is holding your hash receipt securely.',
                      child: Row(
                        children: const [
                          Icon(Icons.info_outline, color: Colors.blue, size: 18),
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
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
