//integrating firestore into the app
// Path: lib\ainews.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

class AgricultureNewsPage extends StatefulWidget {
  @override
  _AgricultureNewsPageState createState() => _AgricultureNewsPageState();
}

class _AgricultureNewsPageState extends State<AgricultureNewsPage> {
  List<dynamic> _newsList = [];
  bool _loading = true;

  Future<void> _fetchNews() async {
    setState(() {
      _loading = true;
    });

    // Replace the API_KEY with your actual API key
    String apiKey = '545e5e9a0e084454b7cfebf00aa61581';
    String apiUrl =
        'https://newsapi.org/v2/top-headlines?country=us&category=agriculture&apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        setState(() {
          _newsList = jsonData['articles'];
          _loading = false;
        });
      } else {
        throw Exception('Failed to fetch news');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agro News'),
        backgroundColor: Colors.green,
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : _newsList.isNotEmpty
              ? ListView.builder(
                  itemCount: _newsList.length,
                  itemBuilder: (context, index) {
                    final article = _newsList[index];
                    return ListTile(
                      title: Text(article['title']),
                      subtitle: Text(article['description']),
                      onTap: () {
                        // Open the news article in a web view or any other action
                        // that you want to perform when a news article is tapped
                        // e.g. Navigator.push() to a detailed article view
                      },
                    );
                  },
                )
              : Center(child: Text('No news articles found.')),
    );
  }
}
