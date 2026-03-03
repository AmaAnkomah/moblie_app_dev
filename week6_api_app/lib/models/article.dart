class Article {
  final String title;
  final String description;
  final String? imageUrl;      // Nullable – some APIs don't provide image
  final String source;
  final String publishedAt;

  Article({
    required this.title,
    required this.description,
    this.imageUrl,
    required this.source,
    required this.publishedAt,
  });

  // Factory constructor creates Article from JSON
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? 'No title',
      description: json['description'] ?? 'No description',
      imageUrl: json['urlToImage'],
      source: json['source']?['name'] ?? 'Unknown',
      publishedAt: json['publishedAt'] ?? '',
    );
  }
}
