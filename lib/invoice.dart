import 'package:flutter/material.dart';
import 'package:location/location.dart'; // Import the location package for accessing device location

class InvoicePage extends StatefulWidget {
  final double totalAmountSpent; // Total amount spent in the app
  final List<String> errorLogs; // List of error logs

  InvoicePage({required this.totalAmountSpent, required this.errorLogs});

  @override
  _InvoicePageState createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  LocationData? _locationData; // Location data

  @override
  void initState() {
    super.initState();
    _getLocation(); // Get the current location of the device
  }

  Future<void> _getLocation() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    // Check if location service is enabled
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    // Check if location permission is granted
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // Get the current location
    _locationData = await location.getLocation();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Total Amount Spent: \$${widget.totalAmountSpent.toStringAsFixed(2)}', // Display total amount spent
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Current Location: ${_locationData != null ? 'Latitude: ${_locationData!.latitude}, Longitude: ${_locationData!.longitude}' : 'Unknown'}', // Display current location
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Error Logs: ${widget.errorLogs.isNotEmpty ? widget.errorLogs.join(', ') : 'None'}', // Display error logs
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
