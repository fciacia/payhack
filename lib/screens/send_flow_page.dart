import 'package:flutter/material.dart';
import '../app_colors.dart';
import 'widgets/glass_card.dart';

class SendFlowPage extends StatefulWidget {
  const SendFlowPage({super.key});

  @override
  State<SendFlowPage> createState() => _SendFlowPageState();
}

class _SendFlowPageState extends State<SendFlowPage> {
  final PageController _controller = PageController();
  int _step = 0;

  // Demo state
  String selectedUsername = '@alice';
  String enteredAmount = '500';
  String selectedCurrency = 'USD';
  bool lockFx = true;
  bool showRouteModal = false;

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

  void nextStep() {
    if (_step < 6) {
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
      _step = 2;
      _controller.animateToPage(
        2,
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
        title: Text(
          'Send Money',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
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
                onScanQR: () => setState(() => _step = 1),
              ),
              _QRCodeStep(username: selectedUsername),
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
              _GlassTransactionStep(
                onSeeRoute: () {
                  // Show route modal or call previous logic
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    backgroundColor: AppColors.lace,
                    builder: (context) => Container(
                      padding: const EdgeInsets.all(28),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              width: 40,
                              height: 4,
                              decoration: BoxDecoration(
                                color: AppColors.petal,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                          const SizedBox(height: 18),
                          Text(
                            'Transfer Route',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  color: AppColors.sapphire,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 18),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.account_balance_wallet,
                                  color: AppColors.sapphire,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Your Wallet',
                                  style: TextStyle(color: AppColors.sapphire),
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.arrow_forward,
                                  color: AppColors.sapphire,
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.currency_exchange,
                                  color: AppColors.sapphire,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'FX Provider',
                                  style: TextStyle(color: AppColors.sapphire),
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.arrow_forward,
                                  color: AppColors.sapphire,
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.account_balance,
                                  color: AppColors.sapphire,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Recipient Bank',
                                  style: TextStyle(color: AppColors.sapphire),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'This is the optimal route for your transfer, ensuring the best FX rate and lowest fees.',
                            style: TextStyle(
                              color: AppColors.sapphire.withAlpha(
                                (0.7 * 255).round(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                onPay: () {
                  // Navigate to congratulations/final confirmation step
                  setState(() => _step = 8);
                  _controller.animateToPage(
                    8,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                },
              ),
              _FXRatePreviewStep(
                amount: enteredAmount,
                currency: selectedCurrency,
              ),
              _ConfirmationStep(
                onSeeRoute: () => setState(() => showRouteModal = true),
                onPayNow: () {
                  // Skip scheduled transfer and recurring confirmation, go straight to congrats
                  setState(
                    () => _step = 8,
                  ); // _FinalConfirmationStep is at index 8
                },
              ),
              _FinalConfirmationStep(recipientUsername: selectedUsername),
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
                onPressed: nextStep,
                child: Text(
                  _step == 5
                      ? 'Set Recurring'
                      : _step == 6
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

  String _calculateFXValue(String amount, String currency) {
    double baseRate = 0.217; // RM to USD
    if (currency == 'EUR') baseRate = 0.20;
    if (currency == 'USDT') baseRate = 0.215;
    if (currency == 'BRL') baseRate = 1.08;
    final double amt = double.tryParse(amount.isEmpty ? '500' : amount) ?? 500;
    return (amt * baseRate).toStringAsFixed(2);
  }

  String _calculateFXRate(String currency) {
    double baseRate = 0.217; // RM to USD
    if (currency == 'EUR') baseRate = 0.20;
    if (currency == 'USDT') baseRate = 0.215;
    if (currency == 'BRL') baseRate = 1.08;
    return '1 RM = $baseRate $currency';
  }
}

// --- Step 1: Choose Recipient ---
class _ChooseRecipientStep extends StatefulWidget {
  final List<Map<String, dynamic>> favoriteContacts;
  final List<Map<String, dynamic>> recentContacts;
  final ValueChanged<String> onSelect;
  final VoidCallback onScanQR;
  const _ChooseRecipientStep({
    required this.favoriteContacts,
    required this.recentContacts,
    required this.onSelect,
    required this.onScanQR,
  });

  @override
  State<_ChooseRecipientStep> createState() => _ChooseRecipientStepState();
}

class _ChooseRecipientStepState extends State<_ChooseRecipientStep> {
  String _search = '';

  @override
  Widget build(BuildContext context) {
    final searchLower = _search.toLowerCase();
    final filteredRecent = widget.recentContacts
        .where(
          (c) =>
              c['name'].toString().toLowerCase().contains(searchLower) ||
              c['username'].toString().toLowerCase().contains(searchLower),
        )
        .toList();
    final filteredContacts = widget.favoriteContacts
        .where(
          (c) =>
              c['name'].toString().toLowerCase().contains(searchLower) ||
              c['username'].toString().toLowerCase().contains(searchLower),
        )
        .toList();

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 0,
              right: 0,
              top: 32,
              bottom: 24 + MediaQuery.of(context).viewInsets.bottom,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Text(
                      'Send Money',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            color: AppColors.sapphire,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            letterSpacing: 0.5,
                          ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.lace,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.sapphire.withAlpha(
                              (0.07 * 255).round(),
                            ),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 12, right: 8),
                            child: Icon(
                              Icons.search,
                              color: AppColors.sapphire,
                              size: 28,
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              onChanged: (v) => setState(() => _search = v),
                              decoration: const InputDecoration(
                                hintText: 'Search by @username or Name',
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: AppColors.sapphire,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                              ),
                              style: const TextStyle(
                                fontSize: 17,
                                color: AppColors.sapphire,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () =>
                                Navigator.pushNamed(context, '/qr_scanner'),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeInOut,
                              decoration: BoxDecoration(
                                color: AppColors.petal,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.sapphire.withAlpha(
                                      (0.09 * 255).round(),
                                    ),
                                    blurRadius: 14,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 22),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(
                                    Icons.qr_code_scanner,
                                    color: AppColors.sapphire,
                                    size: 34,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Scan QR',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.sapphire,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () =>
                                Navigator.pushNamed(context, '/my_qr_code'),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeInOut,
                              decoration: BoxDecoration(
                                color: AppColors.petal,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.sapphire.withAlpha(
                                      (0.09 * 255).round(),
                                    ),
                                    blurRadius: 14,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 22),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(
                                    Icons.qr_code_2,
                                    color: AppColors.sapphire,
                                    size: 34,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'My QR Code',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.sapphire,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Share your @username or QR to receive',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.sapphire,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  if (filteredRecent.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      child: Text(
                        'Recent Recipients',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.sapphire,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      child: Row(
                        children: [
                          for (int i = 0; i < filteredRecent.length; i++) ...[
                            GestureDetector(
                              onTap: () => widget.onSelect(
                                filteredRecent[i]['username'],
                              ),
                              child: Column(
                                children: [
                                  ClipOval(
                                    child:
                                        filteredRecent[i]['avatar'] != null &&
                                            filteredRecent[i]['avatar']
                                                .toString()
                                                .isNotEmpty
                                        ? Image.network(
                                            filteredRecent[i]['avatar'],
                                            width: 64,
                                            height: 64,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    Container(
                                                      width: 64,
                                                      height: 64,
                                                      color: AppColors.lace,
                                                      child: Icon(
                                                        Icons.person,
                                                        color:
                                                            AppColors.sapphire,
                                                        size: 32,
                                                      ),
                                                    ),
                                          )
                                        : Container(
                                            width: 64,
                                            height: 64,
                                            color: AppColors.lace,
                                            child: Icon(
                                              Icons.person,
                                              color: AppColors.sapphire,
                                              size: 32,
                                            ),
                                          ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    filteredRecent[i]['name'],
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.sapphire,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (i != filteredRecent.length - 1)
                              const SizedBox(width: 18),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Text(
                      'All Contacts',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.sapphire,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredContacts.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 18),
                      itemBuilder: (context, index) {
                        final contact = filteredContacts[index];
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          decoration: BoxDecoration(
                            color: AppColors.lace,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.sapphire.withAlpha(
                                  (0.07 * 255).round(),
                                ),
                                blurRadius: 14,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: ClipOval(
                              child:
                                  contact['avatar'] != null &&
                                      contact['avatar'].toString().isNotEmpty
                                  ? Image.network(
                                      contact['avatar'],
                                      width: 48,
                                      height: 48,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Container(
                                                width: 48,
                                                height: 48,
                                                color: AppColors.lace,
                                                child: Icon(
                                                  Icons.person,
                                                  color: AppColors.sapphire,
                                                  size: 24,
                                                ),
                                              ),
                                    )
                                  : Container(
                                      width: 48,
                                      height: 48,
                                      color: AppColors.lace,
                                      child: Icon(
                                        Icons.person,
                                        color: AppColors.sapphire,
                                        size: 24,
                                      ),
                                    ),
                            ),
                            title: Text(
                              contact['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.sapphire,
                              ),
                            ),
                            subtitle: Text(
                              contact['username'],
                              style: const TextStyle(color: AppColors.sapphire),
                            ),
                            onTap: () => widget.onSelect(contact['username']),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _GlassSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withAlpha((0.15 * 255).round()),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.08 * 255).round()),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search by @username',
          hintStyle: const TextStyle(color: Colors.white70),
          prefixIcon: const Icon(Icons.search, color: Colors.white70),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

class _ContactList extends StatelessWidget {
  final List<Map<String, dynamic>> contacts;
  final ValueChanged<String> onSelect;
  const _ContactList({required this.contacts, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: contacts.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final contact = contacts[index];
        return GestureDetector(
          onTap: () => onSelect(contact['username']),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withAlpha((0.18 * 255).round()),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha((0.06 * 255).round()),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(contact['avatar']),
                  radius: 24,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            contact['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                          ),
                          if (contact['verified']) ...[
                            const SizedBox(width: 6),
                            const Icon(
                              Icons.verified,
                              color: Colors.blue,
                              size: 18,
                            ),
                          ],
                        ],
                      ),
                      Text(
                        contact['username'],
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.star,
                  color: contact['verified'] ? Colors.amber : Colors.grey[400],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// --- Step 2: QR Code Generator ---
class _QRCodeStep extends StatelessWidget {
  final String username;
  const _QRCodeStep({required this.username});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha((0.18 * 255).round()),
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha((0.08 * 255).round()),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Center(
              child: Icon(Icons.qr_code_2, size: 140, color: Colors.white70),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            username,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _GlassIconButton(icon: Icons.copy, label: 'Copy', onTap: () {}),
              const SizedBox(width: 18),
              _GlassIconButton(icon: Icons.share, label: 'Share', onTap: () {}),
            ],
          ),
        ],
      ),
    );
  }
}

class _GlassIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _GlassIconButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha((0.15 * 255).round()),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.08 * 255).round()),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Step 3: Enter Amount ---
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
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.lace, AppColors.petal],
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
            // Recipient Card with animation
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.85, end: 1),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutBack,
              builder: (context, scale, child) =>
                  Transform.scale(scale: scale, child: child),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.lace,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.sapphire.withAlpha(
                          (0.10 * 255).round(),
                        ),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 20,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipOval(
                        child: Image.network(
                          avatarUrl,
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                width: 56,
                                height: 56,
                                color: AppColors.lace,
                                child: Icon(
                                  Icons.person,
                                  color: AppColors.sapphire,
                                  size: 32,
                                ),
                              ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        recipientUsername,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.sapphire,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Amount Input with animation
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.85, end: 1),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutBack,
              builder: (context, scale, child) =>
                  Transform.scale(scale: scale, child: child),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Amount to Send',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: AppColors.sapphire,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.petal,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.sapphire.withAlpha(
                                  (0.08 * 255).round(),
                                ),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Text(
                            'RM',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.sapphire,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.lace,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.sapphire.withAlpha(
                                    (0.06 * 255).round(),
                                  ),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                              border: Border.all(
                                color: AppColors.sapphire.withAlpha(
                                  (0.18 * 255).round(),
                                ),
                              ),
                            ),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 28,
                                color: AppColors.sapphire,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                filled: true,
                                fillColor: Colors.transparent,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 18,
                                ),
                                hintText: '500',
                                hintStyle: TextStyle(
                                  color: AppColors.sapphire,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              onChanged: onAmountChanged,
                              controller: TextEditingController(text: amount),
                            ),
                          ),
                        ),
                      ],
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
                    "Recipient's Currency",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: AppColors.sapphire,
                    ),
                  ),
                  const SizedBox(height: 14),
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
                                    ? AppColors.lace
                                    : AppColors.sapphire,
                                fontSize: 16,
                              ),
                            ),
                            selected: selected,
                            selectedColor: AppColors.sapphire,
                            backgroundColor: AppColors.petal,
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
                  const SizedBox(height: 18),
                  // FX Value summary box
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 18,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.petal,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.sapphire.withAlpha(20),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Converted Amount',
                          style: TextStyle(
                            color: AppColors.sapphire.withAlpha(
                              (0.7 * 255).round(),
                            ),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'RM $amount → $currency $fxValue',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.sapphire,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

// --- Step 4: FX Rate Preview ---
class _FXRatePreviewStep extends StatelessWidget {
  final String amount;
  final String currency;
  const _FXRatePreviewStep({required this.amount, required this.currency});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
        decoration: BoxDecoration(
          color: AppColors.petal.withAlpha((0.18 * 255).round()),
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: AppColors.sapphire.withAlpha((0.18 * 255).round()),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'FX Rate Preview',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.sapphire,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'RM $amount → $currency 108.50',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.sapphire,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '(Live Rate)',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.sapphire,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Step 5: Glass Transaction Step ---
class _GlassTransactionStep extends StatelessWidget {
  final VoidCallback onSeeRoute;
  final VoidCallback onPay;
  const _GlassTransactionStep({required this.onSeeRoute, required this.onPay});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        decoration: BoxDecoration(
          color: AppColors.petal.withAlpha((0.18 * 255).round()),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: AppColors.sapphire.withAlpha((0.10 * 255).round()),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Pay using glass transaction?',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.sapphire,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 18),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.info_outline, color: AppColors.petal),
                  SizedBox(width: 8),
                  Text(
                    'You are saving RM12 vs bank FX rate',
                    style: TextStyle(
                      color: AppColors.sapphire,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onSeeRoute,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.sapphire,
                foregroundColor: AppColors.lace,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 2,
              ),
              child: const Text(
                'See Route',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onPay,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: AppColors.lace,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 2,
              ),
              child: const Text(
                'Pay Now',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Step 6: Confirmation ---
class _ConfirmationStep extends StatelessWidget {
  final VoidCallback onSeeRoute;
  final VoidCallback onPayNow;
  const _ConfirmationStep({required this.onSeeRoute, required this.onPayNow});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha((0.18 * 255).round()),
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.withAlpha((0.18 * 255).round()),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Pay using glass transaction?',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.sapphire,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.info_outline, color: Colors.amber, size: 22),
                const SizedBox(width: 8),
                Tooltip(
                  message: "You are saving RM12 vs bank FX rate",
                  child: Text(
                    'You are saving RM12 vs bank FX rate',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.deepPurple),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: onSeeRoute,
              child: const Text(
                'See Route',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: onPayNow,
              child: const Text(
                'Pay Now',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Step 7: Final Confirmation ---
class _FinalConfirmationStep extends StatelessWidget {
  final String recipientUsername;
  const _FinalConfirmationStep({required this.recipientUsername});

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
            'Congrats! 🎉',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.green[700],
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'You have successfully transferred to $recipientUsername',
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
            onPressed: () =>
                Navigator.of(context).popUntil((route) => route.isFirst),
            child: const Text(
              'Back to Home',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

// Smart Insights Tooltip Icon and Modal
class _SmartInsightsInfoIcon extends StatelessWidget {
  const _SmartInsightsInfoIcon();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            backgroundColor: Colors.white.withAlpha((0.85 * 255).round()),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: Colors.deepPurple,
                    size: 28,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'You are saving RM12 vs bank FX rate',
                      style: TextStyle(
                        color: Colors.deepPurple[900],
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.deepPurple.withAlpha((0.10 * 255).round()),
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(6),
        child: const Icon(
          Icons.info_outline,
          color: Colors.deepPurple,
          size: 20,
        ),
      ),
    );
  }
}

// 1. Scheduled Transfers List Screen Stub
class ScheduledTransfersListScreen extends StatelessWidget {
  const ScheduledTransfersListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scheduled Transfers'),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      body: Center(
        child: GlassCard(
          borderRadius: 28,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
          child: const Text(
            'No scheduled transfers yet. (Demo stub)',
            style: TextStyle(fontSize: 18, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
