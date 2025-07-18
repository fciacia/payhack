import 'package:flutter/material.dart';

class EInvoicingScreen extends StatefulWidget {
  const EInvoicingScreen({super.key});
  @override
  State<EInvoicingScreen> createState() => _EInvoicingScreenState();
}

class _EInvoicingScreenState extends State<EInvoicingScreen> {
  List<Map<String, dynamic>> invoices = [
    {
      'id': 'INV-001',
      'recipient': '@alice',
      'amount': 500.0,
      'currency': 'MYR',
      'dueDate': DateTime.now().add(const Duration(days: 7)),
      'paid': false,
    },
    {
      'id': 'INV-002',
      'recipient': '@bob',
      'amount': 1200.0,
      'currency': 'USD',
      'dueDate': DateTime.now().add(const Duration(days: 14)),
      'paid': true,
    },
  ];

  void _addInvoice(Map<String, dynamic> invoice) {
    setState(() {
      invoices.add(invoice);
    });
  }

  void _togglePaid(int index) {
    setState(() {
      invoices[index]['paid'] = !(invoices[index]['paid'] as bool);
    });
  }

  void _showAddInvoiceSheet() {
    final _recipientCtrl = TextEditingController();
    final _amountCtrl = TextEditingController();
    DateTime? _dueDate;
    String _currency = 'MYR';
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 20, left: 20, right: 20,
        ),
        child: StatefulBuilder(
          builder: (context, setState) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _recipientCtrl,
                decoration: const InputDecoration(
                  labelText: 'Recipient @username / Wallet',
                ),
              ),
              TextField(
                controller: _amountCtrl,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Amount'),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text('Currency:'),
                  const SizedBox(width: 16),
                  DropdownButton<String>(
                    value: _currency,
                    items: const [
                      DropdownMenuItem(value: 'MYR', child: Text('MYR')),
                      DropdownMenuItem(value: 'USD', child: Text('USD')),
                      DropdownMenuItem(value: 'EUR', child: Text('EUR')),
                    ],
                    onChanged: (v) => setState(() => _currency = v!),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text('Due Date:'),
                  const SizedBox(width: 16),
                  Text(_dueDate == null
                      ? 'Select'
                      : '${_dueDate!.toLocal()}'.split(' ')[0]),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                        initialDate: DateTime.now(),
                      );
                      if (picked != null) setState(() => _dueDate = picked);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Create Invoice'),
                onPressed: () {
                  if (_recipientCtrl.text.isEmpty ||
                      _amountCtrl.text.isEmpty ||
                      _dueDate == null) return;
                  _addInvoice({
                    'id': 'INV-${invoices.length + 1}',
                    'recipient': _recipientCtrl.text.replaceAll('@', ''),
                    'amount': double.parse(_amountCtrl.text),
                    'currency': _currency,
                    'dueDate': _dueDate!,
                    'paid': false,
                  });
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('E-Invoicing')),
      body: invoices.isEmpty
          ? const Center(child: Text('No invoices yet.'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: invoices.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, i) {
                final invoice = invoices[i];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                        invoice['paid'] ? Colors.green : Theme.of(context).colorScheme.primary,
                    child: Icon(
                      invoice['paid'] ? Icons.check : Icons.receipt_long,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    '@${invoice['recipient']}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                      '${invoice['currency']} ${invoice['amount'].toStringAsFixed(2)} 2 Due ${invoice['dueDate'].toLocal().toString().split(' ')[0]}'),
                  trailing: IconButton(
                    icon: Icon(
                      invoice['paid'] ? Icons.toggle_off : Icons.toggle_on,
                      color: invoice['paid'] ? Colors.grey : Colors.green,
                    ),
                    tooltip: invoice['paid'] ? 'Mark Unpaid' : 'Mark Paid',
                    onPressed: () => _togglePaid(i),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('New Invoice'),
        onPressed: _showAddInvoiceSheet,
      ),
    );
  }
}