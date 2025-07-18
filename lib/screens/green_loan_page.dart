import 'package:flutter/material.dart';

class GreenLoanPage extends StatefulWidget {
  const GreenLoanPage({super.key});
  @override
  State<GreenLoanPage> createState() => _GreenLoanPageState();
}

class _GreenLoanPageState extends State<GreenLoanPage> {
  bool showContract = false;
  bool isApplying = false;
  String loanStatus = 'none'; // none, pending, approved, rejected

  // Mock data
  final String greenScore = '82';
  final String bizID = 'BIZ123456789';
  final String eligibility = 'Gold';
  final double interestRate = 3.2;
  final String userID = 'u123';
  final String carbonSaved = '120kg CO₂';
  final String donationRecord = 'RM 200 donated to Trees';

  void applyForLoan() async {
    setState(() {
      isApplying = true;
      loanStatus = 'pending';
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      loanStatus = 'approved'; // or 'rejected' for demo
      isApplying = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Green Loan Program')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text(
            'Get rewarded for sustainable behavior! Apply for a lower-interest loan if you have a verified BizID and a high Green Score.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 18),
          Card(
            child: ListTile(
              leading: const Icon(Icons.eco, color: Colors.green, size: 32),
              title: Text('Green Score: $greenScore', style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Eligibility: $eligibility'),
              trailing: Text('$interestRate%', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child: ListTile(
              leading: const Icon(Icons.verified, color: Colors.blue, size: 32),
              title: Text('BizID: $bizID', style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('Verified Business'),
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child: ListTile(
              leading: const Icon(Icons.volunteer_activism, color: Colors.teal, size: 32),
              title: Text('Carbon Saved: $carbonSaved'),
              subtitle: Text('Donations: $donationRecord'),
            ),
          ),
          const SizedBox(height: 18),
          ExpansionPanelList(
            expansionCallback: (i, isOpen) => setState(() => showContract = !showContract),
            children: [
              ExpansionPanel(
                headerBuilder: (context, isOpen) => const ListTile(title: Text('View Contract Terms')),
                body: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text('Loan Amount: Up to RM 50,000\nInterest Rate: $interestRate%\nRepayment: 24 months\nNo penalty for early repayment.\nEligibility: Gold tier or above.'),
                ),
                isExpanded: showContract,
              ),
            ],
          ),
          const SizedBox(height: 18),
          if (loanStatus == 'none')
            ElevatedButton(
              onPressed: isApplying ? null : applyForLoan,
              child: isApplying ? const CircularProgressIndicator() : const Text('Apply for Loan'),
            ),
          if (loanStatus == 'pending')
            const ListTile(
              leading: CircularProgressIndicator(),
              title: Text('Loan application pending...'),
            ),
          if (loanStatus == 'approved')
            Column(
              children: [
                // You can add a Lottie animation here
                const Icon(Icons.celebration, color: Colors.green, size: 48),
                const Text('Loan Approved!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.green)),
                const SizedBox(height: 8),
                Text('Your green behavior helped you get a better rate!'),
              ],
            ),
          if (loanStatus == 'rejected')
            const ListTile(
              leading: Icon(Icons.cancel, color: Colors.red),
              title: Text('Loan application rejected.'),
            ),
        ],
      ),
    );
  }
} 