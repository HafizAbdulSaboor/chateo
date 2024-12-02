import 'package:flutter/foundation.dart';

class ProviderBool with ChangeNotifier {
// get
  bool _value = false;
  bool get value => _value;
  // set
  void setValue(bool newValue) {
    _value = newValue;
    notifyListeners();
  }
}
