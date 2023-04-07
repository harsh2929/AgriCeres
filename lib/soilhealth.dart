import 'dart:io';
import 'package:googleapis/vision/v1.dart' as vision;
import 'package:http/http.dart' as http;

void main() async {
  // Load the image file
  File imageFile = File('path/to/image.jpg');

  // Read the image bytes
  List<int> imageBytes = await imageFile.readAsBytes();

  // Create a Vision API client
  vision.ImagesResourceApi imagesApi =
      vision.VisionApi(await _getClient()).images;

  // Convert the image bytes to base64
  String imageBase64 = base64Encode(imageBytes);

  // Create a request for image annotation
  vision.AnnotateImageRequest request = vision.AnnotateImageRequest.fromJson({
    'image': {'content': imageBase64},
    'features': [
      {'type': 'LABEL_DETECTION'},
      {'type': 'WEB_DETECTION'},
    ]
  });

  // Perform image annotation request
  vision.BatchAnnotateImagesResponse response =
      await imagesApi.annotate(request);

  // Extract labels and web entities from the response
  List<String> labels = [];
  List<String> webEntities = [];
  if (response.responses != null && response.responses!.isNotEmpty) {
    response.responses!.forEach((annotation) {
      if (annotation.labelAnnotations != null &&
          annotation.labelAnnotations!.isNotEmpty) {
        annotation.labelAnnotations!.forEach((label) {
          labels.add(label.description!);
        });
      }
      if (annotation.webDetection != null &&
          annotation.webDetection!.webEntities != null &&
          annotation.webDetection!.webEntities!.isNotEmpty) {
        annotation.webDetection!.webEntities!.forEach((entity) {
          webEntities.add(entity.description!);
        });
      }
    });
  }

  // Print the detected labels and web entities
  print('Detected Labels: $labels');
  print('Detected Web Entities: $webEntities');
}

// Helper method to get Google Cloud Vision API client
Future<vision.VisionApi> _getClient() async {
  final http.Client httpClient = http.Client();
  final vision.VisionApi visionApi = vision.VisionApi(httpClient);

  // Replace <YOUR_PRIVATE_KEY>, <YOUR_CLIENT_EMAIL>, <YOUR_PROJECT_ID> with your actual credentials
  visionApi.httpClient = await authClient(
      '<YOUR_PRIVATE_KEY>', '<YOUR_CLIENT_EMAIL>', '<YOUR_PROJECT_ID>');

  return visionApi;
}

// Helper method to authenticate with Google Cloud Vision API
Future<http.Client> authClient(
    String privateKey, String clientEmail, String projectId) async {
  final auth.ClientId clientId = auth.ClientId(clientEmail, '');
  final auth.AutoRefreshingAuthClient client = await auth
      .clientViaServiceAccount(
          clientId, privateKey, null, [vision.VisionApi.CloudVisionScope]);
  return client;
}
