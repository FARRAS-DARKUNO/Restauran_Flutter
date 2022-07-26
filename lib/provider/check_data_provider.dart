import 'package:flutter/foundation.dart';

class CheckDataProvider extends ChangeNotifier {
  String _checking = '';

  set checking(newValue) {
    _checking = newValue;
    notifyListeners();
  }

  String get checking => _checking;
}
