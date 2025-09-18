import 'dart:async';
import 'package:flutter/material.dart';
import 'package:study_box/feature/home/data/service/quotes_service.dart';
import 'quote.dart';
import 'dart:developer' as developer;

class QuoteProvider with ChangeNotifier {
  Quote? _currentQuote;
  Timer? _timer;
  bool _isLoading = false;
  bool _hasError = false;

  Quote? get currentQuote => _currentQuote;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  QuoteProvider() {
    _loadQuote();
    _setupPeriodicRefresh();
  }

  /// Load quote (will use cached if still valid)
  Future<void> _loadQuote() async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      developer.log('QuoteProvider: Loading quote...');

      _currentQuote = await TimedQuotesService.getDailyQuote();
      _hasError = false;

      developer.log('QuoteProvider: Quote loaded: ${_currentQuote?.text}');
    } catch (e) {
      developer.log('QuoteProvider: Error loading quote: $e');
      _currentQuote = TimedQuotesService.getFallbackQuote();
      _hasError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Setup automatic refresh every 6 hours
  void _setupPeriodicRefresh() {
    _timer = Timer.periodic(const Duration(hours: 6), (timer) {
      developer.log('QuoteProvider: Auto-refreshing quote after 6 hours');
      _loadQuote();
    });
  }

  /// Force refresh quote (ignore cache)
  Future<void> forceRefreshQuote() async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      developer.log('QuoteProvider: Force refreshing quote...');

      _currentQuote = await TimedQuotesService.forceRefreshQuote();
      _hasError = false;

      developer
          .log('QuoteProvider: Quote force refreshed: ${_currentQuote?.text}');
    } catch (e) {
      developer.log('QuoteProvider: Error force refreshing quote: $e');
      _currentQuote = TimedQuotesService.getFallbackQuote();
      _hasError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Refresh quote if needed (checks cache validity)
  Future<void> refreshIfNeeded() async {
    await _loadQuote();
  }

  /// Get cache information for debugging
  Future<Map<String, dynamic>> getCacheInfo() async {
    return await TimedQuotesService.getCacheInfo();
  }

  /// Clear cache (for testing)
  Future<void> clearCache() async {
    await TimedQuotesService.clearCache();
    await _loadQuote();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
