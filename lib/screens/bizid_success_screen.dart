import 'package:flutter/material.dart';

class BizIDSuccessScreen extends StatefulWidget {
  final String bizId;
  final String businessName;
  final String industry;
  final String registration;
  final String location;

  const BizIDSuccessScreen({
    super.key,
    required this.bizId, 
    required this.businessName,
    required this.industry,
    required this.registration,
    required this.location,
  });

  @override
  State<BizIDSuccessScreen> createState() => _BizIDSuccessScreenState();
}

class _BizIDSuccessScreenState extends State<BizIDSuccessScreen> {
  String selectedLanguage = 'EN';
  
  // Consent preferences state
  bool basicProfileData = true;
  bool businessVerification = true;
  bool analyticsData = false;

  final Map<String, Map<String, String>> localizedTexts = {
    'EN': {
      'title': 'BizID Confirmation',
      'success': 'BizID Created Successfully!',
      'subtitle': 'Your digital business identity is ready to use',
      'verified': 'Verified',
      'businessInfo': 'Business Information',
      'businessName': 'Business Name',
      'industry': 'Industry',
      'registration': 'Registration',
      'location': 'Location',
      'consentPrefs': 'Consent Preferences',
      'manageAccess': 'Manage Access',
      'basicProfile': 'Basic Profile Data',
      'businessVerif': 'Business Verification',
      'analytics': 'Analytics Data',
      'usePartner': 'Use BizID in Partner Apps',
      'applyQR': 'Apply for QR Code',
      'dashboard': 'Go to Dashboard',
      'whatsNext': 'What\'s Next?',
      'nextInfo': 'Your BizID is now active and can be used across partner applications. You can manage your preferences and view usage analytics in your dashboard.',
    },
    'BM': {
      'title': 'Pengesahan BizID',
      'success': 'BizID Berjaya Dicipta!',
      'subtitle': 'Identiti perniagaan digital anda sedia untuk digunakan',
      'verified': 'Disahkan',
      'businessInfo': 'Maklumat Perniagaan',
      'businessName': 'Nama Perniagaan',
      'industry': 'Industri',
      'registration': 'Pendaftaran',
      'location': 'Lokasi',
      'consentPrefs': 'Keutamaan Persetujuan',
      'manageAccess': 'Urus Akses',
      'basicProfile': 'Data Profil Asas',
      'businessVerif': 'Pengesahan Perniagaan',
      'analytics': 'Data Analitik',
      'usePartner': 'Guna BizID dalam Aplikasi Rakan',
      'applyQR': 'Mohon Kod QR',
      'dashboard': 'Pergi ke Dashboard',
      'whatsNext': 'Apa Seterusnya?',
      'nextInfo': 'BizID anda kini aktif dan boleh digunakan merentas aplikasi rakan. Anda boleh mengurus keutamaan dan melihat analitik penggunaan dalam dashboard anda.',
    },
    '中文': {
      'title': 'BizID 确认',
      'success': 'BizID 创建成功！',
      'subtitle': '您的数字商业身份已准备就绪',
      'verified': '已验证',
      'businessInfo': '企业信息',
      'businessName': '企业名称',
      'industry': '行业',
      'registration': '注册',
      'location': '位置',
      'consentPrefs': '同意偏好',
      'manageAccess': '管理访问',
      'basicProfile': '基本资料数据',
      'businessVerif': '企业验证',
      'analytics': '分析数据',
      'usePartner': '在合作应用中使用 BizID',
      'applyQR': '申请二维码',
      'dashboard': '前往仪表板',
      'whatsNext': '下一步？',
      'nextInfo': '您的 BizID 现已激活，可在合作应用程序中使用。您可以在仪表板中管理偏好设置并查看使用分析。',
    },
    'தமிழ்': {
      'title': 'BizID உறுதிப்படுத்தல்',
      'success': 'BizID வெற்றிகரமாக உருவாக்கப்பட்டது!',
      'subtitle': 'உங்கள் டிஜிட்டல் வணிக அடையாளம் பயன்படுத்த தயார்',
      'verified': 'சரிபார்க்கப்பட்டது',
      'businessInfo': 'வணிக தகவல்',
      'businessName': 'வணிக பெயர்',
      'industry': 'தொழில்',
      'registration': 'பதிவு',
      'location': 'இடம்',
      'consentPrefs': 'ஒப்புதல் விருப்பங்கள்',
      'manageAccess': 'அணுகலை நிர்வகிக்கவும்',
      'basicProfile': 'அடிப்படை சுயவிவர தரவு',
      'businessVerif': 'வணிக சரிபார்ப்பு',
      'analytics': 'பகுப்பாய்வு தரவு',
      'usePartner': 'பார்ட்னர் ஆப்ஸில் BizID ஐ பயன்படுத்தவும்',
      'applyQR': 'QR குறியீட்டிற்கு விண்ணப்பிக்கவும்',
      'dashboard': 'டாஷ்போர்டுக்கு செல்லவும்',
      'whatsNext': 'அடுத்தது என்ன?',
      'nextInfo': 'உங்கள் BizID இப்போது செயலில் உள்ளது மற்றும் பார்ட்னர் பயன்பாடுகளில் பயன்படுத்தலாம். உங்கள் டாஷ்போர்டில் உங்கள் விருப்பங்களை நிர்வகிக்கலாம் மற்றும் பயன்பாட்டு பகுப்பாய்வுகளை பார்க்கலாம்.',
    },
  };

  @override
  Widget build(BuildContext context) {
    final texts = localizedTexts[selectedLanguage]!;
    
    return Scaffold(
        appBar: AppBar(
            title: Text(texts['title']!),
            automaticallyImplyLeading: true,
        ),
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                
                // Success Icon
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCFCE7),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Color(0xFF16A34A),
                    size: 40,
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Success Title
                Text(
                  texts['success']!,
                  style: const TextStyle(
                    color: Color(0xFF1B2951),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 8),
                
                // Subtitle
                Text(
                  texts['subtitle']!,
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 32),
                
                // BizID Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: const Color(0xFF4F46E5),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.credit_card,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'BizID',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Text(
                                  'Digital Business Identity',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF6B7280),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFDCFCE7),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.circle,
                                  color: Color(0xFF16A34A),
                                  size: 8,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  texts['verified']!,
                                  style: const TextStyle(
                                    color: Color(0xFF16A34A),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          widget.bizId,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B2951),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Business Information Section
                _buildInfoSection(
                  title: texts['businessInfo']!,
                  children: [
                    _buildInfoRow(texts['businessName']!, widget.businessName),
                    _buildInfoRow(texts['industry']!, widget.industry),
                    _buildInfoRow(texts['registration']!, widget.registration),
                    _buildInfoRow(texts['location']!, widget.location),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                // Consent Preferences Section
                _buildInfoSection(
                  title: texts['consentPrefs']!,
                  trailing: TextButton(
                    onPressed: () {},
                    child: Text(
                      texts['manageAccess']!,
                      style: const TextStyle(color: Color(0xFF4F46E5)),
                    ),
                  ),
                  children: [
                    _buildConsentRow(
                      Icons.shield_outlined,
                      texts['basicProfile']!,
                      basicProfileData,
                      (value) => setState(() => basicProfileData = value),
                    ),
                    _buildConsentRow(
                      Icons.verified_outlined,
                      texts['businessVerif']!,
                      businessVerification,
                      (value) => setState(() => businessVerification = value),
                    ),
                    _buildConsentRow(
                      Icons.analytics_outlined,
                      texts['analytics']!,
                      analyticsData,
                      (value) => setState(() => analyticsData = value),
                    ),
                  ],
                ),
                
                const SizedBox(height: 32),
                
                // Action Buttons
                _buildActionButton(
                  icon: Icons.apps,
                  text: texts['usePartner']!,
                  color: const Color(0xFF4F46E5),
                  textColor: Colors.white,
                  onTap: () {},
                ),
                
                const SizedBox(height: 16),
                
                _buildActionButton(
                  icon: Icons.qr_code,
                  text: texts['applyQR']!,
                  color: Colors.white,
                  textColor: const Color(0xFF1B2951),
                  border: Border.all(color: const Color(0xFF4F46E5), width: 1.5),
                  onTap: () {},
                ),
                
                const SizedBox(height: 16),
                
                _buildActionButton(
                  icon: Icons.dashboard,
                  text: texts['dashboard']!,
                  color: const Color(0xFFE0E7FF),
                  textColor: const Color(0xFF1B2951),
                  onTap: () {},
                ),
                
                const SizedBox(height: 32),
                
                // What's Next Section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F9FF),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.info_outline,
                            color: Color(0xFF0EA5E9),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            texts['whatsNext']!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1B2951),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        texts['nextInfo']!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6B7280),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Language Selector
                _buildLanguageSelector(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection({
    required String title,
    Widget? trailing,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1B2951),
                ),
              ),
              if (trailing != null) trailing,
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

//   
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.right,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1B2951),
              ),
            ),
          ),
        ],
      ),
    );
  }

//   Widget _buildConsentRow(
//     IconData icon,
//     String label,
//     bool value,
//     Function(bool) onChanged,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16),
//       child: Row(
//         children: [
//           Icon(
//             icon,
//             color: const Color(0xFF6B7280),
//             size: 20,
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Text(
//               label,
//               style: const TextStyle(
//                 fontSize: 14,
//                 color: Color(0xFF1B2951),
//               ),
//             ),
//           ),
//           Switch(
//             value: value,
//             onChanged: onChanged,
//             activeColor: const Color(0xFF16A34A),
//           ),
//         ],
//       ),
//     );
//   }

  Widget _buildConsentRow(
    IconData icon,
    String label,
    bool value,
    ValueChanged<bool> onChanged,
    ) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Icon(
            icon,
            color: const Color(0xFF6B7280),
            size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
            child: Text(
                label,
                style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF1B2951),
                ),
                softWrap: true,
                overflow: TextOverflow.visible,
            ),
            ),
            Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF16A34A),
            ),
        ],
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
        const Text(
          '🌐 Language',
          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),
      ],
    );
  }
}
