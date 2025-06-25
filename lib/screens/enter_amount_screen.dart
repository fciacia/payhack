import 'package:flutter/material.dart';

class EnterAmountScreen extends StatefulWidget {
  const EnterAmountScreen({super.key});

  @override
  State<EnterAmountScreen> createState() => _EnterAmountScreenState();
}

class _EnterAmountScreenState extends State<EnterAmountScreen> {
  final TextEditingController _amountController = TextEditingController(text: '500');
  String _selectedCurrency = 'USD';
  final List<String> _currencies = ['USD', 'EUR', 'USDT', 'BRL'];

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final avatar = args != null && args['avatar'] != null ? args['avatar'] as String : 'https://i.pravatar.cc/150?u=felicia';
    final username = args != null && args['username'] != null ? args['username'] as String : '@Felicia';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Amount'),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipient display
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(avatar),
                ),
                const SizedBox(width: 16),
                Text(
                  '@$username',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 36),
            // Amount input
            const Text(
              'Amount to Send',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'RM',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Currency toggle
            const Text(
              "Recipient's Currency",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 48,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _currencies.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final currency = _currencies[index];
                  final selected = _selectedCurrency == currency;
                  return ChoiceChip(
                    label: Text(currency, style: TextStyle(fontWeight: FontWeight.bold, color: selected ? Colors.white : Theme.of(context).colorScheme.primary)),
                    selected: selected,
                    selectedColor: Theme.of(context).colorScheme.primary,
                    backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.7),
                    onSelected: (_) {
                      setState(() => _selectedCurrency = currency);
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
            // FX Rate preview
            Text(
              'RM ${_amountController.text} → $_selectedCurrency 108.50 (Live Rate)',
              style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600),
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
                    '/confirm_transfer',
                    arguments: {
                      'avatar': avatar,
                      'username': username,
                      'amount': _amountController.text,
                      'currency': _selectedCurrency,
                    },
                  );
                },
                child: const Text(
                  'Continue',
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