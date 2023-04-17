import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BankAccount {
  String accountNumber;
  String accountHolderName;

  BankAccount({required this.accountNumber, required this.accountHolderName});

  factory BankAccount.fromJson(Map<String, dynamic> json) {
    return BankAccount(
      accountNumber: json['account_number'],
      accountHolderName: json['account_holder_name'],
    );
  }
}

class SbiApiPage extends StatefulWidget {
  @override
  _SbiApiPageState createState() => _SbiApiPageState();
}

class _SbiApiPageState extends State<SbiApiPage> {
  List<BankAccount> _bankAccounts = [];
  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _fetchBankAccounts() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    // Replace with your actual SBI API endpoint for fetching bank accounts
    final Uri url = Uri.parse('https://api.example.com/sbi/accounts');
    final response = await http.get(url);

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<BankAccount> accounts = data
          .map((accountJson) => BankAccount.fromJson(accountJson))
          .toList();
      setState(() {
        _bankAccounts = accounts;
      });
    } else {
      setState(() {
        _errorMessage = 'Failed to fetch bank accounts.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SBI API Integration'),
      ),
      body: Container(
        color: Colors.green,
        child: Center(
          child: Card(
            margin: EdgeInsets.all(16),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_isLoading)
                    CircularProgressIndicator()
                  else if (_errorMessage.isNotEmpty)
                    Text(
                      _errorMessage,
                      style: TextStyle(color: Colors.red),
                    )
                  else if (_bankAccounts.isEmpty)
                    Text('No bank accounts available.')
                  else
                    Column(
                      children: [
                        Text(
                          'Bank Accounts:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        for (BankAccount account in _bankAccounts)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Account Number: ${account.accountNumber}'),
                              Text('Account Holder Name: ${account.accountHolderName}'),
                              Divider(),
                            ],
                          ),
                      ],
                    ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    child: Text('Fetch Bank Accounts'),
                    onPressed: _fetchBankAccounts,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
