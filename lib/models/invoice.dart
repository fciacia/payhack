class Invoice {
  final String id;
  final String recipient;           // @username or wallet address
  final double amount;
  final String currency;            // e.g. MYR, USD
  final DateTime dueDate;
  bool paid;

  Invoice({
    required this.id,
    required this.recipient,
    required this.amount,
    required this.currency,
    required this.dueDate,
    this.paid = false,
  });
}
