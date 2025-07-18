import 'package:flutter/material.dart';

class ReceiveFundsScreen extends StatefulWidget {
  const ReceiveFundsScreen({super.key});

  @override
  State<ReceiveFundsScreen> createState() => _ReceiveFundsScreenState();
}

class _ReceiveFundsScreenState extends State<ReceiveFundsScreen> {
  String? selectedOption;

  void _confirmReceipt() {
    if (selectedOption == null) return;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Receipt Confirmed"),
        content: Text(
          "You've received RM200 via $selectedOption.\n\n🪙 Smart Suggestion: Keep in Basket Coin? FX is volatile right now.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Done"),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(String label, IconData icon) {
    return ListTile(
      title: Text(label),
      leading: Icon(icon),
      trailing: Radio<String>(
        value: label,
        groupValue: selectedOption,
        onChanged: (value) => setState(() => selectedOption = value),
      ),
      onTap: () => setState(() => selectedOption = label),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Receive Funds")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "🎉 You've received RM 200 from @200",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            const Text(
              'Choose how to receive:',
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
            const Divider(height: 30),
            _buildOption("Local Bank", Icons.account_balance),
            _buildOption("Stablecoin (USDT / DAI)", Icons.currency_bitcoin),
            _buildOption("Convert to Gold Token", Icons.savings),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedOption == null ? null : _confirmReceipt,
                child: const Text("Confirm Receipt"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
