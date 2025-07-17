import 'package:flutter/material.dart';
import '../app_colors.dart';
import 'home_scaffold.dart';

class EcoPulseOptInScreen extends StatefulWidget {
  const EcoPulseOptInScreen({super.key});

  @override
  State<EcoPulseOptInScreen> createState() => _EcoPulseOptInScreenState();
}

class _EcoPulseOptInScreenState extends State<EcoPulseOptInScreen> {
  bool _ecoPulseOptIn = false;
  final Set<String> _selectedCauses = {};
  final List<String> _causes = [
    'Forest Reforestation',
    'Clean Oceans',
    'Local Community Support',
  ];

  void _showLearnMoreDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About Eco-Pulse'),
        content: const Text(
          'Eco-Pulse lets you contribute to environmental and social causes with every payment you make. Opting in is optional and can be changed later in settings.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lace,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Top Section: Success Message
              Column(
                children: const [
                  Icon(Icons.verified, color: AppColors.midnight, size: 48),
                  SizedBox(height: 18),
                  Text(
                    'You are verified with DID 🎉',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.midnight,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 36),
              // Middle Section: Eco-Pulse Opt-in
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha((0.04 * 255).round()),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'Make Every Transaction Count',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.midnight,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Want to contribute to a greener planet and support social causes with your payments?',
                      style: TextStyle(fontSize: 15, color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 22),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Switch(
                          value: _ecoPulseOptIn,
                          onChanged: (val) {
                            setState(() {
                              _ecoPulseOptIn = val;
                            });
                          },
                          activeColor: AppColors.midnight,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Opt-in to Eco-Pulse',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.midnight,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: _showLearnMoreDialog,
                      child: const Text(
                        'Learn More about Eco-Pulse',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: AppColors.sapphire,
                        ),
                      ),
                    ),
                    // Show cause selection if opted in
                    if (_ecoPulseOptIn) ...[
                      const SizedBox(height: 18),
                      const Text(
                        'Choose your preferred causes:',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.midnight,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        children: _causes.map((cause) {
                          final selected = _selectedCauses.contains(cause);
                          return ChoiceChip(
                            label: Text(cause),
                            selected: selected,
                            selectedColor: AppColors.sapphire,
                            onSelected: (val) {
                              setState(() {
                                if (val) {
                                  _selectedCauses.add(cause);
                                } else {
                                  _selectedCauses.remove(cause);
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ],
                ),
              ),
              const Spacer(),
              // Bottom Section: Continue Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.midnight,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 2,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScaffold(),
                      ),
                    );
                  },
                  child: const Text(
                    'Continue to Home Dashboard',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}
