import 'package:flutter/material.dart';

class ContactProfileScreen extends StatelessWidget {
  const ContactProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final contact =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
        {
          'avatar': 'https://i.pravatar.cc/150?img=1',
          'username': '@alice',
          'name': 'Alice',
          'verified': true,
          'preferredCurrencies': ['USD', 'MYR'],
        };
    final List<Map<String, String>> transactions = [
      {'date': '2024-06-01', 'amount': 'RM 500', 'currency': 'MYR'},
      {'date': '2024-05-28', 'amount': 'USD 100', 'currency': 'USD'},
      {'date': '2024-05-20', 'amount': 'RM 200', 'currency': 'MYR'},
    ];
    final List<String> preferredCurrencies =
        contact['preferredCurrencies'] ?? ['USD', 'MYR'];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Contact Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6D5BFF), Color(0xFF00C6FB)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                CircleAvatar(
                  backgroundImage: NetworkImage(contact['avatar']),
                  radius: 44,
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      contact['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    if (contact['verified']) ...[
                      const SizedBox(width: 8),
                      const Icon(Icons.verified, color: Colors.blue, size: 22),
                    ],
                  ],
                ),
                Text(
                  contact['username'],
                  style: const TextStyle(fontSize: 15, color: Colors.white70),
                ),
                const SizedBox(height: 18),
                Wrap(
                  spacing: 10,
                  children: preferredCurrencies
                      .map(
                        (c) => Chip(
                          label: Text(
                            c,
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.deepPurple.withAlpha(
                            (0.7 * 255).round(),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Past Transactions',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withAlpha((0.95 * 255).round()),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.separated(
                    itemCount: transactions.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final tx = transactions[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha((0.15 * 255).round()),
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(
                                (0.06 * 255).round(),
                              ),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              tx['date']!,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              tx['amount']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.deepPurple,
                              ),
                            ),
                            Text(
                              tx['currency']!,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
