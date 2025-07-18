import 'package:flutter/material.dart';
import 'widgets/glass_card.dart';
import '../app_colors.dart';

class RecurringTransferScreen extends StatefulWidget {
  const RecurringTransferScreen({super.key});

  @override
  State<RecurringTransferScreen> createState() =>
      _RecurringTransferScreenState();
}

class _RecurringTransferScreenState extends State<RecurringTransferScreen> {
  final PageController _controller = PageController();
  int _step = 0;

  // Demo state
  String selectedUsername = '@alice';
  String enteredAmount = '500';
  String selectedCurrency = 'USD';
  String frequency = 'Monthly';
  DateTime? startDate;
  DateTime? endDate;
  String fxOption = 'lock';

  // Mock data
  final List<Map<String, dynamic>> favoriteContacts = [
    {
      'avatar': 'https://i.pravatar.cc/150?img=1',
      'username': '@alice',
      'name': 'Alice',
      'verified': true,
    },
    {
      'avatar': 'https://i.pravatar.cc/150?img=2',
      'username': '@bob',
      'name': 'Bob',
      'verified': false,
    },
  ];
  final List<Map<String, dynamic>> recentContacts = [
    {
      'avatar': 'https://i.pravatar.cc/150?img=3',
      'username': '@carol',
      'name': 'Carol',
      'verified': true,
    },
    {
      'avatar': 'https://i.pravatar.cc/150?img=4',
      'username': '@dave',
      'name': 'Dave',
      'verified': false,
    },
  ];
  final List<String> currencies = ['USD', 'EUR', 'USDT', 'BRL'];
  final List<String> frequencies = ['Weekly', 'Bi-weekly', 'Monthly', 'Custom'];

  void nextStep() {
    if (_step < 5) {
      setState(() => _step++);
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void prevStep() {
    if (_step > 0) {
      setState(() => _step--);
      _controller.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void selectRecipientAndNext(String username) {
    setState(() {
      selectedUsername = username;
      _step = 1;
      _controller.animateToPage(
        1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lace,
      appBar: AppBar(
        backgroundColor: AppColors.lace,
        elevation: 0,
        title: const Text('Set Recurring Transfer'),
        centerTitle: true,
        leading: _step > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: prevStep,
                color: Theme.of(context).appBarTheme.foregroundColor,
              )
            : null,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: PageView(
            controller: _controller,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              _ChooseRecipientStep(
                favoriteContacts: favoriteContacts,
                recentContacts: recentContacts,
                onSelect: selectRecipientAndNext,
              ),
              _EnterAmountStep(
                recipientUsername: selectedUsername,
                amount: enteredAmount,
                currency: selectedCurrency,
                currencies: currencies,
                onAmountChanged: (v) => setState(() => enteredAmount = v),
                onCurrencyChanged: (v) {
                  if (v != null) setState(() => selectedCurrency = v);
                },
              ),
              _FrequencyStep(
                frequency: frequency,
                frequencies: frequencies,
                startDate: startDate,
                endDate: endDate,
                onFrequencyChanged: (v) => setState(() => frequency = v),
                onStartDateChanged: (v) => setState(() => startDate = v),
                onEndDateChanged: (v) => setState(() => endDate = v),
              ),
              _FXOptionStep(
                fxOption: fxOption,
                onOptionChanged: (v) => setState(() => fxOption = v),
              ),
              _ReviewStep(
                recipientUsername: selectedUsername,
                amount: enteredAmount,
                currency: selectedCurrency,
                frequency: frequency,
                startDate: startDate,
                endDate: endDate,
                fxOption: fxOption,
                onEdit: (step) {
                  setState(() {
                    _step = step;
                    _controller.jumpToPage(step);
                  });
                },
                onConfirm: nextStep,
              ),
              _SuccessStep(
                recipientUsername: selectedUsername,
                onDone: () =>
                    Navigator.of(context).popUntil((route) => route.isFirst),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            if (_step > 0)
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.deepPurple,
                ),
                onPressed: prevStep,
              ),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: _step == 4 ? nextStep : nextStep,
                child: Text(
                  _step == 4
                      ? 'Set Recurring Transfer'
                      : _step == 5
                      ? 'Done'
                      : 'Next',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Step 1: Choose Recipient ---
class _ChooseRecipientStep extends StatelessWidget {
  final List<Map<String, dynamic>> favoriteContacts;
  final List<Map<String, dynamic>> recentContacts;
  final ValueChanged<String> onSelect;
  const _ChooseRecipientStep({
    required this.favoriteContacts,
    required this.recentContacts,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 0,
            right: 0,
            top: 0,
            bottom: 24 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'Choose Recipient',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.sapphire,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: GlassCard(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 2,
                    ),
                    borderRadius: 18,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search,
                          color: Colors.deepPurple,
                          size: 26,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: 'Search by @username or Name',
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.black38),
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                            ),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'Favorites',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.sapphire,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 80,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: favoriteContacts.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 16),
                    itemBuilder: (context, index) {
                      final contact = favoriteContacts[index];
                      return GestureDetector(
                        onTap: () => onSelect(contact['username']),
                        child: Column(
                          children: [
                            Hero(
                              tag: 'recipient-avatar-${contact['username']}',
                              child: CircleAvatar(
                                radius: 28,
                                backgroundImage: NetworkImage(
                                  contact['avatar'],
                                ),
                                backgroundColor: AppColors.petal,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              contact['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  ),
                ),
                const SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'Recent',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.sapphire,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 80,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: recentContacts.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 16),
                    itemBuilder: (context, index) {
                      final contact = recentContacts[index];
                      return GestureDetector(
                        onTap: () => onSelect(contact['username']),
                        child: Column(
                          children: [
                            Hero(
                              tag: 'recipient-avatar-${contact['username']}',
                              child: CircleAvatar(
                                radius: 28,
                                backgroundImage: NetworkImage(
                                  contact['avatar'],
                                ),
                                backgroundColor: AppColors.petal,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              contact['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// --- Step 2: Enter Amount & Currency ---
class _EnterAmountStep extends StatelessWidget {
  final String recipientUsername;
  final String amount;
  final String currency;
  final List<String> currencies;
  final ValueChanged<String> onAmountChanged;
  final ValueChanged<String?>? onCurrencyChanged;
  const _EnterAmountStep({
    required this.recipientUsername,
    required this.amount,
    required this.currency,
    required this.currencies,
    required this.onAmountChanged,
    required this.onCurrencyChanged,
  });

  @override
  Widget build(BuildContext context) {
    final avatarUrl =
        'https://i.pravatar.cc/150?u=${recipientUsername.replaceAll('@', '')}';
    double baseRate = 0.217; // RM to USD
    if (currency == 'EUR') baseRate = 0.20;
    if (currency == 'USDT') baseRate = 0.215;
    if (currency == 'BRL') baseRate = 1.08;
    final double amt = double.tryParse(amount.isEmpty ? '500' : amount) ?? 500;
    final fxValue = (amt * baseRate).toStringAsFixed(2);
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 0,
            right: 0,
            top: 0,
            bottom: 24 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                Center(
                  child: GlassCard(
                    borderRadius: 24,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 18,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundImage: NetworkImage(avatarUrl),
                          backgroundColor: AppColors.petal,
                        ),
                        const SizedBox(width: 18),
                        Text(
                          recipientUsername,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: AppColors.sapphire,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 36),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Amount to Send',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
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
                              color: AppColors.lavender.withAlpha(
                                (0.15 * 255).round(),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'RM',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.sapphire,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 28,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: AppColors.lace,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 16,
                                ),
                                hintText: '500',
                                hintStyle: const TextStyle(
                                  color: Colors.black26,
                                ),
                              ),
                              onChanged: onAmountChanged,
                              controller: TextEditingController(text: amount),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Recipient's Currency",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: currencies.map((c) {
                            final selected = currency == c;
                            return Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: ChoiceChip(
                                label: Text(
                                  c,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: selected
                                        ? Colors.white
                                        : AppColors.sapphire,
                                  ),
                                ),
                                selected: selected,
                                selectedColor: AppColors.sapphire,
                                backgroundColor: AppColors.lavender.withAlpha(
                                  (0.15 * 255).round(),
                                ),
                                onSelected: (_) => onCurrencyChanged?.call(c),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                elevation: selected ? 2 : 0,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: GlassCard(
                    borderRadius: 18,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 14,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'FX Rate Preview',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'RM $amount → $currency $fxValue',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          '(Live Rate)',
                          style: TextStyle(fontSize: 13, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// --- Step 3: Set Frequency & Start Date ---
class _FrequencyStep extends StatelessWidget {
  final String frequency;
  final List<String> frequencies;
  final DateTime? startDate;
  final DateTime? endDate;
  final ValueChanged<String> onFrequencyChanged;
  final ValueChanged<DateTime> onStartDateChanged;
  final ValueChanged<DateTime?> onEndDateChanged;
  const _FrequencyStep({
    required this.frequency,
    required this.frequencies,
    required this.startDate,
    required this.endDate,
    required this.onFrequencyChanged,
    required this.onStartDateChanged,
    required this.onEndDateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 0,
            right: 0,
            top: 0,
            bottom: 24 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'Set Frequency',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.sapphire,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Wrap(
                    spacing: 14,
                    children: frequencies.map((f) {
                      final selected = frequency == f;
                      return ChoiceChip(
                        label: Text(
                          f,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: selected ? Colors.white : AppColors.sapphire,
                          ),
                        ),
                        selected: selected,
                        selectedColor: AppColors.sapphire,
                        backgroundColor: AppColors.lavender.withAlpha(
                          (0.15 * 255).round(),
                        ),
                        onSelected: (_) => onFrequencyChanged(f),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: selected ? 2 : 0,
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Start Date',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(
                              const Duration(days: 365),
                            ),
                          );
                          if (picked != null) onStartDateChanged(picked);
                        },
                        child: GlassCard(
                          borderRadius: 16,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 14,
                          ),
                          child: Text(
                            startDate != null
                                ? '${startDate!.year}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}'
                                : 'Select date',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        'End Date (optional)',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(
                              const Duration(days: 730),
                            ),
                          );
                          onEndDateChanged(picked);
                        },
                        child: GlassCard(
                          borderRadius: 16,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 14,
                          ),
                          child: Text(
                            endDate != null
                                ? '${endDate!.year}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}'
                                : 'No end date',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// --- Step 4: FX Rate Option ---
class _FXOptionStep extends StatelessWidget {
  final String fxOption;
  final ValueChanged<String> onOptionChanged;
  const _FXOptionStep({required this.fxOption, required this.onOptionChanged});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 0,
            right: 0,
            top: 0,
            bottom: 24 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'FX Rate Option',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.sapphire,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      RadioListTile<String>(
                        value: 'lock',
                        groupValue: fxOption,
                        onChanged: (v) => onOptionChanged(v ?? 'lock'),
                        title: const Text('Lock FX rate now'),
                        subtitle: const Text(
                          'Secure today\'s rate for all future transfers.',
                        ),
                      ),
                      RadioListTile<String>(
                        value: 'market',
                        groupValue: fxOption,
                        onChanged: (v) => onOptionChanged(v ?? 'market'),
                        title: const Text(
                          'Use market rate at time of transfer',
                        ),
                        subtitle: const Text(
                          'Each transfer uses the live FX rate.',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// --- Step 5: Review & Confirm ---
class _ReviewStep extends StatelessWidget {
  final String recipientUsername;
  final String amount;
  final String currency;
  final String frequency;
  final DateTime? startDate;
  final DateTime? endDate;
  final String fxOption;
  final void Function(int step) onEdit;
  final VoidCallback onConfirm;
  const _ReviewStep({
    required this.recipientUsername,
    required this.amount,
    required this.currency,
    required this.frequency,
    required this.startDate,
    required this.endDate,
    required this.fxOption,
    required this.onEdit,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final avatarUrl =
        'https://i.pravatar.cc/150?u=${recipientUsername.replaceAll('@', '')}';
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 0,
            right: 0,
            top: 0,
            bottom: 24 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                Center(
                  child: GlassCard(
                    borderRadius: 24,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 18,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundImage: NetworkImage(avatarUrl),
                          backgroundColor: AppColors.petal,
                        ),
                        const SizedBox(width: 18),
                        Text(
                          recipientUsername,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: AppColors.sapphire,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 36),
                GlassCard(
                  borderRadius: 18,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ReviewRow(
                        label: 'Amount',
                        value: 'RM $amount',
                        onEdit: () => onEdit(1),
                      ),
                      _ReviewRow(
                        label: 'Currency',
                        value: currency,
                        onEdit: () => onEdit(1),
                      ),
                      _ReviewRow(
                        label: 'Frequency',
                        value: frequency,
                        onEdit: () => onEdit(2),
                      ),
                      _ReviewRow(
                        label: 'Start Date',
                        value: startDate != null
                            ? '${startDate!.year}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}'
                            : '-',
                        onEdit: () => onEdit(2),
                      ),
                      _ReviewRow(
                        label: 'End Date',
                        value: endDate != null
                            ? '${endDate!.year}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}'
                            : '-',
                        onEdit: () => onEdit(2),
                      ),
                      _ReviewRow(
                        label: 'FX Option',
                        value: fxOption == 'lock'
                            ? 'Locked Rate'
                            : 'Market Rate',
                        onEdit: () => onEdit(3),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 2,
                  ),
                  onPressed: onConfirm,
                  child: const Text(
                    'Set Recurring Transfer',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ReviewRow extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onEdit;
  const _ReviewRow({
    required this.label,
    required this.value,
    required this.onEdit,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: const TextStyle(fontSize: 15, color: Colors.black54),
          ),
          Row(
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.edit,
                  size: 16,
                  color: Colors.deepPurple,
                ),
                onPressed: onEdit,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// --- Step 6: Success Animation ---
class _SuccessStep extends StatelessWidget {
  final String recipientUsername;
  final VoidCallback onDone;
  const _SuccessStep({required this.recipientUsername, required this.onDone});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green.withAlpha((0.15 * 255).round()),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withAlpha((0.18 * 255).round()),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Icon(
              Icons.check_rounded,
              color: Colors.green,
              size: 60,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Recurring Transfer Set! 🎉',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.green[700],
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'You have set up a recurring transfer to $recipientUsername',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.sapphire,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: onDone,
            child: const Text(
              'Done',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
