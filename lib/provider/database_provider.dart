import 'package:flutter/foundation.dart';
import 'package:restauran_app_revisi/data/database_helper.dart';
import 'package:restauran_app_revisi/model/home_detail_data/home_restoran.dart';

enum ResultStates { loading, noData, hasData, error }

class DatabaseProvider with ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getBookmarks();
  }

  late ResultStates _state;
  ResultStates get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _bookmarks = [];
  List<Restaurant> get bookmarks => _bookmarks;

  // mendapatkan data bookmark dari database.
  void _getBookmarks() async {
    _state = ResultStates.loading;
    notifyListeners();
    _bookmarks = await databaseHelper.getBookmarks();
    print(_bookmarks.length);
    if (_bookmarks.length > 0) {
      _state = ResultStates.hasData;
      notifyListeners();
    } else {
      _state = ResultStates.noData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  //menambahkan bookmark
  void addBookmark(Restaurant restaurant) async {
    print('Testing add 1');
    try {
      await databaseHelper.insertBookmark(restaurant);
      print('Testing add 2');
      _getBookmarks();
    } catch (e) {
      print('Testing add 3');
      _state = ResultStates.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  // mengembalikan status bookmark dari artikel.
  Future<bool> isBookmarked(String id) async {
    print('Testing Bookmark 1');
    final bookmarkedArticle = await databaseHelper.getBookmarkByID(id);
    return bookmarkedArticle.isNotEmpty;
  }

  //metode untuk menghapus bookmark
  void removeBookmark(String url) async {
    print('Testing Bookmark 1');
    try {
      await databaseHelper.removeBookmark(url);
      print('Testing Bookmark 2');
      _getBookmarks();
    } catch (e) {
      _state = ResultStates.error;
      _message = 'Error: $e';
      print('Testing Bookmark 3');
      notifyListeners();
    }
  }
}
