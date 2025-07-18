import 'package:flutter/material.dart';
import 'package:payhack_app/screens/bizid_success_screen.dart';

class SmartOnboardingScreen extends StatefulWidget {
  const SmartOnboardingScreen({super.key});

  @override
  State<SmartOnboardingScreen> createState() => _SmartOnboardingScreenState();
}

class _SmartOnboardingScreenState extends State<SmartOnboardingScreen> {
  final _businessNameController = TextEditingController(text: 'TechCorp Solutions Sdn Bhd');
  final _ownerNameController = TextEditingController(text: 'Ahmad Rashid bin Abdullah');
  final _registrationNumberController = TextEditingController(text: '202301234567');
  final _businessAddressController = TextEditingController(
    text: 'No. 15, Jalan Teknologi 3/5,\nTaman Sains Selangor, 81300\nSkudai, Johor',
  );

  bool _isRecording = false;
  String? _uploadedFileName;

  @override
  void dispose() {
    _businessNameController.dispose();
    _ownerNameController.dispose();
    _registrationNumberController.dispose();
    _businessAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Onboarding"),
        automaticallyImplyLeading: true,
      ),
      // appBar: AppBar(
      //   title: const Text(
      //     "Smart Onboarding",
      //     style: TextStyle(
      //       color: Color(0xFF1B2951),
      //       fontWeight: FontWeight.w600,
      //     ),
      //   ),
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back, color: Color(0xFF1B2951)),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      // ),
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Auto-filled notification
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F4FD),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFB3D9FF), width: 1),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.auto_fix_high, color: Color(0xFF1B2951), size: 24),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Auto-filled from document',
                            style: TextStyle(
                              color: Color(0xFF1B2951),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Information extracted using OCR technology',
                            style: TextStyle(
                              color: Color(0xFF6B7280),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Business Info
              const Text(
                'Business Information',
                style: TextStyle(
                  color: Color(0xFF1B2951),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Please verify the auto-filled information',
                style: TextStyle(color: Color(0xFF6B7280), fontSize: 16),
              ),
              const SizedBox(height: 24),

              _buildTextField(label: 'Business Name', controller: _businessNameController),
              const SizedBox(height: 20),

              _buildTextField(label: 'Owner Name', controller: _ownerNameController),
              const SizedBox(height: 20),

              _buildTextField(label: 'Registration Number', controller: _registrationNumberController),
              const SizedBox(height: 20),

              _buildTextField(label: 'Business Address', controller: _businessAddressController, maxLines: 3),
              const SizedBox(height: 16),

              GestureDetector(
                onTap: () {},
                child: const Row(
                  children: [
                    Icon(Icons.add, color: Color(0xFF4F46E5), size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Add more fields',
                      style: TextStyle(
                        color: Color(0xFF4F46E5),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Required Documents
              const Text(
                'Required Documents',
                style: TextStyle(
                  color: Color(0xFF1B2951),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                'Upload IC / Business License',
                style: TextStyle(
                  color: Color(0xFF1B2951),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),

              GestureDetector(
                onTap: _pickFile,
                child: Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE5E7EB), width: 2),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.cloud_upload_outlined, color: Color(0xFF4F46E5), size: 32),
                      const SizedBox(height: 8),
                      Text(
                        _uploadedFileName ?? 'Tap to upload document',
                        style: TextStyle(
                          color: _uploadedFileName != null
                              ? const Color(0xFF1B2951)
                              : const Color(0xFF6B7280),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'PDF, JPG, PNG up to 10MB',
                        style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Voice Note Section
              Row(
                children: [
                  const Text(
                    'Add Voice Note',
                    style: TextStyle(
                      color: Color(0xFF1B2951),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F4FD),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Optional',
                      style: TextStyle(
                        color: Color(0xFF4F46E5),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              GestureDetector(
                onTap: _toggleRecording,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: _isRecording ? Colors.red : const Color(0xFF4F46E5),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _isRecording ? Icons.stop : Icons.mic,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _isRecording ? 'Recording...' : 'Record a voice note',
                              style: const TextStyle(
                                color: Color(0xFF1B2951),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _isRecording ? 'Tap to stop' : 'Explain your business in your own words',
                              style: const TextStyle(
                                color: Color(0xFF6B7280),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (!_isRecording)
                        const Icon(Icons.play_arrow, color: Color(0xFF4F46E5), size: 24),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Create BizID Button
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFF1B2951),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF1B2951).withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: _createBizID,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.business_center, color: Colors.white, size: 24),
                        SizedBox(width: 12),
                        Text(
                          'Create BizID',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              const Text(
                'By creating your BizID, you agree to our Terms of Service and Privacy Policy',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF1B2951),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(
            color: Color(0xFF1B2951),
            fontSize: 16,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFE8F4FD),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF4F46E5), width: 2),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }

  void _pickFile() async {
    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.picture_as_pdf),
            title: const Text('business_license_sample.pdf'),
            onTap: () {
              setState(() => _uploadedFileName = 'business_license_sample.pdf');
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.image),
            title: const Text('ic_photo.jpg'),
            onTap: () {
              setState(() => _uploadedFileName = 'ic_photo.jpg');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _toggleRecording() {
    setState(() => _isRecording = !_isRecording);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isRecording ? 'Recording started...' : 'Recording stopped'),
      ),
    );
  }

  // void _createBizID() {
  //   // Simulate a short delay or validation
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(content: Text('Creating BizID...')),
  //   );

  //   Future.delayed(const Duration(seconds: 1), () {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => const BizIDSuccessScreen()),
  //     );
  //   }); 
  // } 
  void _createBizID() {
  // Simulate a short delay or validation
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Creating BizID...')),
  );

  Future.delayed(const Duration(seconds: 1), () {
    // Generate BizID from registration number
    final bizId = '#BIZ${_registrationNumberController.text}';
    
    // Extract industry from business name or set default
    String industry = 'Technology'; // Default industry
    final businessName = _businessNameController.text.toLowerCase();
    if (businessName.contains('tech')) {
      industry = 'Technology';
    } else if (businessName.contains('food') || businessName.contains('restaurant')) {
      industry = 'Food & Beverage';
    } else if (businessName.contains('retail') || businessName.contains('shop')) {
      industry = 'Retail';
    } else if (businessName.contains('service')) {
      industry = 'Services';
    }

    // Clean up address for location (take first line or city)
    final fullAddress = _businessAddressController.text;
    final addressLines = fullAddress.split('\n');
    final location = addressLines.length > 1 ? addressLines.last.trim() : fullAddress;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BizIDSuccessScreen(
          bizId: bizId,
          businessName: _businessNameController.text,
          industry: industry,
          registration: _registrationNumberController.text,
          location: location,
        ),
      ),
    );
  });
}

}
