import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'package:device_preview/device_preview.dart';

// Existing screens
import 'screens/my_qr_code_screen.dart';
import 'screens/enter_amount_screen.dart';
import 'screens/confirm_transfer_screen.dart';
import 'screens/schedule_transfer_screen.dart';
import 'screens/recurring_transfer_confirmation_screen.dart';
import 'screens/received_funds_screen.dart';
import 'screens/transaction_history_screen.dart';
import 'screens/transaction_invoice_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/widgets/request_money_screen.dart';
import 'screens/offline_mode_screen.dart';
import 'screens/welcome_onboarding_screen.dart';
import 'screens/connect_wallet_screen.dart';
import 'screens/ekyc_upload_screen.dart';
import 'screens/verified_did_screen.dart';
import 'screens/receive_funds_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/home_scaffold.dart';
import 'screens/universal_qr_generator_screen.dart';
import 'screens/qr_scanner_screen.dart';
import 'screens/payment_result_screen.dart';
import 'screens/send_flow_page.dart';
import 'screens/recurring_transfer_screen.dart';
import 'screens/chain_selection_screen.dart';
import 'screens/bridge_status_screen.dart';
import 'screens/gas_fee_comparison_screen.dart';
import 'screens/sign_up_screen.dart';
import 'screens/personal_info_screen.dart';
import 'screens/identity_verified_screen.dart';
import 'screens/identity_verification_screen.dart';

void main() {
  runApp(DevicePreview(enabled: true, builder: (context) => const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isUserBusiness = false;

    final baseTextTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);
    return MaterialApp(
      title: 'Send Money',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.lace,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.sapphire,
          primary: AppColors.sapphire,
          surface: AppColors.lace,
          onPrimary: AppColors.lace,
          onSurface: AppColors.midnight,
          secondary: AppColors.lavender,
          tertiary: AppColors.petal,
        ),
        textTheme: baseTextTheme.copyWith(
          bodyLarge: baseTextTheme.bodyLarge?.copyWith(
            color: AppColors.midnight,
          ),
          bodyMedium: baseTextTheme.bodyMedium?.copyWith(
            color: AppColors.midnight,
          ),
          titleLarge: baseTextTheme.titleLarge?.copyWith(
            color: AppColors.midnight,
            fontWeight: FontWeight.bold,
          ),
          headlineSmall: baseTextTheme.headlineSmall?.copyWith(
            color: AppColors.midnight,
            fontWeight: FontWeight.bold,
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.midnight,
          foregroundColor: AppColors.lace,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: AppColors.lace,
          ),
        ),
        cardTheme: CardThemeData(
          color: AppColors.lace,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          shadowColor: AppColors.sapphire.withAlpha((0.08 * 255).round()),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            padding: WidgetStateProperty.all(
              const EdgeInsets.symmetric(vertical: 18),
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            ),
            elevation: WidgetStateProperty.all(6),
            backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
              if (states.contains(WidgetState.pressed)) {
                return AppColors.lavender;
              }
              return AppColors.sapphire;
            }),
            foregroundColor: WidgetStateProperty.all(AppColors.lace),
            overlayColor: WidgetStateProperty.all(
              AppColors.lavender.withAlpha((0.15 * 255).round()),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.bridalBlue.withAlpha((0.7 * 255).round()),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: AppColors.lavender),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: AppColors.lavender),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(color: AppColors.sapphire, width: 2),
          ),
        ),
        splashFactory: InkRipple.splashFactory,
        highlightColor: AppColors.lavender.withAlpha((0.1 * 255).round()),
      ),
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      initialRoute: '/welcome',
      routes: {
        // Onboarding flow
        '/welcome': (context) => const WelcomeOnboardingScreen(),
        '/connect_wallet': (context) => const ConnectWalletScreen(),
        '/ekyc_upload': (context) => const EKYCUploadScreen(),
        '/verified': (context) => const IdentityVerifiedScreen(),

        // Main flow
        '/': (context) => const HomeScaffold(),
        '/send_flow': (context) => const SendFlowPage(),
        '/chain_selection': (context) => ChainSelectionScreen(),
        '/bridge_status': (context) => BridgeStatusScreen(),
        '/gas_fee_comparison': (context) => GasFeeComparisonScreen(),
        '/my_qr_code': (context) => const MyQRCodeScreen(),
        '/enter_amount': (context) => const EnterAmountScreen(),
        '/confirm_transfer': (context) => const ConfirmTransferScreen(),
        '/schedule_transfer': (context) => const ScheduleTransferScreen(),
        '/recurring_transfer_confirmation': (context) =>
            const RecurringTransferConfirmationScreen(),
        '/request_money': (context) => RequestMoneyScreen(),
        '/offline_mode': (context) => OfflineModeScreen(),
        '/receive_funds': (context) => const ReceiveFundsScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/universal_qr': (context) => UniversalQRGeneratorScreen(),
        '/qr_scanner': (context) => QRScannerScreen(),
        '/payment_result_success': (context) => PaymentResultScreen(
          type: PaymentResultType.success,
          username: '@Felicia',
          chain: 'Polygon',
          amount: 'RM 500',
        ),
        '/payment_result_failure': (context) => PaymentResultScreen(
          type: PaymentResultType.failure,
          username: '@Felicia',
          chain: 'Polygon',
          amount: 'RM 500',
        ),
        '/recurring_transfer': (context) => const RecurringTransferScreen(),
        '/sign_up': (context) => const SignUpScreen(),
        '/personal_info': (context) => const PersonalInfoScreen(),
        '/identity_verification': (context) =>
            const IdentityVerificationScreen(),
        '/transaction_history': (context) => const TransactionHistoryScreen(),
        '/received_funds': (context) => const ReceivedFundsScreen(),
        '/transaction_invoice' : (context) => const TransactionInvoiceScreen(),
        '/settings_screen': (context) => const SettingsScreen(),
      },
    );
  }
}
