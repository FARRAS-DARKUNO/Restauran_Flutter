import 'package:flutter/foundation.dart';
import 'package:restauran_app_revisi/model/Searching/searching.dart';

import 'package:restauran_app_revisi/model/home_detail_data/home_restoran.dart';

class DetailPageProvider extends ChangeNotifier {
  String _checking = '';
  late Restaurant _article;

  set checking(newValue) {
    _checking = newValue;
    notifyListeners();
  }

  String get checking => _checking;

  set article(newValue) {
    _article = newValue;
    notifyListeners();
  }

  Restaurant get article => _article;

  late Searching _searching;

  set searching(newValue) {
    _searching = newValue;
    notifyListeners();
  }
}
