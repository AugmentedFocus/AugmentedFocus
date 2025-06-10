import 'package:flutter/material.dart';

class FontSizeProvider with ChangeNotifier {
  double _fontSize = 16.0;

  double get fontSize => _fontSize;

  void increaseFontSize() {
    if (_fontSize < 24.0) {
      _fontSize += 2;
      notifyListeners();
    }
  }

  void decreaseFontSize() {
    if (_fontSize > 12.0) {
      _fontSize -= 2;
      notifyListeners();
    }
  }

  void resetFontSize() {
    _fontSize = 16.0;
    notifyListeners();
  }
}