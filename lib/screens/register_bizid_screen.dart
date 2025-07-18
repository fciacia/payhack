import 'package:flutter/material.dart';
import 'package:payhack_app/screens/qr_scanner_screen.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:payhack_app/screens/smart_onboarding_screen.dart';

class RegisterBizIDScreen extends StatefulWidget {
  const RegisterBizIDScreen({super.key});

  @override
  State<RegisterBizIDScreen> createState() => _RegisterBizIDScreenState();
}

class _RegisterBizIDScreenState extends State<RegisterBizIDScreen> {
  String selectedLanguage = 'EN';

  final Map<String, Map<String, String>> localizedTexts = {
    'EN': {
      'title': 'BizID',
      'subtitle': 'Register Your Business',
      'scan': 'Scan QR to Onboard',
      'whatsapp': 'Message WhatsApp Bot',
      'signup': 'Sign up via BizID',
      'footer': 'Secure & Easy Setup',
    },
    'BM': {
      'title': 'BizID',
      'subtitle': 'Daftar Perniagaan Anda',
      'scan': 'Imbas QR untuk Mendaftar',
      'whatsapp': 'Mesej Bot WhatsApp',
      'signup': 'Daftar melalui BizID',
      'footer': 'Pendaftaran Selamat & Mudah',
    },
    '中文': {
      'title': 'BizID',
      'subtitle': '注册您的企业',
      'scan': '扫码注册',
      'whatsapp': '联系 WhatsApp 机器人',
      'signup': '通过 BizID 注册', // Fixed typo from 'singup'
      'footer': '安全 & 简单设置',
    },
    'தமிழ்': {
      'title': 'BizID',
      'subtitle': 'உங்கள் வணிகத்தை பதிவு செய்யவும்',
      'scan': 'QR ஐ ஸ்கேன் செய்யவும்',
      'whatsapp': 'WhatsApp Bot ஐ தொடர்புகொள்ளவும்',
      'signup': 'BizID மூலம் உள்நுழைக', // Fixed typo from 'singup'
      'footer': 'பாதுகாப்பான & எளிய அமைப்பு',
    },
  };

  @override
  Widget build(BuildContext context) {
    final texts = localizedTexts[selectedLanguage]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Register Business ID"),
        automaticallyImplyLeading: true,
      ),
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                // Logo and Title
                Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        color: Color(0xFF1B2951),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.phone_android,
                          color: Colors.white, size: 36),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      texts['title']!,
                      style: const TextStyle(
                        color: Color(0xFF1B2951),
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      texts['subtitle']!,
                      style: const TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                // QR Code Section
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5E7EB).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Center(
                    child: QrImageView(
                      data: 'https://example.com/onboarding',
                      version: QrVersions.auto,
                      size: 120.0,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // Action Buttons
                _buildActionButton(
                  icon: Icons.qr_code_scanner,
                  text: texts['scan']!,
                  color: const Color(0xFF1B2951),
                  textColor: Colors.white,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const QRScannerScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                _buildActionButton(
                  icon: Icons.chat,
                  text: texts['whatsapp']!,
                  color: const Color(0xFF4F46E5),
                  textColor: Colors.white,
                  onTap: () {
                    // TODO: Implement WhatsApp bot link or functionality
                  },
                ),
                const SizedBox(height: 16),
                _buildActionButton(
                  icon: Icons.apps,
                  text: texts['signup']!,
                  color: Colors.white,
                  textColor: const Color(0xFF1B2951),
                  border: Border.all(color: const Color(0xFFE5E7EB), width: 1.5),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SmartOnboardingScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.security,
                        color: Color(0xFF6B7280), size: 20),
                    const SizedBox(width: 8),
                    Text(
                      texts['footer']!,
                      style: const TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildLanguageSelector(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String text,
    required Color color,
    required Color textColor,
    Border? border,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        border: border,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: textColor, size: 24),
              const SizedBox(width: 12),
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageSelector() {
    const languages = ['EN', 'BM', '中文', 'தமிழ்'];

    return Column(
      children: [
        const SizedBox(height: 16),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 12,
          children: languages.map((lang) {
            final isSelected = lang == selectedLanguage;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedLanguage = lang;
                });
              },
              child: Text(
                lang,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: isSelected ? const Color(0xFF1B2951) : Colors.grey,
                  decoration: isSelected ? TextDecoration.underline : null,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 6),
        const Text('🌐 Language',
            style: TextStyle(color: Colors.grey, fontSize: 13)),
      ],
    );
  }
}
