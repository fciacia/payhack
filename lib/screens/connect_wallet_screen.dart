import 'package:flutter/material.dart';

class ConnectWalletScreen extends StatelessWidget {
  const ConnectWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Connect Wallet"),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text(
              "Choose how to connect",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Connect your existing wallet or create a new account",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 40),
            // MetaMask option
            _buildOptionCard(
              context,
              icon: Icons.account_balance_wallet,
              title: "Connect MetaMask",
              subtitle: "Use your existing MetaMask wallet",
              onTap: () {
                // Mock MetaMask connection
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('MetaMask connection successful!'),
                  ),
                );
                Navigator.pushNamed(context, '/ekyc_upload');
              },
            ),
            const SizedBox(height: 20),
            // Email signup option
            _buildOptionCard(
              context,
              icon: Icons.email,
              title: "Sign up with Email",
              subtitle: "Create a new account with email verification",
              onTap: () {
                Navigator.pushNamed(context, '/ekyc_upload');
              },
            ),
            const Spacer(),
            // Back button
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Back", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withAlpha((0.1 * 255).round()),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.deepPurple, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
