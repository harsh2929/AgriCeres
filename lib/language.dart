import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class ImageTextScanPage extends StatefulWidget {
  @override
  _ImageTextScanPageState createState() => _ImageTextScanPageState();
}

class _ImageTextScanPageState extends State<ImageTextScanPage> {
  File? _pickedImage;
  String _detectedText = '';

  Future<void> _pickImage(ImageSource source) async {
    final pickedImageFile = await ImagePicker().getImage(source: source);
    if (pickedImageFile != null) {
      setState(() {
        _pickedImage = File(pickedImageFile.path);
        _detectedText = '';
      });
    }
  }

  Future<void> _scanImageText() async {
    if (_pickedImage != null) {
      final inputImage = InputImage.fromFile(_pickedImage!);
      final textDetector = GoogleMlKit.vision.textDetector();
      final RecognisedText recognisedText =
          await textDetector.processImage(inputImage);
      String detectedText = recognisedText.text;
      setState(() {
        _detectedText = detectedText;
      });
    }
  }

  Future<void> _translateTextToHindi(String text) async {
    final languageTranslator = GoogleMlKit.languageTranslator();
    final translatedText =
        await languageTranslator.translate(text, from: 'en', to: 'hi');
    setState(() {
      _detectedText = translatedText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Text Scanner'),
      ),
      body: Column(
        children: [
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () => _pickImage(ImageSource.camera),
            child: Text('Pick Image from Camera'),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () => _pickImage(ImageSource.gallery),
            child: Text('Pick Image from Gallery'),
          ),
          SizedBox(height: 16.0),
          _pickedImage != null
              ? Image.file(_pickedImage!)
              : Text('No image selected.'),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _scanImageText,
            child: Text('Scan Image for Text'),
          ),
          SizedBox(height: 16.0),
          _detectedText.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Detected Text:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(_detectedText),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () => _translateTextToHindi(_detectedText),
                      child: Text('Translate to Hindi'),
                    ),
                  ],
                )
              : Text('No text detected.'),
        ],
      ),
    );
  }
}
