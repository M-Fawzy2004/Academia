import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:study_box/feature/courses/data/model/quote.dart';

class QuotesService {
  static const String _baseUrl = 'https://api.api-ninjas.com/v1/quotes';
  static const String _apiKey = 'lpMQbsorTKAgpb5241A4IA==qH0PyX5TybBN57lM';

  // Get random quote
  static Future<Quote> getRandomQuote() async {
    try {
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'X-Api-Key': _apiKey,
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        return Quote.fromJson(data.first);
      } else {
        return getFallbackQuote();
      }
    } catch (e) {
      return getFallbackQuote();
    }
  }

  // Get quote by category
  static Future<Quote> getQuoteByCategory(String category) async {
    try {
      final response = await http.get(
        Uri.parse("$_baseUrl?category=$category"),
        headers: {
          'Content-Type': 'application/json',
          'X-Api-Key': _apiKey,
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        return Quote.fromJson(data.first);
      } else {
        return getFallbackQuote();
      }
    } catch (e) {
      return getFallbackQuote();
    }
  }

  // Fallback quotes
  static Quote getFallbackQuote() {
    final List<Map<String, String>> fallbackQuotes = [
      {
        'text': 'The only way to do great work is to love what you do.',
        'author': 'Steve Jobs'
      },
      {
        'text':
            'Success is not final, failure is not fatal: it is the courage to continue that counts.',
        'author': 'Winston Churchill'
      },
    ];

    final randomQuote =
        fallbackQuotes[DateTime.now().millisecond % fallbackQuotes.length];
    return Quote(
      text: randomQuote['text']!,
      author: randomQuote['author']!,
    );
  }
}
