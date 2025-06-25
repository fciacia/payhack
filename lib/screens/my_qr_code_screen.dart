import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyQRCodeScreen extends StatelessWidget {
  const MyQRCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const username = '@username';

    return Scaffold(
      appBar: AppBar(
        title: const Text('My QR Code'),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Theme.of(context).colorScheme.secondary.withOpacity(0.5)),
                ),
                child: Center(
                  child: Icon(Icons.qr_code_2, size: 150, color: Theme.of(context).colorScheme.primary),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Share your @username to receive money',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              TextButton.icon(
                onPressed: () {
                  Clipboard.setData(const ClipboardData(text: username));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Username copied to clipboard!')),
                  );
                },
                icon: const Icon(Icons.copy, size: 18),
                label: const Text('Copy Username', style: TextStyle(fontWeight: FontWeight.bold)),
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 