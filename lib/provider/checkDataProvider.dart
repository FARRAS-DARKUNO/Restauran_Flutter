import 'package:flutter/foundation.dart';
import 'package:restauran_app_revisi/componen/empty.dart';

class CheckDataProvider extends ChangeNotifier {
  String _checking = '';

  set checking(newValue) {
    _checking = newValue;
    notifyListeners();
  }

  String get checking => _checking;
}
