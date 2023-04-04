import 'package:flutter/material.dart';
import 'package:AgroCeres/models/fd_mdl.dart';
import 'package:AgroCeres/screens/feed/feed_details.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedTemplate extends StatelessWidget {
  final fmdl fmdl;

  const FeedTemplate({Key key, this.fmdl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          _launchURL(fmdl.url);
        },
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(fmdl.img),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    offset: Offset(1.0, 1.0),
                    blurRadius: 10.0,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  // height: MediaQuery.of(context).size.height / 8,
                  width: MediaQuery.of(context).size.width - 36,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fmdl.headline,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        fmdl.date,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
