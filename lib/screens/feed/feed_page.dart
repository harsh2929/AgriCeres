import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:AgroCeres/models/fd_mdl.dart';
import 'package:AgroCeres/screens/feed/feed_details.dart';
import 'package:AgroCeres/screens/feed/feed_template.dart';
import 'package:AgroCeres/screens/weather/screens/homeScreen.dart';

import 'package:url_launcher/url_launcher.dart';

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> posts = [];
    return Scaffold(
      appBar: AppBar(
        title: Text("Feed"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              elevation: 4.0,
              color: Colors.grey,
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => WHomescreen()));
              },
              child: Row(
                children: [
                  Text(
                    "Weather",
                    style: TextStyle(color: Colors.white),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.cloud,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      //  AuthService().signOut();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<dynamic>(
              stream: Firestore.instance.collection('feed').snapshots(),
              // stream: displayRentToolsCtrl.rentToolsStrems(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  //do something with the data
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.documents.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      DocumentSnapshot feed = snapshot.data.documents[index];
                      fmdl fmdl = fmdl.fromJson(feed.data);
                      return FeedTemplate(fmdl: fmdl);
                    },
                  );
                } else if (snapshot.hasError) {
                  //do something with the error
                  return Text(snapshot.error.toString());
                }
                //the data is not ready, show a loading indicator
                return Center(child: CircularProgressIndicator());
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.call),
        onPressed: () async {
          await launch('tel:18001801551');
        },
      ),
    );
  }
}
