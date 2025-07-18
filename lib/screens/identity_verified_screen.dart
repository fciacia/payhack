import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IdentityVerifiedScreen extends StatelessWidget {
  const IdentityVerifiedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const did = 'did:pay:1234...abcd';
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF16204E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text(
          'Verify Identity',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12.0, left: 16, right: 16),
            child: Row(
              children: [
                _buildStepCircle(true),
                _buildStepperLine(),
                _buildStepCircle(true),
                _buildStepperLine(),
                _buildStepCircle(true),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 32,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFFD6F5E6),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(18),
                        child: const Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 40,
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        'Identity Verified',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF16204E),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Your Decentralized Identifier has been\nsuccessfully verified',
                        style: TextStyle(fontSize: 15, color: Colors.black54),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 18),
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(const ClipboardData(text: did));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('DID copied to clipboard!'),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF3B5AFE), Color(0xFFB7AFFF)],
                            ),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(
                                  Icons.verified,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'DID Verified',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'did:pay:1234...abcd',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 6),
                                Icon(
                                  Icons.copy,
                                  color: Colors.white70,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF16204E),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/',
                      (route) => false,
                    );
                  },
                  child: const Text(
                    'Get Started',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepCircle(bool active) {
    return Column(
      children: [
        CircleAvatar(
          radius: 15,
          backgroundColor: active ? Colors.white : const Color(0xFF23306B),
          child: Icon(
            Icons.check,
            color: active ? const Color(0xFF16204E) : Colors.white,
            size: 18,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          ' ',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildStepperLine() {
    return Expanded(
      child: Container(height: 2, color: const Color(0xFF23306B)),
    );
  }
}
