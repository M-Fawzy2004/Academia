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
    // Handle multiple possible field names from different APIs
    String text = '';
    String author = 'Unknown';
    String? category;

    // Try different field names for quote text
    if (json.containsKey('content') &&
        json['content']?.toString().isNotEmpty == true) {
      text = json['content'].toString();
    } else if (json.containsKey('text') &&
        json['text']?.toString().isNotEmpty == true) {
      text = json['text'].toString();
    } else if (json.containsKey('quote') &&
        json['quote']?.toString().isNotEmpty == true) {
      text = json['quote'].toString();
    } else if (json.containsKey('body') &&
        json['body']?.toString().isNotEmpty == true) {
      text = json['body'].toString();
    }

    // Try different field names for author
    if (json.containsKey('author') &&
        json['author']?.toString().isNotEmpty == true) {
      author = json['author'].toString();
    } else if (json.containsKey('source') &&
        json['source']?.toString().isNotEmpty == true) {
      author = json['source'].toString();
    }

    // Get category if available
    if (json.containsKey('category') &&
        json['category']?.toString().isNotEmpty == true) {
      category = json['category'].toString();
    }

    return Quote(
      text: text,
      author: author,
      category: category,
    );
  }

  // For debugging
  @override
  String toString() {
    return 'Quote(text: "$text", author: "$author", category: $category)';
  }
}
