import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String selectedCurrency = 'JPY';
  String username = '@username'; // Dynamic username
  bool showOriginalCurrency = false;

  // Mock data for wallet assets
  final List<Map<String, dynamic>> walletAssets = [
    {
      'name': 'MYR',
      'balance': 'RM100,000,000',
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
    },
    {
      'name': 'Basket',
      'balance': '1,000',
      'icon': Icons.shopping_basket,
      'color': Colors.purple,
      'trend': 'stable',
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
    },
  ];

  // Mock AI suggestions
  final List<String> aiSuggestions = [
    '💡 FX rate to IDR is 3% better this morning!',
    'FX rate for JPY is favorable today',
    'Consider converting to Gold Token - market volatility expected',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('Hi, $username', style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
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
            
            // Multi-Asset Wallet Cards
            _buildWalletCardsSection(),
            
            const SizedBox(height: 20),
            
            // Geo-Aware Balance Info
            _buildGeoAwareBalanceSection(),
            
            const SizedBox(height: 20),
            
            // AI Suggestions Panel
            _buildAISuggestionsPanel(),
            
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
            color: Colors.deepPurple.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: asset['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  asset['icon'],
                  color: asset['color'],
                  size: 16,
                ),
              ),
              const Spacer(),
              _buildTrendIndicator(asset['trend']),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            asset['name'],
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            asset['balance'],
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple.withOpacity(0.1),
                foregroundColor: Colors.deepPurple,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 4),
                textStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                minimumSize: const Size(0, 28),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Convert ${asset['name']}')),
                );
              },
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

  Widget _buildGeoAwareBalanceSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.08),
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
                const Text('🇯🇵 Showing in JPY (based on your location)', 
                  style: TextStyle(fontSize: 14)),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    setState(() {
                      showOriginalCurrency = !showOriginalCurrency;
                    });
                  },
                  child: Text(showOriginalCurrency ? 'View in JPY' : 'View in Original Currency'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Flexible(
                child: Text(
                  showOriginalCurrency ? 'RM100,000,000' : '¥3,200,000,000',
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
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
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
          _buildCurrencyChip('USD', !showOriginalCurrency && selectedCurrency == 'USD'),
          _buildCurrencyChip('JPY', !showOriginalCurrency && selectedCurrency == 'JPY'),
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
        color: Colors.deepPurple.withOpacity(0.07),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.deepPurple.withOpacity(0.1),
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
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            aiSuggestions[0],
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(
            aiSuggestions[1],
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Showing cheapest route...')),
                  );
                },
                child: const Text('Show Cheapest Route'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 24,
      runSpacing: 16,
      children: [
        _buildNavButton(Icons.send, 'Send Money', '/enter_amount'),
        _buildNavButton(Icons.account_balance_wallet, 'Receive Money', '/receive_funds'),
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
            color: Colors.deepPurple.withOpacity(0.1),
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
        ...recentTransactions.map((transaction) => _buildTransactionTile(transaction)),
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
            color: Colors.grey.withOpacity(0.1),
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
                Text(
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
                const SizedBox(height: 4),
                Text(
                  '${transaction['amount']} → ${transaction['converted']}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  transaction['route'],
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[500],
                  ),
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
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 