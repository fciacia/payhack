import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF16204E)),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text(
          'Welcome',
          style: TextStyle(
            color: Color(0xFF16204E),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: _SignUpBody(),
    );
  }
}

class _SignUpBody extends StatefulWidget {
  @override
  State<_SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<_SignUpBody> {
  bool _isGoogleLoading = false;

  Future<void> _handleGoogleSignIn() async {
    setState(() => _isGoogleLoading = true);
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn();
      final account = await _googleSignIn.signIn();
      if (account != null) {
        if (mounted) {
          Navigator.pushNamed(context, '/personal_info');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Google sign-in cancelled.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Google sign-in failed: $e')));
    } finally {
      if (mounted) setState(() => _isGoogleLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFE9F0FF), // light blue
            Color(0xFFE9E6F7), // light purple
          ],
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                // Wallet icon in rounded square
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.account_balance_wallet,
                      size: 38,
                      color: Color(0xFF16204E),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                // App name
                const Text(
                  'PayBorders',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF16204E),
                  ),
                ),
                const SizedBox(height: 8),
                // Subtitle
                const Text(
                  'Secure login with multiple options',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF7B8BB2),
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                // MetaMask button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: Image.network(
                      'https://raw.githubusercontent.com/MetaMask/brand-resources/master/SVG/metamask-fox.svg',
                      width: 26,
                      height: 26,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.account_balance_wallet,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    label: const Text(
                      'Connect MetaMask',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFF6851B),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 3,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/personal_info');
                    },
                  ),
                ),
                const SizedBox(height: 22),
                // Divider with text
                Row(
                  children: const [
                    Expanded(
                      child: Divider(thickness: 1, color: Color(0xFFE0E0E0)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'or continue with',
                        style: TextStyle(
                          color: Color(0xFF7B8BB2),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(thickness: 1, color: Color(0xFFE0E0E0)),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                // Google button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/5/53/Google_%22G%22_Logo.svg',
                      width: 22,
                      height: 22,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.g_mobiledata,
                        color: Colors.red,
                        size: 22,
                      ),
                    ),
                    label: _isGoogleLoading
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text(
                            'Continue with Google',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 2,
                      side: const BorderSide(color: Color(0xFFE0E0E0)),
                      alignment: Alignment.centerLeft,
                    ),
                    onPressed: _isGoogleLoading ? null : _handleGoogleSignIn,
                  ),
                ),
                const SizedBox(height: 16),
                // Apple button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.apple,
                      color: Colors.white,
                      size: 22,
                    ),
                    label: const Text(
                      'Continue with Apple',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 2,
                      alignment: Alignment.centerLeft,
                    ),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(height: 16),
                // Email button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.mail_outline,
                      color: Color(0xFF16204E),
                      size: 22,
                    ),
                    label: const Text(
                      'Use Email Instead',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF16204E),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFF5F7FB),
                      foregroundColor: Color(0xFF16204E),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                      alignment: Alignment.centerLeft,
                    ),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(height: 28),
                // Terms and Privacy
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text.rich(
                    TextSpan(
                      text: 'By continuing, you agree to our ',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF7B8BB2),
                      ),
                      children: [
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Terms of Service',
                              style: TextStyle(
                                color: Color(0xFF16204E),
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const TextSpan(text: ' and '),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Privacy Policy',
                              style: TextStyle(
                                color: Color(0xFF16204E),
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
