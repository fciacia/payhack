import 'package:flutter/material.dart';

class BizIDOnboardingScreen extends StatelessWidget {
  const BizIDOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF16204E)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 36,
                backgroundColor: Color(0xFFE9F0FF),
                child: Icon(Icons.phone_android, size: 38, color: Color(0xFF16204E)),
              ),
              const SizedBox(height: 18),
              const Text('BizID', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF16204E))),
              const SizedBox(height: 6),
              const Text('Register Your Business', style: TextStyle(fontSize: 16, color: Color(0xFF7B8BB2))),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                icon: const Icon(Icons.qr_code, color: Colors.white),
                label: const Text('Scan QR to Onboard'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF16204E),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BizIDScanScreen())),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                icon: const Icon(Icons.chat, color: Color(0xFF25D366)),
                label: const Text('Message WhatsApp Bot'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () {},
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                icon: const Icon(Icons.grid_view, color: Color(0xFF16204E)),
                label: const Text('Log in via BizID'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () {},
              ),
              const SizedBox(height: 18),
              const Text('Secure & Easy Setup', style: TextStyle(fontSize: 13, color: Color(0xFFB0B8D1))),
            ],
          ),
        ),
      ),
    );
  }
}

class BizIDScanScreen extends StatelessWidget {
  const BizIDScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF16204E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 12),
            const Text('Scan QR Code', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 8),
            const Text('Scan Business License', style: TextStyle(fontSize: 16, color: Colors.white70)),
            const SizedBox(height: 18),
            Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Center(child: Icon(Icons.qr_code_2, color: Colors.white24, size: 120)),
            ),
            const SizedBox(height: 18),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[300],
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BizIDSmartOnboardingScreen())),
              child: const Text('Start Scanning'),
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              icon: const Icon(Icons.image, color: Colors.white),
              label: const Text('Choose from Gallery', style: TextStyle(color: Colors.white)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white24),
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: () {},
            ),
            const SizedBox(height: 18),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Text(
                'Scanning Tips\n• Hold your device steady and ensure good lighting\n• Keep the QR code within the frame boundaries\n• Clean your camera lens for better results',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BizIDSmartOnboardingScreen extends StatelessWidget {
  const BizIDSmartOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF16204E)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Smart Onboarding', style: TextStyle(color: Color(0xFF16204E), fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: const [
                Icon(Icons.document_scanner, color: Colors.blue),
                SizedBox(width: 10),
                Expanded(
                  child: Text('Auto-filled from document\nInformation extracted using OCR technology', style: TextStyle(fontSize: 14)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const Text('Business Information', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 10),
          _infoField('Business Name', 'TechCorp Solutions Sdn Bhd'),
          _infoField('Owner Name', 'Ahmad Rashid bin Abdullah'),
          _infoField('Registration Number', '202301234567'),
          _infoField('Business Address', 'No. 15, Jalan Teknologi 3/5, Taman Sains Selangor, 81300 Skudai, Johor'),
          TextButton(onPressed: () {}, child: const Text('+ Add more fields')),
          const SizedBox(height: 18),
          const Text('Required Documents', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 10),
          _uploadField('Upload IC / Business License'),
          const SizedBox(height: 10),
          _voiceNoteField(),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF16204E),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BizIDConfirmationScreen())),
              child: const Text('Create BizID', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey)),
          const SizedBox(height: 2),
          TextFormField(
            initialValue: value,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _uploadField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey)),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () {},
          child: Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: const Center(
              child: Text('Tap to upload document\nPDF, JPG, PNG up to 10MB', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _voiceNoteField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Text('Add Voice Note', style: TextStyle(fontSize: 13, color: Colors.grey)),
            SizedBox(width: 6),
            Text('(Optional)', style: TextStyle(fontSize: 12, color: Colors.blue)),
          ],
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () {},
          child: Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: const Center(
              child: Text('Record a voice note\nExplain your business in your own words', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
            ),
          ),
        ),
      ],
    );
  }
}

class BizIDConfirmationScreen extends StatelessWidget {
  const BizIDConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF16204E)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('BizID Confirmation', style: TextStyle(color: Color(0xFF16204E), fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: const [
                Icon(Icons.verified, color: Colors.green, size: 36),
                SizedBox(height: 10),
                Text('BizID Created Successfully!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green)),
                SizedBox(height: 6),
                Text('Your digital business identity is ready to use', style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.badge, color: Colors.blue),
                      SizedBox(width: 8),
                      Text('BizID', style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(width: 8),
                      Chip(label: Text('Verified', style: TextStyle(color: Colors.white)), backgroundColor: Colors.green, visualDensity: VisualDensity.compact),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text('#BIZ123456789', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Business Information', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('Business Name      TechCorp Solutions'),
                  Text('Industry           Technology'),
                  Text('Registration       LLC-2024-001'),
                  Text('Location           New York, USA'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Consent Preferences', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  SwitchListTile(
                    value: true,
                    onChanged: (v) {},
                    title: const Text('Basic Profile Data'),
                  ),
                  SwitchListTile(
                    value: true,
                    onChanged: (v) {},
                    title: const Text('Business Verification'),
                  ),
                  SwitchListTile(
                    value: false,
                    onChanged: (v) {},
                    title: const Text('Analytics Data'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF16204E),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
            onPressed: () {},
            child: const Text('Use BizID in Partner Apps'),
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
            onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false),
            child: const Text('Apply for QR Code'),
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
            onPressed: () {},
            child: const Text('Go to Dashboard'),
          ),
          const SizedBox(height: 18),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("What's Next?", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('Your BizID is now active and can be used across partner applications. You can manage your preferences and view usage analytics in your dashboard.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 