import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool advancedMode = false;
  String selectedLanguage = 'English';
  String selectedCurrency = 'MYR';

  @override
  Widget build(BuildContext context) {
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
        ],
      ),
    );
  }
}
