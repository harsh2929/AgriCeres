import 'dart:io';
import 'dart:math';
import 'package:googleapis/natural_language_v1.dart';
import 'package:googleapis_auth/auth_io.dart';

class News {
  final String title;
  final String category;

  News({this.title, this.category});
}

class AppUsage {
  final String appName;
  final int usageCount;

  AppUsage({this.appName, this.usageCount});
}

class NewsSuggestion {
  static List<News> allNews = [
    News(title: "Breaking News 1", category: "Politics"),
    News(title: "Breaking News 2", category: "Business"),
    News(title: "Breaking News 3", category: "Technology"),
    News(title: "Breaking News 4", category: "Sports"),
    News(title: "Breaking News 5", category: "Entertainment"),
  ];

  static List<AppUsage> appUsages = [
    AppUsage(appName: "NewsApp", usageCount: 25),
    AppUsage(appName: "SocialMediaApp", usageCount: 15),
    AppUsage(appName: "WeatherApp", usageCount: 10),
    AppUsage(appName: "MusicApp", usageCount: 5),
  ];

  static Future<List<News>> getNewsSuggestions(int limit) async {
    List<News> suggestions = [];

    // Sort app usages by usage count in descending order
    appUsages.sort((a, b) => b.usageCount.compareTo(a.usageCount));

    // Get the most used app
    AppUsage mostUsedApp = appUsages.isNotEmpty ? appUsages.first : null;

    if (mostUsedApp != null) {
      // Get news suggestions based on most used app category
      String mostUsedAppCategory = await getCategoryForApp(mostUsedApp.appName);
      suggestions = allNews
          .where((news) => news.category == mostUsedAppCategory)
          .toList();
    }

    // If no suggestions found based on most used app category,
    // randomly select some news from all available news
    if (suggestions.isEmpty) {
      suggestions = getRandomNews();
    }

    // Limit the number of news suggestions
    suggestions = suggestions.take(limit).toList();

    return suggestions;
  }

  static Future<String> getCategoryForApp(String appName) async {
    // Authenticate with Google Cloud Natural Language API
    final credentials = await obtainAccessCredentialsViaServiceAccount(
        ServiceAccountCredentials.fromJson({
          "private_key": "<PRIVATE_KEY>",
          "client_email": "<CLIENT_EMAIL>",
          "project_id": "<PROJECT_ID>"
        }),
        null,
        [NaturalLanguageApi.CloudPlatformScope]);

    final naturalLanguage = NaturalLanguageApi(credentials);
    final analyzeEntitiesRequest = AnalyzeEntitiesRequest()
      ..document = Document()
      ..document.type = "PLAIN_TEXT"
      ..document.content = appName;
    final result =
        await naturalLanguage.documents.analyzeEntities(analyzeEntitiesRequest);

    // Extract category from the API response
    if (result.entities.isNotEmpty) {
      for (var entity in result.entities) {
        if (entity.type == "CATEGORY") {
          return entity.name;
        }
      }
    }

    return "Other";
  }

  static List<News> getRandomNews() {
    List<News> suggestions = [];
    Random random = Random();

    // Generate 3 random news suggestions from all available news
    while (suggestions.length < 3) {
      int index = random.nextInt(allNews.length);
      if (!suggestions.contains(allNews[index])) {
        suggestions.add(allNews[index]);
      }
    }

    return suggestions;
  }
}

void main() async {
  // Call the getNewsSuggestions method to get news suggestions
  List<News> newsSuggestions = await NewsSuggestion.getNewsSuggestions(5);

  // Print the news suggestions
  print("News Suggestions:");
  for (var news in newsSuggestions) {
    print("Title: ${news.title}, Category: ${news.category}");
  }
}
