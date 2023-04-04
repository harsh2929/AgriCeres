import 'package:flutter/material.dart';

class Cure extends StatelessWidget {
  String diseaseName;
  Cure(this.diseaseName);
  final disease = {
   //to add prompt
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plant Disease Recognition'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Cure : ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Text(disease[diseaseName]),
            ),
          ],
        ),
      ),
    );
  }
}
