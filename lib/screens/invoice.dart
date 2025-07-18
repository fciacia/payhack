// lib/state/invoice_notifier.dart
import 'package:flutter/material.dart';
import '../models/invoice.dart';
import 'dart:math';

class InvoiceNotifier extends ChangeNotifier {
  final List<Invoice> _invoices = [];

  List<Invoice> get invoices => List.unmodifiable(_invoices);

  void addInvoice({
    required String recipient,
    required double amount,
    required String currency,
    required DateTime dueDate,
  }) {
    _invoices.add(
      Invoice(
        id: Random().nextInt(999999).toString(), // demo only
        recipient: recipient,
        amount: amount,
        currency: currency,
        dueDate: dueDate,
      ),
    );
    notifyListeners();
  }

  void togglePaid(String id) {
    final idx = _invoices.indexWhere((inv) => inv.id == id);
    if (idx != -1) {
      _invoices[idx].paid = !_invoices[idx].paid;
      notifyListeners();
    }
  }
}