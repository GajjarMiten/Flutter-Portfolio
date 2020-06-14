import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ScrollControllerProvider with ChangeNotifier {
  int _currentIndex = 0;
  final ScrollController _controller = ScrollController(
    initialScrollOffset: 0,
  );

  ScrollController get getController => _controller;
  int get getCurrentIndex => _currentIndex;

  void setCurrentIndex(int index) {
   _currentIndex = index;
   notifyListeners();
  }
}
