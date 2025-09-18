import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_box/feature/home/data/model/quote.dart';

class TimedQuotesService {
  static const String _baseUrl = 'https://api.api-ninjas.com/v1/quotes';
  static const String _apiKey = 'lpMQbsorTKAgpb5241A4IA==qH0PyX5TybBN57lM';

  // Keys for SharedPreferences
  static const String _cachedQuoteKey = 'cached_quote';
  static const String _lastFetchTimeKey = 'last_fetch_time';
  static const String _cachedQuoteAuthorKey = 'cached_quote_author';
  static const String _cachedQuoteCategoryKey = 'cached_quote_category';

  // 6 hours
  static const Duration cacheDuration = Duration(hours: 6);

  /// Get daily quote with 6-hour caching
  static Future<Quote> getDailyQuote() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Check if we have a cached quote and if it's still valid
      final cachedQuote = await _getCachedQuote(prefs);
      if (cachedQuote != null) {
        developer.log('Using cached quote: ${cachedQuote.text}');
        return cachedQuote;
      }

      // If no valid cached quote, fetch new one
      developer.log('Fetching new quote...');
      final newQuote = await _fetchNewQuote();

      // Cache the new quote
      await _cacheQuote(prefs, newQuote);

      return newQuote;
    } catch (e) {
      developer.log('Error in getDailyQuote: $e');
      return getFallbackQuote();
    }
  }

  /// Check if we have a valid cached quote
  static Future<Quote?> _getCachedQuote(SharedPreferences prefs) async {
    try {
      final lastFetchTime = prefs.getInt(_lastFetchTimeKey);
      final cachedQuoteText = prefs.getString(_cachedQuoteKey);
      final cachedQuoteAuthor = prefs.getString(_cachedQuoteAuthorKey);

      // If we don't have cached data, return null
      if (lastFetchTime == null ||
          cachedQuoteText == null ||
          cachedQuoteAuthor == null) {
        developer.log('No cached quote found');
        return null;
      }

      // Check if 6 hours have passed
      final lastFetch = DateTime.fromMillisecondsSinceEpoch(lastFetchTime);
      final now = DateTime.now();
      final timeDifference = now.difference(lastFetch);

      developer.log(
          'Last fetch: $lastFetch, Now: $now, Difference: ${timeDifference.inHours} hours');

      if (timeDifference < cacheDuration) {
        // Cache is still valid
        final cachedQuoteCategory = prefs.getString(_cachedQuoteCategoryKey);

        return Quote(
          text: cachedQuoteText,
          author: cachedQuoteAuthor,
          category: cachedQuoteCategory,
        );
      } else {
        developer
            .log('Cached quote expired (${timeDifference.inHours} hours old)');
        return null;
      }
    } catch (e) {
      developer.log('Error checking cached quote: $e');
      return null;
    }
  }

  /// Cache the quote with current timestamp
  static Future<void> _cacheQuote(SharedPreferences prefs, Quote quote) async {
    try {
      await prefs.setString(_cachedQuoteKey, quote.text);
      await prefs.setString(_cachedQuoteAuthorKey, quote.author);
      if (quote.category != null) {
        await prefs.setString(_cachedQuoteCategoryKey, quote.category!);
      }
      await prefs.setInt(
          _lastFetchTimeKey, DateTime.now().millisecondsSinceEpoch);

      developer.log('Quote cached successfully');
    } catch (e) {
      developer.log('Error caching quote: $e');
    }
  }

  /// Fetch new quote from API
  static Future<Quote> _fetchNewQuote() async {
    try {
      // Try education category first
      try {
        return await _getQuoteFromApi('education');
      } catch (e) {
        developer.log('Education category failed, trying random: $e');
        // If education fails, try random
        return await _getQuoteFromApi();
      }
    } catch (e) {
      developer.log('API fetch failed: $e');
      return getFallbackQuote();
    }
  }

  /// Get quote from API-Ninjas
  static Future<Quote> _getQuoteFromApi([String? category]) async {
    String url = _baseUrl;
    if (category != null) {
      url += '?category=$category';
    }

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'X-Api-Key': _apiKey,
      },
    ).timeout(const Duration(seconds: 10));

    developer.log('API response: ${response.statusCode}');

    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);

      if (data is List && data.isNotEmpty) {
        return Quote.fromJson(data.first);
      } else if (data is Map<String, dynamic>) {
        return Quote.fromJson(data);
      }
    }

    throw Exception('API request failed: ${response.statusCode}');
  }

  /// Force refresh quote (ignore cache)
  static Future<Quote> forceRefreshQuote() async {
    try {
      developer.log('Force refreshing quote...');

      final newQuote = await _fetchNewQuote();

      // Update cache
      final prefs = await SharedPreferences.getInstance();
      await _cacheQuote(prefs, newQuote);

      return newQuote;
    } catch (e) {
      developer.log('Error in forceRefreshQuote: $e');
      return getFallbackQuote();
    }
  }

  /// Clear cached quote (for testing)
  static Future<void> clearCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_cachedQuoteKey);
      await prefs.remove(_cachedQuoteAuthorKey);
      await prefs.remove(_cachedQuoteCategoryKey);
      await prefs.remove(_lastFetchTimeKey);
      developer.log('Cache cleared');
    } catch (e) {
      developer.log('Error clearing cache: $e');
    }
  }

  /// Get cache info for debugging
  static Future<Map<String, dynamic>> getCacheInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lastFetchTime = prefs.getInt(_lastFetchTimeKey);

      if (lastFetchTime != null) {
        final lastFetch = DateTime.fromMillisecondsSinceEpoch(lastFetchTime);
        final now = DateTime.now();
        final timeDifference = now.difference(lastFetch);

        return {
          'hasCache': true,
          'lastFetch': lastFetch.toString(),
          'hoursAgo': timeDifference.inHours,
          'isValid': timeDifference < cacheDuration,
          'cachedQuote': prefs.getString(_cachedQuoteKey),
        };
      }

      return {'hasCache': false};
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  /// Fallback quotes
  static Quote getFallbackQuote() {
    final List<Map<String, String>> fallbackQuotes = [
      {
        'text':
            'Education is the most powerful weapon which you can use to change the world.',
        'author': 'Nelson Mandela',
        'category': 'education'
      },
      {
        'text': 'The only way to do great work is to love what you do.',
        'author': 'Steve Jobs',
        'category': 'motivation'
      },
      {
        'text':
            'Success is not final, failure is not fatal: it is the courage to continue that counts.',
        'author': 'Winston Churchill',
        'category': 'motivation'
      },
      {
        'text':
            'The future belongs to those who believe in the beauty of their dreams.',
        'author': 'Eleanor Roosevelt',
        'category': 'inspiration'
      },
      {
        'text': 'Learning never exhausts the mind.',
        'author': 'Leonardo da Vinci',
        'category': 'education'
      },
    ];

    // Use hour of day to select quote so it changes throughout the day
    final now = DateTime.now();
    final index = (now.hour ~/ 6) % fallbackQuotes.length;
    final selectedQuote = fallbackQuotes[index];

    developer
        .log('Using fallback quote (time-based): ${selectedQuote['text']}');

    return Quote(
      text: selectedQuote['text']!,
      author: selectedQuote['author']!,
      category: selectedQuote['category']!,
    );
  }
}
