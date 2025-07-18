import 'package:flutter/material.dart';

class IdentityVerificationScreen extends StatefulWidget {
  const IdentityVerificationScreen({super.key});

  @override
  State<IdentityVerificationScreen> createState() =>
      _IdentityVerificationScreenState();
}

class _IdentityVerificationScreenState
    extends State<IdentityVerificationScreen> {
  bool _fileSelected = false;
  bool _isUploading = false;

  void _mockSelectFile() async {
    setState(() {
      _isUploading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() {
      _isUploading = false;
      _fileSelected = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Passport uploaded successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF16204E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text(
          'Verify Identity',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12.0, left: 16, right: 16),
            child: Row(
              children: [
                _buildStepCircle(1, true),
                _buildStepperLine(),
                _buildStepCircle(2, true),
                _buildStepperLine(),
                _buildStepCircle(3, false),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              const Text(
                'Upload Your Passport',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF16204E),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Please upload a clear photo of your passport\'s main page. Make sure all details are visible and readable.',
                style: TextStyle(fontSize: 15, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              // Upload area
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 28,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F7FB),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFBFD6F6),
                    style: BorderStyle.solid,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.cloud_upload,
                      size: 48,
                      color: const Color(0xFFBFD6F6),
                    ),
                    const SizedBox(height: 12),
                    if (_isUploading)
                      const CircularProgressIndicator()
                    else ...[
                      Text(
                        _fileSelected
                            ? 'Passport file selected!'
                            : 'Tap to upload passport',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF16204E),
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'or drag and drop your file here',
                        style: TextStyle(fontSize: 14, color: Colors.black38),
                      ),
                      const SizedBox(height: 14),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFEDF2FA),
                          foregroundColor: const Color(0xFF16204E),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 10,
                          ),
                        ),
                        onPressed: _fileSelected || _isUploading
                            ? null
                            : _mockSelectFile,
                        child: Text(
                          _fileSelected ? 'File Uploaded' : 'Choose File',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Supported formats: JPG, PNG, PDF (Max 5MB)',
                        style: TextStyle(fontSize: 13, color: Colors.black38),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 28),
              // Photo requirements
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha((0.03 * 255).round()),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Photo Requirements',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF16204E),
                      ),
                    ),
                    SizedBox(height: 12),
                    _PhotoRequirement(text: 'Clear and well-lit photo'),
                    _PhotoRequirement(text: 'All four corners visible'),
                    _PhotoRequirement(text: 'Text is readable and not blurry'),
                    _PhotoRequirement(text: 'No glare or shadows'),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              // Security info
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFE9E6F7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.verified_user, color: Color(0xFF16204E)),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Your data is secure\nWe use bank-level encryption to protect your information.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF16204E),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              // Continue button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _fileSelected
                        ? const Color(0xFF16204E)
                        : Colors.grey[300],
                    foregroundColor: _fileSelected
                        ? Colors.white
                        : Colors.black38,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  onPressed: _fileSelected
                      ? () {
                          Navigator.pushNamed(context, '/verified');
                        }
                      : null,
                  child: const Text(
                    'Continue',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  'Please upload your passport to continue',
                  style: TextStyle(fontSize: 13, color: Colors.black38),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepCircle(int step, bool active) {
    return Column(
      children: [
        CircleAvatar(
          radius: 15,
          backgroundColor: active ? Colors.white : const Color(0xFF23306B),
          child: Icon(
            step == 1
                ? Icons.looks_one
                : step == 2
                ? Icons.looks_two
                : Icons.looks_3,
            color: active ? const Color(0xFF16204E) : Colors.white,
            size: 18,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          step == 1
              ? 'Personal Info'
              : step == 2
              ? 'Identity'
              : 'Verification',
          style: TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildStepperLine() {
    return Expanded(
      child: Container(height: 2, color: const Color(0xFF23306B)),
    );
  }
}

class _PhotoRequirement extends StatelessWidget {
  final String text;
  const _PhotoRequirement({required this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 18),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 14, color: Colors.black87),
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
