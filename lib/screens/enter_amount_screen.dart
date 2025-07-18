import 'package:flutter/material.dart';

class EnterAmountScreen extends StatefulWidget {
  const EnterAmountScreen({super.key});

  @override
  State<EnterAmountScreen> createState() => _EnterAmountScreenState();
}

class _EnterAmountScreenState extends State<EnterAmountScreen> {
  final TextEditingController _amountController = TextEditingController(
    text: '500',
  );
  String _selectedCurrency = 'USD';
  final List<String> _currencies = ['USD', 'EUR', 'USDT', 'BRL'];
  bool _roundUp = false;
  final List<String> _causes = [
    'Trees',
    'Clean Oceans',
    'Local Community Support',
  ];
  String _selectedCause = 'Trees';

  double get _amount {
    final val = double.tryParse(_amountController.text) ?? 0;
    return val;
  }

  double get _roundUpAmount {
    if (!_roundUp) return 0.0;
    final nextInt = _amount.ceilToDouble();
    return (nextInt - _amount).toStringAsFixed(2) == '0.00'
        ? 1.0
        : (nextInt - _amount);
  }

  String get _carbonEstimate => '0.05kg CO₂';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final avatar = args != null && args['avatar'] != null
        ? args['avatar'] as String
        : 'https://i.pravatar.cc/150?u=felicia';
    final username = args != null && args['username'] != null
        ? args['username'] as String
        : '@Felicia';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Amount'),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipient display
            Row(
              children: [
                CircleAvatar(radius: 28, backgroundImage: NetworkImage(avatar)),
                const SizedBox(width: 16),
                Text(
                  '@$username',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.tertiary.withAlpha((0.5 * 255).round()),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'RM',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Theme.of(
                        context,
                      ).inputDecorationTheme.fillColor,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 16,
                      ),
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
              ],
            ),
            // Round-Up for a Cause toggle
            const SizedBox(height: 18),
            Row(
              children: [
                Switch(
                  value: _roundUp,
                  onChanged: (val) => setState(() => _roundUp = val),
                  activeColor: Colors.green,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Round up to the nearest RM? (e.g., RM${_roundUpAmount.toStringAsFixed(2)} to $_selectedCause)',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            if (_roundUp) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text('Cause:', style: TextStyle(fontSize: 15)),
                  const SizedBox(width: 10),
                  DropdownButton<String>(
                    value: _selectedCause,
                    items: _causes
                        .map(
                          (cause) => DropdownMenuItem(
                            value: cause,
                            child: Text(cause),
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedCause = val);
                    },
                  ),
                ],
              ),
            ],
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
                    label: Text(
                      currency,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: selected
                            ? Colors.white
                            : Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    selected: selected,
                    selectedColor: Theme.of(context).colorScheme.primary,
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.secondary.withAlpha((0.7 * 255).round()),
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
              'RM ${_amountController.text} → $_selectedCurrency 108.50 (Live Rate) | Est. Transfer Carbon: $_carbonEstimate',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
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
                      'roundUp': _roundUp,
                      'roundUpAmount': _roundUpAmount,
                      'cause': _selectedCause,
                      'carbon': _carbonEstimate,
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
