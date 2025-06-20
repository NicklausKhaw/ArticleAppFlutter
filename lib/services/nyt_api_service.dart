import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article.dart';
import '../config/api_config.dart';

class NYTApiService {
  Future<List<Article>> getMostPopularArticles({int period = 7}) async {
    try {
      final response = await http.get(
        Uri.parse(
          '${ApiConfig.nytBaseUrl}/viewed/$period.json?api-key=${ApiConfig.nytApiKey}',
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> results = data['results'] ?? [];

        return results.map((json) => Article.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load articles: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching articles: $e');
    }
  }

  Future<List<Article>> getMostEmailedArticles({int period = 7}) async {
    try {
      final response = await http.get(
        Uri.parse(
          '${ApiConfig.nytBaseUrl}/emailed/$period.json?api-key=${ApiConfig.nytApiKey}',
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> results = data['results'] ?? [];

        return results.map((json) => Article.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load articles: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching articles: $e');
    }
  }

  Future<List<Article>> getMostSharedArticles({int period = 7}) async {
    try {
      final response = await http.get(
        Uri.parse(
          '${ApiConfig.nytBaseUrl}/shared/$period.json?api-key=${ApiConfig.nytApiKey}',
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> results = data['results'] ?? [];

        return results.map((json) => Article.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load articles: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching articles: $e');
    }
  }
}
