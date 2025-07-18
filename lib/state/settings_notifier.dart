import 'package:flutter/foundation.dart';

class SettingsNotifier extends ChangeNotifier {
  bool _isBusiness = false;
  bool get isBusiness => _isBusiness;
  void toggleBusiness(bool value) {
    _isBusiness = value;
    notifyListeners();
  }
} 