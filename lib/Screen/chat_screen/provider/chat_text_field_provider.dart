import 'package:flutter/material.dart';

class ChatTextFieldProvider extends ChangeNotifier {
  bool _isFocused = false;

  bool get isFocused => _isFocused;

  void updateFocus(bool value) {
    _isFocused = value;
    notifyListeners();
  }
}
