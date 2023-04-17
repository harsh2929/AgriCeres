import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class AgricultureNewsPage extends StatefulWidget {
  @override
  _AgricultureNewsPageState createState() => _AgricultureNewsPageState();
}

class _AgricultureNewsPageState extends State<AgricultureNewsPage> {
  List<NewsArticle> _newsArticles = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    try {
      //http.get(Uri.https('https://swapi.co', 'api/people'));

      final response = await http.get(Uri.https(
          "https://newsapi.org/v2/top-headlines?country=us&category=agriculture&apiKey=545e5e9a0e084454b7cfebf00aa61581"));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          _newsArticles = (jsonData['articles'] as List)
              .map((article) => NewsArticle.fromJson(article))
              .toList();
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agriculture News'),
      ),
      body: Container(
        color: Colors.green, // Set background color to green
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _newsArticles.length,
                itemBuilder: (context, index) {
                  final article = _newsArticles[index];
                  return Card(
                    margin: EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(
                        article.title,
                        style: TextStyle(fontSize: 18.0),
                      ),
                      subtitle: Text(article.description),
                      onTap: () => _openArticleUrl(article.url),
                    ),
                  );
                },
              ),
      ),
    );
  }

  void _openArticleUrl(String url) async {
    Uri articleUrl = Uri.parse(url); // Convert string to Uri
    if (await canLaunch(articleUrl.toString())) {
      // Pass Uri object to canLaunch method
      await launch(articleUrl.toString()); // Pass Uri object to launch method
    } else {
      print('Failed to launch URL: $url');
    }
  }
}

class NewsArticle {
  final String title;
  final String description;
  final String url;

  NewsArticle(
      {required this.title, required this.description, required this.url});

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'],
      description: json['description'],
      url: json['url'],
    );
  }
}



/*
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsRecommendationPage extends StatefulWidget {
  @override
  _NewsRecommendationPageState createState() => _NewsRecommendationPageState();
}

class _NewsRecommendationPageState extends State<NewsRecommendationPage> {
  WebView _webView;
  bool _isLoading = true;
  String _recommendedNews = '';

  @override
  void initState() {
    super.initState();
    _webView = WebView(
      initialUrl: 'https://example.com/news',
      javascriptMode: JavascriptMode.unrestricted,
      onPageFinished: (value) {
        setState(() {
          _isLoading = false;
        });
      },
      navigationDelegate: (NavigationRequest request) {
        if (request.url.startsWith('https://example.com/news')) {
          // Get user cookies and site history here
          String cookies = '';
          String history = '';
          _webView.evaluateJavascript('window.document.cookie').then((value) {
            cookies = value;
          });
          _webView.evaluateJavascript('window.history').then((value) {
            history = value;
          });

          // Call API with user cookies and site history to get news recommendation
          // TODO: Make API call with cookies and history data
          _makeNewsRecommendationApiCall(cookies, history);

          // Prevent navigating to the original request URL
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
    );
  }

  void _makeNewsRecommendationApiCall(String cookies, String history) {
    
    // Example API call using cookies and history data
    String apiEndpoint = 'https://example.com/news/recommendation';
    String requestPayload = '{"cookies": "$cookies", "history": "$history"}';

   api call

    // Example response from the API containing recommended news
    String response = '{"news": ["News 1", "News 2", "News 3"]}';
    setState(() {
      _recommendedNews = response;
    });
  }

  @override
  void dispose() {
    _webView.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Recommendation'),
      ),
      body: Stack(
        children: [
          _webView,
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
          if (!_isLoading && _recommendedNews.isNotEmpty)
            Positioned(
              bottom: 16.0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                color: Colors.grey[200],
                child: Text(
                  'Recommended News: $_recommendedNews',
                  style: TextStyle(fontSize: 16.0),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

*
*/
