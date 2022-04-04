import 'package:flutter/material.dart';
import 'package:restauran_app_revisi/api/get_home_detail.dart';
import 'package:restauran_app_revisi/model/home_detail_data/homedata.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantProvider with ChangeNotifier {
  late final HomeDetail apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  late HomeData _restaurant;
  String _message = '';
  late ResultState _state;

  String get message => _message;

  HomeData get result => _restaurant;

  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final resto = await apiService.getHomeDetailData();
      if (resto.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurant = resto;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
