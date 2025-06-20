class ApiConfig {
  // Get your API key from: https://developer.nytimes.com/get-started
  static const String nytApiKey = 'znYM3W6EIOqWVxFqTrBruQfGVxdDKxvk';

  // API endpoints
  static const String nytBaseUrl = 'https://api.nytimes.com/svc/mostpopular/v2';

  // Available periods for most popular articles
  static const List<int> availablePeriods = [1, 7, 30];
}
