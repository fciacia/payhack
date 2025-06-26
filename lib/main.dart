import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart'; // Import the new colors
import 'screens/choose_recipient_screen.dart';
import 'screens/my_qr_code_screen.dart';
import 'screens/enter_amount_screen.dart';
import 'screens/confirm_transfer_screen.dart';
import 'screens/schedule_transfer_screen.dart';
import 'screens/recurring_transfer_confirmation_screen.dart';
import 'screens/received_funds_screen.dart';
import 'screens/transaction_history_screen.dart';
import 'screens/transaction_invoice_screen.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true, // Set to false to disable preview
      builder: (context) => const MyApp(), // Wrap your app here
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
          background: AppColors.lace,
          surface: AppColors.lace,
          onPrimary: AppColors.lace,
          onBackground: AppColors.midnight,
          secondary: AppColors.lavender,
          tertiary: AppColors.petal,
        ),
        textTheme: baseTextTheme.copyWith(
          bodyLarge: baseTextTheme.bodyLarge?.copyWith(color: AppColors.midnight),
          bodyMedium: baseTextTheme.bodyMedium?.copyWith(color: AppColors.midnight),
          titleLarge: baseTextTheme.titleLarge?.copyWith(color: AppColors.midnight, fontWeight: FontWeight.bold),
          headlineSmall: baseTextTheme.headlineSmall?.copyWith(color: AppColors.midnight, fontWeight: FontWeight.bold),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.midnight,
          foregroundColor: AppColors.lace,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: AppColors.lace),
        ),
        cardTheme: CardThemeData(
          color: AppColors.lace,
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          shadowColor: AppColors.sapphire.withOpacity(0.08),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 18)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            ),
            elevation: MaterialStateProperty.all(6),
            backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
              if (states.contains(MaterialState.pressed)) {
                return AppColors.lavender;
              }
              return AppColors.sapphire;
            }),
            foregroundColor: MaterialStateProperty.all(AppColors.lace),
            overlayColor: MaterialStateProperty.all(AppColors.lavender.withOpacity(0.15)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.bridalBlue.withOpacity(0.7),
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
        highlightColor: AppColors.lavender.withOpacity(0.1),
      ),
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      initialRoute: '/',
      routes: {
        '/': (context) => const ChooseRecipientScreen(),
        '/my_qr_code': (context) => const MyQRCodeScreen(),
        '/enter_amount': (context) => const EnterAmountScreen(),
        '/confirm_transfer': (context) => const ConfirmTransferScreen(),
        '/schedule_transfer': (context) => const ScheduleTransferScreen(),
        '/recurring_transfer_confirmation': (context) => const RecurringTransferConfirmationScreen(),
        '/transaction_history': (context) => const TransactionHistoryScreen(),
        '/received_funds': (context) => const ReceivedFundsScreen(),
        '/transaction_invoice' : (context) => const TransactionInvoiceScreen()
      },
    );
  }
}
