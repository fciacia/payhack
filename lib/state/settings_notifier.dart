import 'package:flutter/material.dart';

class SettingsNotifier extends ChangeNotifier {
  bool advancedMode = false;
  String selectedLanguage = 'English';
  String selectedCurrency = 'MYR';
  bool isBusiness = false;

  void toggleAdvanced(bool value) {
    advancedMode = value;
    notifyListeners();
  }

  void changeLanguage(String lang) {
    selectedLanguage = lang;
    notifyListeners();
  }

  void changeCurrency(String cur) {
    selectedCurrency = cur;
    notifyListeners();
  }

  void toggleBusiness(bool value) {
    isBusiness = value;
    notifyListeners();
  }
}
