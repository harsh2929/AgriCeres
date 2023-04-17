//Agriculture Helpline App


import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AgricultureHelplinePage extends StatelessWidget {
  final String haryanaHelplineNumber = '+91 1800-180-2117';
  final String rajasthanHelplineNumber = '+91 1800-180-1551';
  final String punjabHelplineNumber = '+91 1800-180-1551';
  final String researchLabNumber = '+91 1800-180-9999'; // Research lab helpline number

  void _launchPhoneCall(String phoneNumber) async {
    if (await canLaunch('tel:$phoneNumber')) {
      await launch('tel:$phoneNumber');
    } else {
      throw 'Could not launch phone call';
    }
  }

  void _launchEmail(String email) async {
    if (await canLaunch('mailto:$email')) {
      await launch('mailto:$email');
    } else {
      throw 'Could not launch email';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agriculture Helpline'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _launchPhoneCall(haryanaHelplineNumber),
              child: Text('Call Haryana Helpline'),
            ),
            ElevatedButton(
              onPressed: () => _launchPhoneCall(rajasthanHelplineNumber),
              child: Text('Call Rajasthan Helpline'),
            ),
            ElevatedButton(
              onPressed: () => _launchPhoneCall(punjabHelplineNumber),
              child: Text('Call Punjab Helpline'),
            ),
            ElevatedButton(
              onPressed: () => _launchPhoneCall(researchLabNumber), // Call nearest research lab for soil testing
              child: Text('Call Research Lab for Soil Testing'),
            ),
            ElevatedButton(
              onPressed: () => _launchEmail('agrihelpline@gov.in'),
              child: Text('Email for Agriculture Help'),
            ),
            ElevatedButton(
              onPressed: () => _showStateHelplineDialog(context),
              child: Text('Select State for Helpline'),
            ),
            ElevatedButton(
              onPressed: () => _showHelpAndSupportDialog(context),
              child: Text('Help and Support'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _trackEvent('click_floating_action_button'),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showStateHelplineDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select State'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () => _launchPhoneCall(haryanaHelplineNumber),
                child: Text('Haryana'),
              ),
              ElevatedButton(
                onPressed: () => _launchPhoneCall(rajasthanHelplineNumber),
                child: Text('Rajasthan'),
              ),
              ElevatedButton(
                onPressed: () => _launchPhoneCall(punjabHelplineNumber),
                child: Text('Punjab'),
              ),
              ElevatedButton(
                onPressed: () => _launchEmail('agrihelpline@gov.in'),
                child: Text('Email for Agriculture Help'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showHelpAndSupportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext) {
return AlertDialog(
title: Text('Help and Support'),
content: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text('For any assistance or support, please contact:'),
ElevatedButton(
onPressed: () => _launchPhoneCall(haryanaHelplineNumber),
child: Text('Call Haryana Helpline'),
),
ElevatedButton(
onPressed: () => _launchPhoneCall(rajasthanHelplineNumber),
child: Text('Call Rajasthan Helpline'),
),
ElevatedButton(
onPressed: () => _launchPhoneCall(punjabHelplineNumber),
child: Text('Call Punjab Helpline'),
),
ElevatedButton(
onPressed: () => _launchEmail('agrihelpline@gov.in'),
child: Text('Email for Agriculture Help'),
),
],
),
);
},
);
}

}
void _trackEvent(String eventName) {
  // Replace the following lines with actual implementation of event tracking logic
  
  // Example: Send event data to backend server
  String backendUrl = 'https://analytics.example.com/track_event';
  Map<String, dynamic> eventData = {
    'event_name': eventName,
    'timestamp': DateTime.now().toString(),
    // Include any additional data related to the event
  };
  
  // // Make HTTP POST request to send event data to backend server
  // http.post(Uri.parse(backendUrl), body: jsonEncode(eventData))
  //     .then((response) {
  //   if (response.statusCode == 200) {
  //     print('Event tracked successfully: $eventName');
  //   } else {
  //     print('Failed to track event: $eventName');
  //   }
  // }).catchError((error) {
  //   print('Error tracking event: $error');
  // });
  
  // Example: Track event using a third-party analytics service
  // Replace 'AnalyticsService' with the actual name of the analytics service SDK
  // Initialize the analytics service before using it
  // AnalyticsService.init();
  
  // Send event data to the analytics service
  // Replace 'eventName' with the actual event name used by the analytics service
  // AnalyticsService.trackEvent(eventName);
  
  // Note: The above code assumes that you have already integrated the analytics service SDK into your project and have initialized it as required.
}





