import 'package:flutter/material.dart';
import '../../models/article.dart';
import '../../services/api_services.dart';

class ArticleViewModel extends ChangeNotifier {
  // Dependencies
  final ApiService _apiService = ApiService();
  
  // State variables
  List<Article> _articles = [];
  bool _isLoading = false;
  String? _errorMessage;
  
  // Getters for UI to access state
  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  
  // Method to load data
  Future<void> loadArticles() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners(); // Update UI to show loading
    
    try {
      _articles = await _apiService.fetchNewsArticles();
      _isLoading = false;
      notifyListeners(); // Update UI with data
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners(); // Update UI with error
    }
  }
  
  // Refresh method (for pull-to-refresh)
  Future<void> refreshArticles() async {
    await loadArticles();
  }
}
