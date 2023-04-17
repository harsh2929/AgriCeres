// // Sure! Here's an updated version of the Flutter page that incorporates irrigation checking using Google Earth Engine:


// //Crop analysis and prediction
// import 'package:flutter/material.dart';
// import 'package:google_earth_engine/google_earth_engine.dart';

// class CropRecommendationPage extends StatefulWidget {
//   @override
//   _CropRecommendationPageState createState() => _CropRecommendationPageState();
// }

// class _CropRecommendationPageState extends State<CropRecommendationPage> {
//   String recommendation = '';
//   String irrigationStatus = '';

//   // Function to fetch crop recommendation and irrigation status based on location and soil quality
//   void fetchCropRecommendation(double latitude, double longitude, double soilQuality) async {
//     // Initialize Google Earth Engine
//     await EarthEngine.init();

//     // Define the Earth Engine script
//     final script = '''
//       // Import required Earth Engine datasets
//       var cropData = ee.ImageCollection('your/crop/dataset');
//       var yieldData = ee.ImageCollection('your/yield/dataset');
//       var soilData = ee.ImageCollection('your/soil/dataset');
//       var ndviThreshold = 0.6; // Example NDVI threshold for irrigation status

//       // Get the current location
//       var point = ee.Geometry.Point($longitude, $latitude);

//       // Filter crop, yield, and soil data based on location
//       var crop = cropData.filterBounds(point).first();

//       var yield = yieldData.filterBounds(point).first();
//       var soil = soilData.filterBounds(point).first();

//       // Extract crop recommendation from crop, yield, and soil data
//       var recommendation = // Your crop recommendation logic here, incorporating soil quality

//       // Calculate NDVI from crop data
//       var ndvi = crop.normalizedDifference(['B8', 'B4']);

//       // Check irrigation status based on NDVI threshold
//       var irrigationStatus = '';
//       if (ndvi.gt(ndviThreshold)) {
//         irrigationStatus = 'Well-irrigated';
//       } else {
//         irrigationStatus = 'Water stressed';
//       }

//       // Return the crop recommendation and irrigation status as a string
//       return { 'recommendation': recommendation.getInfo(), 'irrigationStatus': irrigationStatus };
//     ''';
// '''
// '''
//     // Run the Earth Engine script and get the result
//     final result = await EarthEngine.evaluate(script);

//     setState(() {
//       // Update the recommendation and irrigation status state variables
//       recommendation = result['result']['recommendation'];
//       irrigationStatus = result['result']['irrigationStatus'];
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Crop Recommendation'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Crop Recommendation:',
//               style: TextStyle(fontSize: 24),
//             ),
//             Text(
//               recommendation,
//               style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Irrigation Status:',
//               style: TextStyle(fontSize: 24),
//             ),
//             Text(
//               irrigationStatus,
//               style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
//             ),
//             RaisedButton(
//               onPressed: () {
//                 // Call the fetchCropRecommendation function with the desired latitude, longitude, and soil quality
//                 fetchCropRecommendation(12.9715987, 77.5945627, 6.8); // Example location coordinates (Bengaluru, India) and soil quality (pH value)
//               },
//               child: Text('Get Crop Recommendation and Irrigation Status'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


//add web app link for best crop recc