import 'package:flutter/foundation.dart';
import '../models/article.dart';
import '../services/nyt_api_service.dart';

class HomeViewModel {
  final NYTApiService _apiService = NYTApiService();

  List<Article> _articles = [];
  bool _isLoading = false;
  String? _error;
  String _selectedPeriod = '7'; // Default to 7 days
  String _selectedType = 'Most Popular'; // Default to most popular

  // Callback functions for UI updates
  VoidCallback? onStateChanged;

  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get selectedPeriod => _selectedPeriod;
  String get selectedType => _selectedType;

  // Available article types
  static const List<String> articleTypes = [
    'Most Popular',
    'Most Emailed',
    'Most Shared',
  ];

  Future<void> loadArticles() async {
    _setLoading(true);
    _error = null;

    try {
      List<Article> articles;
      switch (_selectedType) {
        case 'Most Popular':
          articles = await _apiService.getMostPopularArticles(
            period: int.parse(_selectedPeriod),
          );
          break;
        case 'Most Emailed':
          articles = await _apiService.getMostEmailedArticles(
            period: int.parse(_selectedPeriod),
          );
          break;
        case 'Most Shared':
          articles = await _apiService.getMostSharedArticles(
            period: int.parse(_selectedPeriod),
          );
          break;
        default:
          articles = await _apiService.getMostPopularArticles(
            period: int.parse(_selectedPeriod),
          );
      }
      _articles = articles;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  void setPeriod(String period) {
    _selectedPeriod = period;
    _notifyListeners();
  }

  void setArticleType(String type) {
    _selectedType = type;
    _notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    _notifyListeners();
  }

  void clearError() {
    _error = null;
    _notifyListeners();
  }

  void _notifyListeners() {
    onStateChanged?.call();
  }
}
