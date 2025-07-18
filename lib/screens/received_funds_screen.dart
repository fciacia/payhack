import 'package:flutter/material.dart';

class ReceivedFundsScreen extends StatelessWidget {
  const ReceivedFundsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Received Funds')),
      body: const Center(child: Text('Received Funds Screen')),
    );
  }
} 