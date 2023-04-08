import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AgricultureDataPage extends StatefulWidget {
  @override
  _AgricultureDataPageState createState() => _AgricultureDataPageState();
}

class _AgricultureDataPageState extends State<AgricultureDataPage> {
  CollectionReference _farmDataCollection =
      FirebaseFirestore.instance.collection('farmData'); // Collection reference to farm data in Firestore

  void _addFarmData() {
    // Implement the logic to add farm data to Firestore
    // Example: Adding farm data to Firestore
    FarmData farmData = FarmData(
      crop: 'Corn',
      temperature: 28.5,
      humidity: 60.2,
      soilMoisture: 35.8,
    );
    _farmDataCollection.add(farmData.toMap());
  }

  void _updateFarmData(String docId) {
    // Implement the logic to update farm data in Firestore
    // Example: Updating farm data in Firestore
    FarmData farmData = FarmData(
      crop: 'Wheat',
      temperature: 25.3,
      humidity: 70.1,
      soilMoisture: 42.5,
    );
    _farmDataCollection.doc(docId).update(farmData.toMap());
  }

  void _deleteFarmData(String docId) {
    // Implement the logic to delete farm data from Firestore
    // Example: Deleting farm data from Firestore
    _farmDataCollection.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agriculture Data'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _farmDataCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData && snapshot.data.docs.length == 0) {
            return Center(
              child: Text('No farm data available.'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot document = snapshot.data.docs[index];
              FarmData farmData = FarmData.fromMap(document.data());
              return ListTile(
                title: Text('Crop: ${farmData.crop}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Temperature: ${farmData.temperature}°C'),
                    Text('Humidity: ${farmData.humidity}%'),
                    Text('Soil Moisture: ${farmData.soilMoisture}%'),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _deleteFarmData(document.id);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addFarmData,
      ),
    );
  }
}

class FarmData {
  final String crop;
  final double temperature;
  final double humidity;
  final double soilMoisture;

  FarmData({this.crop, this.temperature, this.humidity, this.soilMoisture});

  // Convert FarmData object to a Map
  Map<String, dynamic> toMap() {
    return {
      'crop': crop,
      'temperature': temperature,
      'humidity': humidity