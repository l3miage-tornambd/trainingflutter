import 'dart:async';

import 'package:flutter/material.dart';

class TimerProvider with ChangeNotifier {
  int _counter = 0;
  Timer? _timer;
  bool _isTimerRunning = false;

  int get counter => _counter;

  bool get isTimerRunning => _isTimerRunning;

  void startTimer() {

    if (_isTimerRunning) return; // Éviter les doubles timers

    _isTimerRunning = true;
    _counter = 0;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _counter++;
      notifyListeners(); // Notifie les widgets utilisant ce provider
    });
  }

  void stopTimer() {
    _isTimerRunning = false;
    _timer?.cancel();
    _timer = null;
    notifyListeners();
  }
}