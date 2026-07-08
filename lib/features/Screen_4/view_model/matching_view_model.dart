import 'dart:async';
import 'package:flutter/foundation.dart';

class MatchingViewModel extends ChangeNotifier {
  bool _isSearching = true;
  Timer? _timer;

  MatchingViewModel() {
    _startSearchTimer();
  }

  bool get isSearching => _isSearching;

  void _startSearchTimer() {
    _timer = Timer(const Duration(seconds: 4), () {
      _isSearching = false;
      notifyListeners();
    });
  }

  void goHome({
    required VoidCallback onShowMessage,
    required VoidCallback onNavigate,
  }) {
    onShowMessage();
    Future.delayed(const Duration(milliseconds: 700), () {
      onNavigate();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
