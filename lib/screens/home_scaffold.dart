import 'package:flutter/material.dart';
import 'package:payhack_app/screens/choose_recipient_screen.dart';
import 'package:payhack_app/screens/enter_amount_screen.dart';
import 'package:payhack_app/screens/widgets/request_money_screen.dart';
import 'package:payhack_app/screens/offline_mode_screen.dart';
import 'package:payhack_app/screens/settings_screen.dart';
import 'package:payhack_app/screens/send_flow_page.dart';
import 'widgets/glass_card.dart';

// --- HomeScaffold (bottom navigation shell) ---
class HomeScaffold extends StatefulWidget {
  const HomeScaffold({super.key});

  @override
  State<HomeScaffold> createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  int _selectedIndex = 2; // Center/main page by default

  final List<Widget> _pages = [
    EnterAmountScreen(),
    RequestMoneyScreen(),
    DashboardPage(),
    OfflineModeScreen(),
    SettingsScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.deepPurple),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GlassCard(
                    borderRadius: 24,
                    padding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 8,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Chain Selection button
                        ListTile(
                          leading: const Icon(
                            Icons.link,
                            color: Colors.deepPurple,
                          ),
                          title: const Text(
                            'Chain Selection',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/chain_selection');
                          },
                        ),
                        // Bridge Status button
                        ListTile(
                          leading: const Icon(
                            Icons.compare_arrows,
                            color: Colors.deepPurple,
                          ),
                          title: const Text(
                            'Bridge Status',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/bridge_status');
                          },
                        ),
                        // Gas Fee Comparison button
                        ListTile(
                          leading: const Icon(
                            Icons.local_gas_station,
                            color: Colors.deepPurple,
                          ),
                          title: const Text(
                            'Gas Fee Comparison',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/gas_fee_comparison');
                          },
                        ),
                        // Offline Mode button
                        ListTile(
                          leading: const Icon(
                            Icons.wifi_off,
                            color: Colors.deepPurple,
                          ),
                          title: const Text(
                            'Offline Mode',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => OfflineModeScreen(),
                              ),
                            );
                          },
                        ),
                        // Scheduled Transfers button
                        ListTile(
                          leading: const Icon(
                            Icons.schedule,
                            color: Colors.deepPurple,
                          ),
                          title: const Text(
                            'Scheduled Transfers',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const ScheduledTransfersListScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildNavIcon(context, 0, Icons.send, 'Send'),
              _buildNavIcon(context, 1, Icons.request_page, 'Request'),
              const SizedBox(width: 36),
              // Merchants button
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/green_merchants');
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.store, color: Colors.deepPurple, size: 26),
                      SizedBox(height: 2),
                      Text(
                        'Merchants',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),
              _buildNavIcon(context, 4, Icons.person, 'Me'),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 18),
        child: SizedBox(
          height: 60,
          width: 60,
          child: FloatingActionButton(
            onPressed: () => _onTabTapped(2),
            backgroundColor: Colors.deepPurple,
            elevation: 6,
            child: const Icon(Icons.home, size: 32, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildNavIcon(
    BuildContext context,
    int index,
    IconData icon,
    String label,
  ) {
    final isSelected = _selectedIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () {
          if (index == 0) {
            // Send button: open send money flow
            Navigator.pushNamed(context, '/send_flow');
          } else {
            _onTabTapped(index);
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.deepPurple : Colors.grey,
              size: 26,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Colors.deepPurple : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // In the navigation buttons section, add a button for Green Merchant Discovery
  Widget _buildNavButton(IconData icon, String label, String route) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.deepPurple, size: 26),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.deepPurple),
            ),
          ],
        ),
      ),
    );
  }
}
