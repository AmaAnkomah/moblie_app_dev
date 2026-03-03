import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/article.dart';

class ApiService {
  // Base URL for the API
  final String baseUrl = 'newsapi.org';
  final String apiKey = 'ca48730217654575b3aa208bdd196e92'; // You'll get this from registration
  
  // Method to fetch news articles
  Future<List<Article>> fetchNewsArticles() async {
    // 1. Build the URL properly (DO NOT use string concatenation) [citation:1]
    final uri = Uri.https(
      baseUrl,
      '/v2/top-headlines',
      {
        'country': 'us',
        'apiKey': apiKey,
      },
    );
    
    // 2. Make the network request [citation:9]
    final response = await http.get(uri);
    
    // 3. Check status code [citation:9]
    if (response.statusCode == 200) {
      // 4. Parse JSON response [citation:9]
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      
      // 5. Extract articles array
      final List<dynamic> articlesJson = jsonData['articles'];
      
      // 6. Convert each JSON object to Article model
      return articlesJson.map((json) => Article.fromJson(json)).toList();
    } else {
      // 7. Handle errors [citation:9]
      throw Exception('Failed to load news: ${response.statusCode}');
    }
  }
}
