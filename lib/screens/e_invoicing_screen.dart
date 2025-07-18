import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/invoice_notifier.dart';
import '../models/invoice.dart';
import 'package:intl/intl.dart';

class EInvoicingScreen extends StatelessWidget {
  const EInvoicingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final invoices = context.watch<InvoiceNotifier>().invoices;

    return Scaffold(
      appBar: AppBar(title: const Text('E-Invoicing')),
      body: invoices.isEmpty
          ? const Center(child: Text('No invoices yet.'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: invoices.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, i) =>
                  _InvoiceTile(invoice: invoices[i]),
            ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('New Invoice'),
        onPressed: () => _showAddInvoiceSheet(context),
      ),
    );
  }
}

class _InvoiceTile extends StatelessWidget {
  final Invoice invoice;
  const _InvoiceTile({required this.invoice});

  @override
  Widget build(BuildContext context) {
    final dateFmt = DateFormat.yMMMEd();
    return ListTile(
      leading: CircleAvatar(
        backgroundColor:
            invoice.paid ? Colors.green : Theme.of(context).colorScheme.primary,
        child: Icon(
          invoice.paid ? Icons.check : Icons.receipt_long,
          color: Colors.white,
        ),
      ),
      title: Text(
        '@${invoice.recipient}',
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
          '${invoice.currency} ${invoice.amount.toStringAsFixed(2)} • Due ${dateFmt.format(invoice.dueDate)}'),
      trailing: IconButton(
        icon: Icon(
          invoice.paid ? Icons.toggle_off : Icons.toggle_on,
          color: invoice.paid ? Colors.grey : Colors.green,
        ),
        tooltip: invoice.paid ? 'Mark Unpaid' : 'Mark Paid',
        onPressed: () =>
            context.read<InvoiceNotifier>().togglePaid(invoice.id),
      ),
      onTap: () => _showInvoiceDetails(context, invoice),
    );
  }
}

void _showAddInvoiceSheet(BuildContext context) {
  final _recipientCtrl = TextEditingController();
  final _amountCtrl    = TextEditingController();
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
                    : DateFormat.yMMMEd().format(_dueDate!)),
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

                context.read<InvoiceNotifier>().addInvoice(
                      recipient: _recipientCtrl.text.replaceAll('@', ''),
                      amount: double.parse(_amountCtrl.text),
                      currency: _currency,
                      dueDate: _dueDate!,
                    );
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

void _showInvoiceDetails(BuildContext context, Invoice invoice) {
  final dateFmt = DateFormat.yMMMEd().add_Hm(); // e.g. 18 Jul 2025, 14:23
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
    ),
    builder: (_) {
      final notifier = context.read<InvoiceNotifier>();

      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(invoice.paid ? Icons.check_circle : Icons.receipt_long,
                    color: invoice.paid
                        ? Colors.green
                        : Theme.of(context).colorScheme.primary,
                    size: 30),
                const SizedBox(width: 10),
                Text(
                  'Invoice ${invoice.id}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  tooltip: 'Copy ID',
                  icon: const Icon(Icons.copy),
                  onPressed: () {
                    // TODO - Implement clipboard copy functionality
                    // Clipboard.setData(ClipboardData(text: invoice.id));
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(content: Text('Invoice ID copied')),
                    // );
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            _DetailRow(label: 'Recipient', value: '@${invoice.recipient}'),
            _DetailRow(
                label: 'Amount',
                value:
                    '${invoice.currency} ${invoice.amount.toStringAsFixed(2)}'),
            _DetailRow(label: 'Due Date', value: dateFmt.format(invoice.dueDate)),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor:
                      invoice.paid ? Colors.orange : Colors.green),
              icon: Icon(invoice.paid ? Icons.toggle_off : Icons.toggle_on),
              label:
                  Text(invoice.paid ? 'Mark as Unpaid' : 'Mark as Paid'),
              onPressed: () {
                notifier.togglePaid(invoice.id);
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 10),
            TextButton.icon(
              icon: const Icon(Icons.close),
              label: const Text('Close'),
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(height: 10),
          ],
        ),
      );
    },
  );
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(label,
              style:
                  const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          const Spacer(),
          Text(value, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
