class Quote {
  final String text;
  final String author;
  final String? category;

  Quote({
    required this.text,
    required this.author,
    this.category,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      text: json['content'] ?? json['text'] ?? json['quote'] ?? '',
      author: json['author'] ?? 'Unknown',
      category: json['category'],
    );
  }
}
