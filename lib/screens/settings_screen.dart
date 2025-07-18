import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _advancedMode = false;
  String _selectedLanguage = 'English';
  String _selectedCurrency = 'USD';
  bool _isBusiness = false;

  final List<String> _languages = ['English', 'Bahasa Melayu', 'Mandarin'];
  final List<String> _currencies = ['USD', 'MYR', 'YUAN'];

  // TODO: Sample values nia
  String network = "Ethereum Mainnet";
  String gasFee = "0.0021 ETH";
  String contractHash = "0xabc123...def678";
  String didCredential = "DID:payhack:xyz7890";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: false,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 26),
          // Advanced Mode Section
          SwitchListTile.adaptive(
            title: const Text("Advanced mode"),
            subtitle: const Text("Show blockchain details and fees"),
            value: _advancedMode,
            onChanged: (value) {
              setState(() {
                _advancedMode = value;
              });
            },
          ),
          if (_advancedMode)
            Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SettingDetailRow(label: "Blockchain Network", value: network),
                    SettingDetailRow(label: "Gas Fees", value: gasFee),
                    SettingDetailRow(label: "Smart Contract", value: contractHash),
                  ],
                ),
              ),
            ),
          const Divider(height: 32),
          // Language & Currency Settings
          Text("Language & Currency",
              style: Theme.of(context).textTheme.titleSmall),
          ListTile(
            title: const Text("Language"),
            trailing: DropdownButton<String>(
              value: _selectedLanguage,
              underline: Container(),
              items: _languages
                  .map((lang) => DropdownMenuItem(
                        value: lang,
                        child: Text(lang),
                      ))
                  .toList(),
              onChanged: (val) => setState(() => _selectedLanguage = val!),
            ),
          ),
          ListTile(
            title: const Text("Default Currency"),
            trailing: DropdownButton<String>(
              value: _selectedCurrency,
              underline: Container(),
              items: _currencies
                  .map((cur) => DropdownMenuItem(
                        value: cur,
                        child: Text(cur),
                      ))
                  .toList(),
              onChanged: (val) => setState(() => _selectedCurrency = val!),
            ),
          ),
          const Divider(height: 32),
          // DID credentials viewer
          ListTile(
            title: const Text("My DID Credentials"),
            subtitle: Text(didCredential),
            trailing: IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () {
                  // TODO: can somehow copy to clipboard
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Copied to clipboard!')),
                );
              },
            ),
            onTap: () {
                // TODO: add more details
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('DID Credentials'),
                  content: Text(didCredential),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    )
                  ],
                ),
              );
            },
          ),
          const Divider(height: 32),
          // TODO: if user no business account, show option to create one
          SwitchListTile.adaptive(
            title: Text(_isBusiness
                ? "Business Account ON"
                : "Switch to business user / Create business account"),
            subtitle:
                Text(_isBusiness ? "You are now using a business profile." : "Unlock more features for companies/merchants."),
            value: _isBusiness,
            onChanged: (value) {
              setState(() {
                _isBusiness = value;
              });
            },
          ),
        ],
      ),
    );
  }
}

class SettingDetailRow extends StatelessWidget {
  final String label, value;
  const SettingDetailRow({required this.label, required this.value, super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(width: 12),
          Expanded(child: Text(value, style: const TextStyle(color: Colors.blueGrey))),
        ],
      ),
    );
  }
}
