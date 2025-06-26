import 'package:flutter/material.dart';

class ChooseRecipientScreen extends StatelessWidget {
  const ChooseRecipientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> recipients = [
      {'name': 'Alice', 'avatar': 'https://i.pravatar.cc/150?u=alice'},
      {'name': 'Bob', 'avatar': 'https://i.pravatar.cc/150?u=bob'},
      {'name': 'Charlie', 'avatar': 'https://i.pravatar.cc/150?u=charlie'},
      {'name': 'Diana', 'avatar': 'https://i.pravatar.cc/150?u=diana'},
      {'name': 'Eve', 'avatar': 'https://i.pravatar.cc/150?u=eve'},
    ];

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Send Money', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 5),
                  )
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                  hintText: 'Search by @username or Name',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                  contentPadding: const EdgeInsets.symmetric(vertical: 18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Recent Recipients
            const Text(
              'Recent Recipients',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 110,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: recipients.length,
                separatorBuilder: (_, __) => const SizedBox(width: 15),
                itemBuilder: (context, index) {
                  final recipient = recipients[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/enter_amount',
                        arguments: {
                          'avatar': recipient['avatar'],
                          'username': recipient['name'],
                        },
                      );
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage(recipient['avatar']!),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          recipient['name']!,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),

            // Action Buttons
            _buildActionButton(
              context,
              icon: Icons.qr_code_scanner_rounded,
              title: 'Scan QR Code',
              onTap: () {},
            ),
            const SizedBox(height: 15),
            _buildActionButton(
              context,
              icon: Icons.qr_code_2_rounded,
              title: 'My QR Code',
              onTap: () {
                Navigator.pushNamed(context, '/my_qr_code');
              },
            ),
            const SizedBox(height: 15),
            _buildActionButton(
              context,
              icon: Icons.calendar_today_rounded,
              title: 'Schedule a Transfer',
              onTap: () {
                Navigator.pushNamed(context, '/schedule_transfer');
              },
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                'Share your @username or QR to receive',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
            const SizedBox(height: 15),
            _buildActionButton(
              context,
              icon: Icons.receipt,
              title: 'Transaction History',
              onTap: () {
                Navigator.pushNamed(context, '/transaction_history');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Row(
            children: [
              Icon(icon, size: 28, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 20),
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios_rounded, size: 18, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
} 