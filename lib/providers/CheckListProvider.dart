import 'package:flutter/material.dart';
import '../models/CheckList.dart';

class CheckListProvider with ChangeNotifier {
  CheckList? _currentCheckList;
  bool _isExpanded = false;

  CheckList? get currentCheckList => _currentCheckList;
  bool get isExpanded => _isExpanded;

  void setCheckList(CheckList checkList) {
    _currentCheckList = checkList;
    _isExpanded = false;
    notifyListeners();
  }

  void toggleExpanded() {
    _isExpanded = !_isExpanded;
    notifyListeners();
  }

  void close() {
    _isExpanded = false;
    notifyListeners();
  }
}