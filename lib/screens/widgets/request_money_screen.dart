import 'package:flutter/material.dart';

class RequestMoneyScreen extends StatefulWidget {
  @override
  _RequestMoneyScreenState createState() => _RequestMoneyScreenState();
}

class _RequestMoneyScreenState extends State<RequestMoneyScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  bool _isPending = false;

  void _sendRequest() {
    setState(() {
      _isPending = true;
    });
    // mock delay
    Future.delayed(Duration(seconds: 2), () {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Request sent to @${_usernameController.text}')),
      );
    });
  }

  bool get _canRequest =>
      _usernameController.text.trim().isNotEmpty &&
      _amountController.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Request Money')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Request money from anyone, add an emoji or message!',
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
            const Divider(height: 30),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'To: @username'),
              onChanged: (_) => setState(() {}),
            ),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount (e.g. RM500)'),
              onChanged: (_) => setState(() {}),
            ),
            TextField(
              controller: _messageController,
              decoration: InputDecoration(labelText: 'Add a message / emoji (optional)'),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _canRequest ? _sendRequest : null,
                child: const Text('Request Money'),
              ),
            ),
            const SizedBox(height: 20),
            if (_isPending)
              Text(
                '⏳ Status: pending from @${_usernameController.text}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
