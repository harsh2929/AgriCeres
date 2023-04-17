import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
//gcloud link 

/* "" https://console.cloud.google.com/vertex-ai/locations/us-central1/models/2433221431291543552/versions/1/deploy?project=fleet-cyclist-383115
""
 *\

class ImagePredictionPage extends StatefulWidget {
  @override
  _ImagePredictionPageState createState() => _ImagePredictionPageState();
}

class _ImagePredictionPageState extends State<ImagePredictionPage> {
  late File _imageFile;
  String _predictionResult = '';
  bool _isLoading = false;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _predictionResult = '';
      });
      runModelOnImage();
    }
  }

  Future<void> runModelOnImage() async {
    setState(() {
      _isLoading = true;
    });
    await Tflite.loadModel(
      model: 'assets/model.tflite',
      labels: 'assets/labels.txt',
    );
    var output = await Tflite.runModelOnImage(
      path: _imageFile.path,
    );
    setState(() {
      _isLoading = false;
      _predictionResult = output != null
          ? output.map((output) => '${output['label']}: ${output['confidence'].toStringAsFixed(2)}').join('\n')
          : 'Failed to run model';
    });
    await Tflite.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Prediction'),
      ),
      body: Column(
        children: <Widget>[
          _isLoading
              ? CircularProgressIndicator()
              : SizedBox(height: 20),
          _predictionResult.isNotEmpty
              ? Text('Predictions:\n$_predictionResult')
              : Container(),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: pickImage,
            child: Text('Click Photo / Upload Image'),
          ),
        ],
      ),
    );
  }
}
