import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:payhack_app/screens/register_bizid_screen.dart';

// notifiers
import '../state/settings_notifier.dart';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool advancedMode = false;
  String selectedLanguage = 'English';
  String selectedCurrency = 'MYR';
  bool ecoPulseEnabled = true;
  List<String> selectedCauses = ['Trees'];
  String donationHistory = 'RM0.60 to Trees on 2024-05-01';
  String ecoGoal = 'Reduce CO₂ by 2kg this month';
  String privacyInfo =
      'Only anonymized transaction data is used for carbon/impact estimates. No personal identifiers are stored.';
  String methodology =
      'Carbon estimates use the open-source GreenCrypto API v1.2, based on network energy consumption and transaction type.';
  String auditTrail =
      'All micro-donations are recorded on-chain. Viewable via Etherscan.';
  bool liteModeEnabled = false;

  // final List<Widget> _pages = [
  //   RegisterBizIDScreen(),
  // ];

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsNotifier>();

    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SwitchListTile(
            title: const Text("Advanced Mode"),
            subtitle: const Text("Toggle blockchain-level visibility"),
            value: advancedMode,
            onChanged: (val) => setState(() => advancedMode = val),
          ),
          const Divider(),
          // TODO: if user no business account, show option to create one
          SwitchListTile(
            title: Text(settings.isBusiness
                ? "Business Account ON"
                : "Switch to business user / Create business account"),
            subtitle: Text(settings.isBusiness
                ? "You are now using a business profile."
                : "Unlock more features for companies/merchants."),
            value: settings.isBusiness,
            onChanged: (v) => context.read<SettingsNotifier>().toggleBusiness(v),
          ),
          const Divider(),
          SwitchListTile(
            title: const Text("Lite Mode"),
            subtitle: const Text(
              "Enable simplified interface for low data/feature phones",
            ),
            value: liteModeEnabled,
            onChanged: (val) => setState(() => liteModeEnabled = val),
          ),
          if (advancedMode) ...[
            const Divider(),
            const ListTile(
              title: Text("Blockchain Network"),
              subtitle: Text("Avalanche Mainnet"),
            ),
            const ListTile(
              title: Text("Gas Fee Estimate"),
              subtitle: Text("0.00021 AVAX (~RM 0.30)"),
            ),
            const ListTile(
              title: Text("Smart Contract Hash"),
              subtitle: Text("0x7F5A...E12b"),
              isThreeLine: true,
            ),
          ],
          const Divider(),
          const SizedBox(height: 10),
          const Text(
            "Language & Currency Settings",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          DropdownButton<String>(
            value: selectedLanguage,
            items: const [
              DropdownMenuItem(value: 'English', child: Text("English")),
              DropdownMenuItem(value: 'Malay', child: Text("Malay")),
            ],
            onChanged: (val) => setState(() => selectedLanguage = val!),
          ),
          DropdownButton<String>(
            value: selectedCurrency,
            items: const [
              DropdownMenuItem(value: 'MYR', child: Text("MYR")),
              DropdownMenuItem(value: 'USD', child: Text("USD")),
              DropdownMenuItem(value: 'JPY', child: Text("JPY")),
            ],
            onChanged: (val) => setState(() => selectedCurrency = val!),
          ),
          const Divider(),
          const SizedBox(height: 10),
          ListTile(
            title: const Text("My DID Credentials"),
            subtitle: const Text("Decentralized ID: did:pay:id:0x9a...2fF3"),
            trailing: const Icon(Icons.vpn_key),
          ),
          // Add button to Register Business ID
          const Divider(),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegisterBizIDScreen()),
              );
            },

            icon: const Icon(Icons.business),
            label: const Text("Register Business ID"),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Register and verify your business identification for enhanced features",
            style: TextStyle(fontSize: 12, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const Text(
            'Eco-Pulse Settings',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SwitchListTile(
            title: const Text('Eco-Pulse Features'),
            subtitle: const Text('Enable or disable all Eco-Pulse features'),
            value: ecoPulseEnabled,
            onChanged: (val) => setState(() => ecoPulseEnabled = val),
          ),
          ListTile(
            leading: const Icon(Icons.eco, color: Colors.green),
            title: const Text('Manage Micro-Donations'),
            subtitle: Text('Causes: ${selectedCauses.join(', ')}'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Select Causes'),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CheckboxListTile(
                          value: selectedCauses.contains('Trees'),
                          onChanged: (val) => setState(() {
                            if (val == true &&
                                !selectedCauses.contains('Trees')) {
                              selectedCauses.add('Trees');
                            } else {
                              selectedCauses.remove('Trees');
                            }
                          }),
                          title: const Text('Trees'),
                        ),
                        CheckboxListTile(
                          value: selectedCauses.contains('Clean Oceans'),
                          onChanged: (val) => setState(() {
                            if (val == true &&
                                !selectedCauses.contains('Clean Oceans')) {
                              selectedCauses.add('Clean Oceans');
                            } else {
                              selectedCauses.remove('Clean Oceans');
                            }
                          }),
                          title: const Text('Clean Oceans'),
                        ),
                        CheckboxListTile(
                          value: selectedCauses.contains(
                            'Local Community Support',
                          ),
                          onChanged: (val) => setState(() {
                            if (val == true &&
                                !selectedCauses.contains(
                                  'Local Community Support',
                                )) {
                              selectedCauses.add('Local Community Support');
                            } else {
                              selectedCauses.remove('Local Community Support');
                            }
                          }),
                          title: const Text('Local Community Support'),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Done'),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.flag, color: Colors.green),
            title: const Text('Manage Eco-Goals & Challenges'),
            subtitle: Text(ecoGoal),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Eco-Goals & Challenges'),
                  content: const Text(
                    'Set monthly CO₂ reduction or donation goals. (Demo only)',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.history, color: Colors.green),
            title: const Text('View Donation History'),
            subtitle: Text(donationHistory),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Donation History'),
                  content: Text(donationHistory),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip, color: Colors.blue),
            title: const Text('Data & Privacy for ESG Insights'),
            subtitle: Text(privacyInfo),
            trailing: const Icon(Icons.info_outline),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Data & Privacy'),
                  content: Text(privacyInfo),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
          if (advancedMode) ...[
            const Divider(),
            ListTile(
              leading: const Icon(Icons.school, color: Colors.blue),
              title: const Text('Educational Modules'),
              subtitle: const Text(
                'Learn about sustainability and financial literacy',
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.pushNamed(context, '/educational_modules'),
            ),
            ListTile(
              leading: const Icon(Icons.science, color: Colors.amber),
              title: const Text('Carbon Calculation Methodology'),
              subtitle: Text(methodology),
            ),
            ListTile(
              leading: const Icon(Icons.verified, color: Colors.amber),
              title: const Text('Donation Audit Trail'),
              subtitle: Text(auditTrail),
            ),
            const Divider(),
            // TODO: if user no business account, show option to create one
            SwitchListTile(
              title: Text(settings.isBusiness
                  ? "Business Account ON"
                  : "Switch to business user / Create business account"),
              subtitle: Text(settings.isBusiness
                  ? "You are now using a business profile."
                  : "Unlock more features for companies/merchants."),
              value: settings.isBusiness,
              onChanged: (v) => context.read<SettingsNotifier>().toggleBusiness(v),
            ),
          ],
        ],
      ),
    );
  }
}
