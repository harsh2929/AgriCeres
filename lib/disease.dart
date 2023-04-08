import 'package:flutter/material.dart';

class CropDiseaseDetectionPage extends StatefulWidget {
  @override
  _CropDiseaseDetectionPageState createState() =>
      _CropDiseaseDetectionPageState();
}

class _CropDiseaseDetectionPageState extends State<CropDiseaseDetectionPage> {
  String detectedDisease = '';
  String remedialMeasures = '';

  Future<void> detectCropDisease() async {
    // Code to call Google Cloud Vision API for crop disease detection
    // Update detectedDisease and remedialMeasures variables with the API response
    setState(() {
      detectedDisease =
          'Tomato Late Blight'; // Replace with actual detected disease
      remedialMeasures =
          'Use fungicides, remove infected plants'; // Replace with actual remedial measures
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crop Disease Detection'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: detectCropDisease,
              child: Text('Detect Crop Disease'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Detected Disease:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(detectedDisease, style: TextStyle(fontSize: 16.0)),
            SizedBox(height: 16.0),
            Text(
              'Remedial Measures:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(remedialMeasures, style: TextStyle(fontSize: 16.0)),
          ],
        ),
      ),
    );
  }
}
