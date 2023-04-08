import 'package:flutter/material.dart';

class SoilQualityDetectionPage extends StatefulWidget {
  @override
  _SoilQualityDetectionPageState createState() =>
      _SoilQualityDetectionPageState();
}

class _SoilQualityDetectionPageState extends State<SoilQualityDetectionPage> {
  String soilQuality = '';

  Future<void> detectSoilQuality() async {
    // Code to call Google Cloud Earth Engine API for soil quality detection
    // Update soilQuality variable with the API response
    setState(() {
      soilQuality = 'Loamy Soil'; // Replace with actual detected soil quality
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Soil Quality Detection'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: detectSoilQuality,
              child: Text('Detect Soil Quality'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Detected Soil Quality:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(soilQuality, style: TextStyle(fontSize: 16.0)),
          ],
        ),
      ),
    );
  }
}
