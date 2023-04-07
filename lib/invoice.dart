import 'package:flutter/material.dart';

class Invoice {
  String invoiceNumber;
  String customerName;
  double amount;
  DateTime date;

  Invoice({this.invoiceNumber, this.customerName, this.amount, this.date});
}

class Transaction {
  String transactionId;
  String beneficiaryName;
  double amount;
  DateTime date;

  Transaction(
      {this.transactionId, this.beneficiaryName, this.amount, this.date});
}

class AppHistory {
  String action;
  DateTime date;

  AppHistory({this.action, this.date});
}

class InvoiceGeneratorPage extends StatefulWidget {
  @override
  _InvoiceGeneratorPageState createState() => _InvoiceGeneratorPageState();
}

class _InvoiceGeneratorPageState extends State<InvoiceGeneratorPage> {
  List<Invoice> invoices = [];
  List<Transaction> transactions = [];
  List<AppHistory> appHistory = [];

  void _generateInvoice(
      String invoiceNumber, String customerName, double amount) {
    // Perform invoice generation logic here
    // This could involve generating a PDF invoice, saving invoice details to a database, etc.
    // You can customize this method based on your specific use case
    // For demonstration purposes, we'll just create a new Invoice object and add it to the invoices list
    setState(() {
      invoices.add(Invoice(
        invoiceNumber: invoiceNumber,
        customerName: customerName,
        amount: amount,
        date: DateTime.now(),
      ));
    });

    // Add app history
    setState(() {
      appHistory.add(AppHistory(
        action: 'Invoice generated',
        date: DateTime.now(),
      ));
    });
  }

  void _performTransaction(
      String transactionId, String beneficiaryName, double amount) {
    // Perform transaction logic here
    // This could involve calling a payment gateway API, updating account balances, etc.
    // You can customize this method based on your specific use case
    // For demonstration purposes, we'll just create a new Transaction object and add it to the transactions list
    setState(() {
      transactions.add(Transaction(
        transactionId: transactionId,
        beneficiaryName: beneficiaryName,
        amount: amount,
        date: DateTime.now(),
      ));
    });

    // Add app history
    setState(() {
      appHistory.add(AppHistory(
        action: 'Transaction performed',
        date: DateTime.now(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice Generator'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              _generateInvoice('INV001', 'John Doe', 1000.00);
            },
            child: Text('Generate Invoice'),
          ),
          ElevatedButton(
            onPressed: () {
              _performTransaction('TXN001', 'Jane Smith', 500.00);
            },
            child: Text('Perform Transaction'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: appHistory.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(appHistory[index].action),
                  subtitle: Text(appHistory[index].date.toString()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
