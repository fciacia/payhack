import 'package:flutter/material.dart';

class WelcomeOnboardingScreen extends StatelessWidget {
  const WelcomeOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE9E6F7), // light purple
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                // Wallet icon
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.account_balance_wallet,
                      size: 48,
                      color: Color(0xFF16204E), // dark blue
                    ),
                  ),
                ),
                const SizedBox(height: 36),
                // App name
                const Text(
                  'PayBorders',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF16204E),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                // Subtitle
                const Text(
                  'Global payments made simple',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF7B8BB2),
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 36),
                // Section title
                const Text(
                  'Start your global wallet',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF16204E),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                // Get Started button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF16204E),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 2,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/sign_up');
                    },
                    child: const Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Spacer(flex: 2),
                // Bottom caption
                const Padding(
                  padding: EdgeInsets.only(bottom: 18.0),
                  child: Text(
                    'Secure • Fast • Borderless',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF7B8BB2),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
