import 'package:flutter/material.dart';

class Counter with ChangeNotifier {
  int _count;
  Counter(this._count);

  void add() {
    _count++;
    notifyListeners();
  }
  int get count => _count;
}