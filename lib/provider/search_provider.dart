import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restauran_app_revisi/api/get_search_detail.dart';
import 'package:restauran_app_revisi/model/Searching/seacrhingdata.dart';
import 'package:restauran_app_revisi/provider/checkDataProvider.dart';

enum ResultState { loading, noData, hasData, error }

class SearchProvider extends ChangeNotifier {
  final RestauranSearch apiService;

  SearchProvider({required this.apiService}) {
    fetchAllRestaurantSearch(query);
  }

  SearchingDara? _resultRestaurantsSearch;
  String _message = '';
  String _query = '';
  ResultState? _state;

  String get message => _message;
  String get query => _query;

  SearchingDara? get result => _resultRestaurantsSearch;

  ResultState? get state => _state;

  Future<dynamic> fetchAllRestaurantSearch(String query) async {
    try {
      _state = ResultState.loading;
      _query = query;

      final restaurantSearch = await apiService.getSeacrh(query);
      if (restaurantSearch.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Restaurant or Menu\nCould Not Be Found';
      } else {
        _state = ResultState.hasData;

        notifyListeners();
        return _resultRestaurantsSearch = restaurantSearch;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
