import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyModelPrediction {
  // Define a class to represent the response from the prediction API
  // based on the expected response format

  // Define variables to hold the predicted labels and scores
  String label;
  double score;

  MyModelPrediction({this.label, this.score});

  factory MyModelPrediction.fromJson(Map<String, dynamic> json) {
    return MyModelPrediction(
      label: json['label'],
      score: json['score'].toDouble(),
    );
  }
}

class MyFlutterApp extends StatefulWidget {
  @override
  _MyFlutterAppState createState() => _MyFlutterAppState();
}

class _MyFlutterAppState extends State<MyFlutterApp> {
  // Define variables for the endpoint and project IDs
  final String endpointId = "1020676644064460800";
  final String projectId = "fleet-cyclist-383115";

  // Define a function to call the prediction API
  Future<List<MyModelPrediction>> callPredictionApi(String imageBytes) async {
    // Create a JSON object with the image data
    final Map<String, dynamic> jsonData = {
      "instances": [
        {
          "content": imageBytes,
        }
      ],
      "parameters": {
        "confidenceThreshold": 0.5,
        "maxPredictions": 5,
      },
    };

    // Convert the JSON object to a string
    String jsonString = jsonEncode(jsonData);

    // Prepare the API endpoint URL
    String apiUrl =
        'https://us-central1-aiplatform.googleapis.com/v1/projects/$projectId/locations/us-central1/endpoints/$endpointId:predict';

    // Make a POST request to the prediction API
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer ${await gcloudAuthPrintAccessToken()}',
        'Content-Type': 'application/json',
      },
      body: jsonString,
    );

    if (response.statusCode == 200) {
      // If the response is successful, parse the prediction results
      List<MyModelPrediction> predictions = [];
      final decoded = jsonDecode(response.body);
      for (var prediction in decoded['predictions']) {
        predictions.add(MyModelPrediction.fromJson(prediction));
      }
      return predictions;
    } else {
      // If the response is not successful, throw an error
      throw Exception('Failed to call prediction API');
    }
  }

  Future<String> gcloudAuthPrintAccessToken() async {
    // Function to authenticate with Google Cloud and get an access token
    // using the gcloud auth print-access-token command

    final result = await Process.run('gcloud', ['auth', 'print-access-token']);
    if (result.exitCode == 0) {
      return result.stdout.toString().trim();
    } else {
      throw Exception('Failed to get access token');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use the callPredictionApi function to call the prediction API
    // with the image data and handle the results accordingly

    return Container(
      // Widget contents
    );
  }
}