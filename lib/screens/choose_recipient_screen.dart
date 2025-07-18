import 'package:flutter/material.dart';
import '../app_colors.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String selectedCurrency = 'JPY';
  String username = '@username'; // Dynamic username
  bool showOriginalCurrency = false;
  bool _travelerPopupShown = false;

  // Mock data for wallet assets
  final List<Map<String, dynamic>> walletAssets = [
    {
      'name': 'MYR',
      'balance': 'RM10,000', // Reduced amount
      'icon': Icons.attach_money,
      'color': Colors.green,
      'trend': 'up',
    },
    {
      'name': 'USD',
      'balance': '\$27,000',
      'icon': Icons.attach_money,
      'color': Colors.blue,
      'trend': 'up',
    },
    {
      'name': 'USDT',
      'balance': '10,000',
      'icon': Icons.currency_bitcoin,
      'color': Colors.teal,
      'trend': 'down',
    },
    {
      'name': 'Gold',
      'balance': '50 oz',
      'icon': Icons.monetization_on,
      'color': Colors.amber,
      'trend': 'up',
      'esgTag': 'Ethically Sourced',
      'esgIcon': Icons.eco,
    },
    {
      'name': 'Basket',
      'balance': '1,000',
      'icon': Icons.shopping_basket,
      'color': Colors.purple,
      'trend': 'stable',
      'esgTag': 'Sustainable Assets',
      'esgIcon': Icons.eco,
    },
  ];

  // Mock transaction history
  final List<Map<String, dynamic>> recentTransactions = [
    {
      'type': 'sent',
      'recipient': '@Felicia',
      'amount': 'RM500',
      'converted': 'USD 108.50',
      'route': 'Polygon → Chainlink → Avalanche → Bank',
      'time': '2 hours ago',
      'icon': Icons.send,
      'color': Colors.red,
      'isGreen': false,
      'category': 'Local Business',
      'amountValue': 500,
      'carbonFootprint': 0.12, // kg CO2
      'merchantEcoTags': [],
    },
    {
      'type': 'received',
      'recipient': '@200',
      'amount': 'RM200',
      'converted': 'JPY 30,000',
      'route': 'Bank → Avalanche',
      'time': '1 day ago',
      'icon': Icons.call_received,
      'color': Colors.green,
      'isGreen': true,
      'category': 'Public Transport',
      'amountValue': 200,
      'carbonFootprint': 0.03, // kg CO2
      'merchantEcoTags': ["plastic-free", "local"],
    },
    {
      'type': 'converted',
      'recipient': 'MYR → USD',
      'amount': 'RM1,000',
      'converted': 'USD 216.50',
      'route': 'Direct Conversion',
      'time': '3 days ago',
      'icon': Icons.swap_horiz,
      'color': Colors.blue,
      'isGreen': true,
      'category': 'EV Charging',
      'amountValue': 1000,
      'carbonFootprint': 0.25, // kg CO2
      'merchantEcoTags': ["carbon-neutral"],
    },
  ];

  // Mock AI suggestions
  final List<String> aiSuggestions = [
    '💡 FX rate to IDR is 3% better this morning!',
    'FX rate for JPY is favorable today',
    'Consider converting to Gold Token - market volatility expected',
  ];

  // --- Green Rewards and Gamified Challenges ---
  int get greenLoyaltyPoints =>
      recentTransactions.where((tx) => tx['isGreen'] == true).length * 10;

  double get greenCashback => recentTransactions
      .where(
        (tx) =>
            tx['category'] == 'Public Transport' ||
            tx['category'] == 'EV Charging',
      )
      .fold(0.0, (sum, tx) => sum + ((tx['amountValue'] ?? 0) * 0.02));

  double get greenSpending => recentTransactions
      .where((tx) => tx['isGreen'] == true)
      .fold(0.0, (sum, tx) => sum + (tx['amountValue'] ?? 0));

  bool get greenOfferUnlocked => greenSpending >= 100;
  String get unlockedOffer => '10% off at EcoBrand (valid until 31/12/2024)';

  int get localBusinessCount => recentTransactions
      .where((tx) => tx['category'] == 'Local Business')
      .length;

  double get donationIncrease => 0.18; // Mock: 18% increase this month

  List<Map<String, dynamic>> get challenges => [
    {
      'title': 'Reduce your plastic footprint by 10%',
      'progress': 0.7, // 70% complete (mock)
      'reward': 'Plastic-Free Hero Badge',
      'completed': false,
    },
    {
      'title': 'Support 5 local businesses this week',
      'progress': (localBusinessCount / 5).clamp(0.0, 1.0),
      'reward': 'RM5 Bonus',
      'completed': localBusinessCount >= 5,
    },
    {
      'title': 'Increase donations by 15%',
      'progress': (donationIncrease / 0.15).clamp(0.0, 1.0),
      'reward': 'Entry to Eco Draw',
      'completed': donationIncrease >= 0.15,
    },
  ];

  List<Map<String, dynamic>> get earnedBadges => [
    if (challenges[0]['completed'])
      {
        'icon': Icons.eco,
        'label': 'Plastic-Free Hero',
        'desc': 'Reduced plastic footprint by 10% in a month.',
      },
    if (challenges[1]['completed'])
      {
        'icon': Icons.store,
        'label': 'Local Supporter',
        'desc': 'Supported 5 local businesses in a week.',
      },
    if (challenges[2]['completed'])
      {
        'icon': Icons.volunteer_activism,
        'label': 'Donation Champ',
        'desc': 'Increased donations to social causes by 15%.',
      },
  ];

  bool get liteModeEnabled {
    // This should be lifted to app state or passed via InheritedWidget/Provider for real apps
    // For demo, just return false or read from settings if available
    // Here, we use a static value for demonstration
    return false; // Replace with actual state management
  }

  @override
  Widget build(BuildContext context) {
    if (liteModeEnabled) {
      return Scaffold(
        appBar: AppBar(title: const Text('Eco-Pulse Lite')),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                color: Colors.yellow[100],
                child: const Text(
                  'Lite Mode: Simplified for low data/feature phones',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              _buildWalletCardsSection(),
              const SizedBox(height: 20),
              const Text(
                'Recent Transactions',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView(
                  children: recentTransactions
                      .map(
                        (tx) => ListTile(
                          leading: Icon(tx['icon'], color: tx['color']),
                          title: Text('${tx['amount']} to ${tx['recipient']}'),
                          subtitle: EcoTagWidget(
                            carbonFootprint: tx['isGreen'] == true
                                ? 0.03
                                : 0.15, // mock
                            ethicalScore: tx['isGreen'] == true ? 8.0 : 5.0,
                            socialImpact: tx['category'] == 'Local Business'
                                ? 'Local Support'
                                : null,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                icon: const Icon(Icons.school),
                label: const Text('Educational Modules'),
                onPressed: () =>
                    Navigator.pushNamed(context, '/educational_modules'),
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Hi, $username',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            // TEMP: Dev navigation buttons
            // Remove the following block (the horizontal row of dev navigation buttons):
            // Container(
            //   margin: const EdgeInsets.only(bottom: 8),
            //   padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
            //   decoration: BoxDecoration(
            //     color: AppColors.lace.withAlpha((0.7 * 255).round()),
            //     borderRadius: BorderRadius.circular(20),
            //   ),
            //   child: SingleChildScrollView(
            //     scrollDirection: Axis.horizontal,
            //     child: Row(
            //       children: [
            //         _FancyNavButton(
            //           label: 'Chain Selection',
            //           onTap: () => Navigator.pushNamed(context, '/chain_selection'),
            //         ),
            //         const SizedBox(width: 14),
            //         _FancyNavButton(
            //           label: 'Bridge Status',
            //           onTap: () => Navigator.pushNamed(context, '/bridge_status'),
            //         ),
            //         const SizedBox(width: 14),
            //         _FancyNavButton(
            //           label: 'Gas Fee Comparison',
            //           onTap: () => Navigator.pushNamed(context, '/gas_fee_comparison'),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            const SizedBox(height: 10),

            // Multi-Asset Wallet Cards
            _buildWalletCardsSection(),

            // My Green Savings Stash (Lockbox)
            const SizedBox(height: 18),
            _buildGreenSavingsStash(),

            const SizedBox(height: 20),

            // Geo-Aware Balance Info
            _buildGeoAwareBalanceSection(),

            const SizedBox(height: 20),

            // AI Suggestions Panel
            _buildAISuggestionsPanel(),

            // Impact Score Card
            const SizedBox(height: 20),
            _buildImpactScoreCard(),

            // Green Rewards Card
            const SizedBox(height: 20),
            _buildGreenRewardsCard(context),

            // Gamified Challenges
            const SizedBox(height: 20),
            _buildChallengesSection(context),

            // Badge Gallery
            const SizedBox(height: 20),
            _buildBadgeGallery(context),

            const SizedBox(height: 20),

            // Navigation Buttons
            _buildNavigationButtons(),

            const SizedBox(height: 20),

            // Transaction History
            _buildTransactionHistorySection(),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildWalletCardsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Multi-Asset Wallet',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: walletAssets.length,
            itemBuilder: (context, index) {
              final asset = walletAssets[index];
              return _buildWalletCard(asset);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildWalletCard(Map<String, dynamic> asset) {
    return Container(
      width: 180,
      height: 150,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withAlpha((0.08 * 255).round()),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Currency code as title
          Text(
            asset['name'],
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: asset['color'],
            ),
          ),
          const SizedBox(height: 8),
          // Balance
          Text(
            asset['balance'],
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const Spacer(),
          // Convert button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple[50],
                foregroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8),
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {},
              child: const Text('Convert'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendIndicator(String trend) {
    IconData icon;
    Color color;

    switch (trend) {
      case 'up':
        icon = Icons.trending_up;
        color = Colors.green;
        break;
      case 'down':
        icon = Icons.trending_down;
        color = Colors.red;
        break;
      default:
        icon = Icons.trending_flat;
        color = Colors.grey;
    }

    return Icon(icon, color: color, size: 16);
  }

  Widget _buildGreenSavingsStash() {
    // Mock: Green stablecoins and gold tokens locked
    final List<Map<String, String>> lockedAssets = [
      {
        'name': 'Green Stablecoin',
        'amount': 'THB 5,000',
        'desc': 'Supports local reforestation',
      },
      {
        'name': 'Ethically Sourced Gold',
        'amount': '10 oz',
        'desc': 'Certified sustainable mining',
      },
    ];
    return Card(
      color: Colors.green[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.lock, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  'My Green Savings Stash 🔐',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ...lockedAssets.map(
              (asset) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.eco, color: Colors.green[700], size: 18),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${asset['amount']} ${asset['name']}',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            asset['desc']!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.green,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGeoAwareBalanceSection() {
    String displayBalance;
    if (showOriginalCurrency) {
      displayBalance = 'RM100,000,000';
    } else if (selectedCurrency == 'USD') {
      displayBalance = '\$27,000';
    } else if (selectedCurrency == 'JPY') {
      displayBalance = '¥3,200,000,000';
    } else {
      displayBalance = 'RM100,000,000';
    }
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withAlpha((0.08 * 255).round()),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const Icon(Icons.pin_drop, size: 18, color: Colors.deepPurple),
                const SizedBox(width: 6),
                const Text(
                  '🇯🇵 Showing in JPY (based on your location)',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    setState(() {
                      showOriginalCurrency = !showOriginalCurrency;
                    });
                  },
                  child: Text(
                    showOriginalCurrency
                        ? 'View in JPY'
                        : 'View in Original Currency',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Flexible(
                child: Text(
                  displayBalance,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              _buildCurrencyToggle(),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Total Balance',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyToggle() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildCurrencyChip('MYR', showOriginalCurrency),
          _buildCurrencyChip(
            'USD',
            !showOriginalCurrency && selectedCurrency == 'USD',
          ),
          _buildCurrencyChip(
            'JPY',
            !showOriginalCurrency && selectedCurrency == 'JPY',
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyChip(String currency, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (currency == 'MYR') {
            showOriginalCurrency = true;
          } else {
            showOriginalCurrency = false;
            selectedCurrency = currency;
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? Colors.deepPurple : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          currency,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.grey[600],
          ),
        ),
      ),
    );
  }

  Widget _buildAISuggestionsPanel() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.deepPurple.withAlpha((0.07 * 255).round()),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.deepPurple.withAlpha((0.1 * 255).round()),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.lightbulb, color: Colors.amber, size: 20),
              const SizedBox(width: 8),
              const Text(
                'AI Suggestions',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(aiSuggestions[0], style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 8),
          Text(aiSuggestions[1], style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 8),
          // ESG/Green suggestions
          const Text(
            '💡 Your spending on Food & Beverage could be greener! Explore sustainable merchants.',
            style: TextStyle(fontSize: 14, color: Colors.green),
          ),
          const SizedBox(height: 4),
          const Text(
            '💡 You\'re almost at your monthly CO₂ reduction goal!',
            style: TextStyle(fontSize: 14, color: Colors.green),
          ),
          const SizedBox(height: 8),
          Text(
            '💡 Convert to Green Stablecoin for your THB spending? Your investment supports local green initiatives.',
            style: const TextStyle(fontSize: 14, color: Colors.green),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Showing cheapest route...'),
                      ),
                    );
                  },
                  child: const Text('Show Cheapest Route'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/impact_dashboard');
                  },
                  child: const Text('View My Impact'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Impact Score Card with Pie Chart ---
  Widget _buildImpactScoreCard() {
    // Mock data for demo
    final int impactScore = 87;
    final double progress = 0.87;
    final Map<String, double> breakdown = {
      'Carbon': 40,
      'Ethical': 35,
      'Social': 25,
    };
    return Card(
      color: Colors.green[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tree/plant graphic (simple emoji for demo)
            const Text('🌳', style: TextStyle(fontSize: 36)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Impact Score',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '$impactScore',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 2),
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.green[100],
                    color: Colors.green,
                    minHeight: 7,
                  ),
                  const SizedBox(height: 16), // Increased space before pie chart
                  // Pie chart and legend in a row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 32, // smaller pie chart
                        width: 32,
                        child: CustomPaint(
                          painter: _ImpactPieChartPainter(breakdown),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _legendDot(Colors.green, 'Carbon'),
                          const SizedBox(height: 2),
                          _legendDot(Colors.blue, 'Ethical'),
                          const SizedBox(height: 2),
                          _legendDot(Colors.amber, 'Social'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGreenRewardsCard(BuildContext context) {
    return Card(
      color: Colors.lightGreen[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.emoji_events, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  'Green Rewards',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.loyalty, color: Colors.green, size: 18),
                const SizedBox(width: 6),
                Text(
                  'Loyalty Points: $greenLoyaltyPoints',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.attach_money, color: Colors.green, size: 18),
                const SizedBox(width: 6),
                Text(
                  'Green Cashback: RM${greenCashback.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (greenOfferUnlocked)
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('🎉 Exclusive Green Offer!'),
                      content: Text(unlockedOffer),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.local_offer, color: Colors.green),
                      SizedBox(width: 6),
                      Text(
                        'Unlocked Offer!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (!greenOfferUnlocked)
              const Text(
                'Spend more at green merchants to unlock exclusive offers!',
                style: TextStyle(fontSize: 13, color: Colors.green),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildChallengesSection(BuildContext context) {
    return Card(
      color: Colors.blue[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.flag, color: Colors.blue),
                SizedBox(width: 8),
                Text(
                  'Your Challenges',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ...challenges.map(
              (challenge) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Card(
                  color: challenge['completed']
                      ? Colors.green[100]
                      : Colors.white,
                  child: ListTile(
                    leading: Icon(
                      challenge['completed'] ? Icons.emoji_events : Icons.flag,
                      color: challenge['completed']
                          ? Colors.green
                          : Colors.blue,
                    ),
                    title: Text(
                      challenge['title'],
                      style: const TextStyle(fontSize: 14),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LinearProgressIndicator(
                          value: (challenge['progress'] as double).clamp(
                            0.0,
                            1.0,
                          ),
                          backgroundColor: Colors.blue[50],
                          color: challenge['completed']
                              ? Colors.green
                              : Colors.blue,
                          minHeight: 8,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Reward: ${challenge['reward']}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    trailing: challenge['completed']
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : null,
                    onTap: () {
                      if (challenge['completed']) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('🎉 Challenge Complete!'),
                            content: Text('You earned: ${challenge['reward']}'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadgeGallery(BuildContext context) {
    if (earnedBadges.isEmpty) {
      return Card(
        color: Colors.grey[50],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: const [
              Icon(Icons.emoji_events, color: Colors.grey),
              SizedBox(width: 8),
              Text(
                'No badges earned yet. Complete challenges to earn badges!',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }
    return Card(
      color: Colors.yellow[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.emoji_events, color: Colors.amber),
                SizedBox(width: 8),
                Text(
                  'Your Badges',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 18,
              runSpacing: 12,
              children: earnedBadges
                  .map(
                    (badge) => GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Row(
                              children: [
                                Icon(badge['icon'], color: Colors.amber),
                                const SizedBox(width: 8),
                                Text(
                                  badge['label'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            content: Text(badge['desc']),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.amber[100],
                            child: Icon(
                              badge['icon'] as IconData,
                              color: Colors.amber[800],
                            ),
                            radius: 24,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            badge['label'],
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 24,
      runSpacing: 16,
      children: [
        _buildNavButton(Icons.send, 'Send Money', '/send_flow'),
        _buildNavButton(
          Icons.repeat,
          'Recurring Transfer',
          '/recurring_transfer',
        ),
        _buildNavButton(
          Icons.account_balance_wallet,
          'Receive Money',
          '/receive_funds',
        ),
        _buildNavButton(Icons.request_page, 'Request Money', '/request_money'),
        _buildNavButton(Icons.qr_code_scanner, 'Scan QR', '/my_qr_code'),
        _buildNavButton(Icons.wifi_off, 'Offline Mode', '/offline_mode'),
      ],
    );
  }

  Widget _buildNavButton(IconData icon, String label, String route) {
    return Column(
      children: [
        Ink(
          decoration: ShapeDecoration(
            color: Colors.deepPurple.withAlpha((0.1 * 255).round()),
            shape: const CircleBorder(),
          ),
          child: IconButton(
            icon: Icon(icon, color: Colors.deepPurple),
            onPressed: () => Navigator.pushNamed(context, route),
            iconSize: 32,
          ),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildTransactionHistorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Transactions',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        ...recentTransactions.map(
          (transaction) => _buildTransactionTile(transaction),
        ),
      ],
    );
  }

  Widget _buildTransactionTile(Map<String, dynamic> transaction) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha((0.1 * 255).round()),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: transaction['color'].withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              transaction['icon'],
              color: transaction['color'],
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        transaction['type'] == 'sent'
                            ? 'Sent to ${transaction['recipient']}'
                            : transaction['type'] == 'received'
                            ? 'Received from ${transaction['recipient']}'
                            : transaction['recipient'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Eco-tag icons
                    if (transaction['type'] == 'sent' &&
                        transaction['recipient'] == '@localcafe')
                      const Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: Icon(
                          Icons.coffee,
                          color: Colors.brown,
                          size: 16,
                        ),
                      ),
                    if (transaction['type'] == 'sent' &&
                        transaction['recipient'] == '@globalstore')
                      const Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: Icon(Icons.flight, color: Colors.blue, size: 16),
                      ),
                    if (transaction['type'] == 'converted')
                      const Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: Icon(Icons.eco, color: Colors.green, size: 16),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${transaction['amount']} → ${transaction['converted']}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(height: 2),
                EcoTagWidget(carbonFootprint: transaction['carbonFootprint']),
                // --- Green Merchant Eco-Tags ---
                if (transaction['merchantEcoTags'] != null &&
                    (transaction['merchantEcoTags'] as List).isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: _EcoTagChips(
                      tags: List<String>.from(transaction['merchantEcoTags']),
                    ),
                  ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        transaction['route'],
                        style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                      ),
                    ),
                    // Eco-tag text
                    if (transaction['type'] == 'sent' &&
                        transaction['recipient'] == '@localcafe')
                      const Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: Text(
                          '☕️ Low Carbon Impact',
                          style: TextStyle(fontSize: 10, color: Colors.green),
                        ),
                      ),
                    if (transaction['type'] == 'sent' &&
                        transaction['recipient'] == '@globalstore')
                      const Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: Text(
                          '✈️ High Shipping Carbon',
                          style: TextStyle(fontSize: 10, color: Colors.red),
                        ),
                      ),
                    if (transaction['type'] == 'converted')
                      const Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: Text(
                          '🌱 Micro-donation',
                          style: TextStyle(fontSize: 10, color: Colors.green),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                transaction['amount'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                transaction['time'],
                style: TextStyle(fontSize: 12, color: Colors.grey[500]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FancyNavButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _FancyNavButton({required this.label, required this.onTap});

  @override
  State<_FancyNavButton> createState() => _FancyNavButtonState();
}

class _FancyNavButtonState extends State<_FancyNavButton>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.96),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.sapphire, AppColors.lavender],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: AppColors.sapphire.withAlpha(30),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            widget.label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
    );
  }
}

// --- EcoTagWidget for use in transaction history and checkout ---
class EcoTagWidget extends StatelessWidget {
  final double? carbonFootprint; // in kg CO2
  final double? ethicalScore; // out of 10
  final String? socialImpact; // e.g. 'Supports Local Farmers'
  const EcoTagWidget({
    this.carbonFootprint,
    this.ethicalScore,
    this.socialImpact,
    super.key,
  });

  Color _carbonColor(double value) {
    if (value < 0.05) return Colors.green;
    if (value < 0.15) return Colors.orange;
    return Colors.red;
  }

  String _carbonLabel(double value) {
    if (value < 0.05) return '🟢 Low';
    if (value < 0.15) return '🟡 Medium';
    return '🔴 High';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (carbonFootprint != null)
          Row(
            children: [
              Text(
                _carbonLabel(carbonFootprint!),
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(width: 2),
              Icon(Icons.eco, color: _carbonColor(carbonFootprint!), size: 16),
              const SizedBox(width: 2),
              Text(
                '${carbonFootprint!.toStringAsFixed(2)}kg CO₂',
                style: TextStyle(
                  fontSize: 12,
                  color: _carbonColor(carbonFootprint!),
                ),
              ),
              const SizedBox(width: 6),
            ],
          ),
        if (ethicalScore != null)
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.verified, color: Colors.blue, size: 14),
                    const SizedBox(width: 2),
                    Text(
                      'Fair Labor',
                      style: TextStyle(fontSize: 11, color: Colors.blue[900]),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
            ],
          ),
        if (socialImpact != null)
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.amber[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.volunteer_activism,
                      color: Colors.amber,
                      size: 14,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      socialImpact!,
                      style: TextStyle(fontSize: 11, color: Colors.amber[900]),
                    ),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }
}

class _ImpactPieChartPainter extends CustomPainter {
  final Map<String, double> breakdown;
  _ImpactPieChartPainter(this.breakdown);
  @override
  void paint(Canvas canvas, Size size) {
    final total = breakdown.values.fold(0.0, (a, b) => a + b);
    double start = -90;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 2;
    final colors = [Colors.green, Colors.blue, Colors.amber];
    int i = 0;
    for (final value in breakdown.values) {
      final sweep = 360 * (value / total);
      paint.color = colors[i % colors.length];
      canvas.drawArc(
        Rect.fromLTWH(0, 0, size.width, size.height),
        start * 3.1415926 / 180,
        sweep * 3.1415926 / 180,
        false,
        paint,
      );
      start += sweep;
      i++;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _legendDot(Color color, String label) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      const SizedBox(width: 4),
      Text(label, style: const TextStyle(fontSize: 11)),
    ],
  );
}

// --- Green Merchant Discovery Screen ---
class GreenMerchantDiscoveryScreen extends StatefulWidget {
  const GreenMerchantDiscoveryScreen({super.key});

  @override
  State<GreenMerchantDiscoveryScreen> createState() =>
      _GreenMerchantDiscoveryScreenState();
}

class _GreenMerchantDiscoveryScreenState
    extends State<GreenMerchantDiscoveryScreen> {
  final List<String> allTags = [
    "organic",
    "plastic-free",
    "local",
    "fair-trade",
    "vegan",
    "recycled",
    "carbon-neutral",
  ];
  String? selectedTag;

  final List<Map<String, dynamic>> merchants = [
    {
      'name': 'EcoMart',
      'address': '123 Green St',
      'ecoTags': ["organic", "plastic-free"],
      'distanceKm': 0.5,
      'verified': true,
      'desc': 'Groceries, household, and more. Certified organic.',
    },
    {
      'name': 'Local Roots',
      'address': '456 Farm Rd',
      'ecoTags': ["local", "fair-trade"],
      'distanceKm': 1.2,
      'verified': false,
      'desc': 'Farm-to-table produce and fair-trade coffee.',
    },
    {
      'name': 'Vegan Delights',
      'address': '789 Plant Ave',
      'ecoTags': ["vegan", "carbon-neutral"],
      'distanceKm': 2.0,
      'verified': true,
      'desc': 'Vegan bakery and cafe. Carbon-neutral certified.',
    },
    {
      'name': 'RePlastics',
      'address': '321 Recycle Blvd',
      'ecoTags': ["recycled", "plastic-free"],
      'distanceKm': 2.5,
      'verified': false,
      'desc': 'Plastic-free home goods and recycled products.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filtered = selectedTag == null
        ? merchants
        : merchants.where((m) => m['ecoTags'].contains(selectedTag)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Discover Green Merchants"),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ChoiceChip(
                    label: const Text("All"),
                    selected: selectedTag == null,
                    onSelected: (selected) {
                      setState(() => selectedTag = null);
                    },
                  ),
                ),
                ...allTags.map(
                  (tag) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ChoiceChip(
                      label: Text(tag),
                      selected: selectedTag == tag,
                      onSelected: (selected) {
                        setState(() => selectedTag = selected ? tag : null);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, i) {
                final m = filtered[i];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ListTile(
                    leading: m['verified']
                        ? const Icon(
                            Icons.verified,
                            color: Colors.green,
                            size: 28,
                          )
                        : const Icon(
                            Icons.store,
                            color: Colors.green,
                            size: 28,
                          ),
                    title: Text(
                      m['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          m['address'],
                          style: const TextStyle(fontSize: 13),
                        ),
                        const SizedBox(height: 2),
                        _EcoTagChips(tags: List<String>.from(m['ecoTags'])),
                        const SizedBox(height: 2),
                        Text(
                          m['desc'],
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    trailing: Text(
                      "${m['distanceKm']} km",
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _EcoTagChips extends StatelessWidget {
  final List<String> tags;
  const _EcoTagChips({required this.tags});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      children: tags
          .map(
            (tag) => Chip(
              label: Text(tag, style: const TextStyle(fontSize: 11)),
              backgroundColor: Colors.green[50],
              labelStyle: const TextStyle(color: Colors.green),
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: EdgeInsets.zero,
            ),
          )
          .toList(),
    );
  }
}
