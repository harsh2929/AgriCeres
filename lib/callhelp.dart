import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AgricultureHelplinePage extends StatelessWidget {
  final String haryanaHelplineNumber = '+91 1800-180-2117';
  final String rajasthanHelplineNumber = '+91 1800-180-1551';
  final String punjabHelplineNumber = '+91 1800-180-1551';

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
              onPressed: () => _launchEmail('agrihelpline@gov.in'),
              child: Text('Email for Agriculture Help'),
            ),
            ElevatedButton(
              onPressed: () => _showStateHelplineDialog(context),
              child: Text('Select State for Helpline'),
            ),
          ],
        ),
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
}
