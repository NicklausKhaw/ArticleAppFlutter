class Article {
  final String title;
  final String abstract;
  final String url;
  final String publishedDate;
  final String section;
  final String subsection;
  final String byline;
  final String mediaUrl;

  Article({
    required this.title,
    required this.abstract,
    required this.url,
    required this.publishedDate,
    required this.section,
    required this.subsection,
    required this.byline,
    required this.mediaUrl,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    String mediaUrl = '';
    if (json['media'] != null &&
        json['media'] is List &&
        json['media'].isNotEmpty &&
        json['media'][0]['media-metadata'] != null &&
        json['media'][0]['media-metadata'] is List &&
        json['media'][0]['media-metadata'].isNotEmpty) {
      mediaUrl = json['media'][0]['media-metadata'][0]['url'] ?? '';
    }

    return Article(
      title: json['title'] ?? '',
      abstract: json['abstract'] ?? '',
      url: json['url'] ?? '',
      publishedDate: json['published_date'] ?? '',
      section: json['section'] ?? '',
      subsection: json['subsection'] ?? '',
      byline: json['byline'] ?? '',
      mediaUrl: mediaUrl,
    );
  }
}
