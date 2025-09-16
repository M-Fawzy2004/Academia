import 'dart:async';
import 'package:flutter/material.dart';
import 'package:study_box/feature/courses/data/service/quotes_service.dart';
import 'quote.dart';

class QuoteProvider with ChangeNotifier {
  Quote? currentQuote;
  Timer? _timer;

  QuoteProvider() {
    _loadQuote();
    _timer = Timer.periodic(const Duration(hours: 6), (timer) {
      _loadQuote();
    });
  }

  Future<void> _loadQuote() async {
    currentQuote = await QuotesService.getRandomQuote();
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
