import 'package:flutter/material.dart';
import 'package:upi_india/upi_india.dart';

class BankingServicesPage extends StatefulWidget {
  @override
  _BankingServicesPageState createState() => _BankingServicesPageState();
}

class _BankingServicesPageState extends State<BankingServicesPage> {
  List<UpiApp>? apps;
  UpiIndia _upiIndia = UpiIndia();

  @override
  void initState() {
    super.initState();
    _getAllUpiApps();
  }

  Future<void> _getAllUpiApps() async {
    try {
      apps = await _upiIndia.getAllUpiApps(mandatoryTransactionId: false);
    } on UpiIndiaAppsGetException catch (e) {
      print("Error getting UPI apps: ${e.message}");
    }
    setState(() {});
  }

  Future<UpiResponse> _initiateTransaction(UpiApp app) async {
    try {
      UpiResponse response = await _upiIndia.startTransaction(
        app: app,
        receiverUpiId:
            "receiver-upi-id@example.com", // Replace with the receiver's UPI ID
        receiverName: 'Receiver Name',
        transactionRefId: 'TestingUpiIndiaPlugin',
        transactionNote: 'Not actual. Just an example.',
        amount: 1.00,
      );
      return response;
    } on UpiIndiaAppNotInstalledException catch (e) {
      print("Requested app not installed on device");
      return UpiResponse(status: UpiTransactionStatus.FAILURE);
    } on UpiIndiaUserCancelledException catch (e) {
      print("You cancelled the transaction");
      return UpiResponse(status: UpiTransactionStatus.FAILURE);
    } on UpiIndiaNullResponseException catch (e) {
      print("Requested app didn't return any response");
      return UpiResponse(status: UpiTransactionStatus.FAILURE);
    } on UpiIndiaInvalidParametersException catch (e) {
      print("Requested app cannot handle the transaction");
      return UpiResponse(status: UpiTransactionStatus.FAILURE);
    } catch (e) {
      print("An Unknown error has occurred");
      return UpiResponse(status: UpiTransactionStatus.FAILURE);
    }
  }

  void _handleResponse(UpiResponse response) {
    String status = response.status.toString().split('.').last;
    switch (status) {
      case 'SUCCESS':
        print("Transaction successful");
        // Handle success case here
        break;
      case 'SUBMITTED':
        print("Transaction submitted");
        // Handle submitted case here
        break;
      case 'FAILURE':
        print("Transaction failed");
        // Handle failure case here
        break;
      default:
        print("Unknown transaction status");
        // Handle unknown status here
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Banking Services"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              if (apps != null && apps!.isNotEmpty) {
                UpiApp app = apps![0]; // Select the first UPI app in the list
                UpiResponse response = await _initiateTransaction(app);
                _handleResponse(response);
              } else {
                print("No UPI apps found");
              }
            },
            child: Text("Initiate Transaction"),
          ),
        ],
      ),
    );
  }
}
