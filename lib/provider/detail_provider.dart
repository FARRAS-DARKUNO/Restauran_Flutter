import 'package:flutter/material.dart';
import 'package:restauran_app_revisi/api/get_restaurant_detail.dart';
import 'package:restauran_app_revisi/model/restauran_detail_data/restaurant.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantDetailProvider extends ChangeNotifier {
  late final RestaurantDetail apiService;
  String id;

  RestaurantDetailProvider({required this.apiService, required this.id}) {
    _fetchAllDetailRestaurant();
  }

  late Restaurant _restaurant;
  String _message = '';
  late ResultState _state;

  String get message => _message;

  Restaurant get result => _restaurant;

  ResultState get state => _state;

  Future<dynamic> _fetchAllDetailRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final resto = await apiService.getRestaurantDetail(id);
      if (resto.id.isEmpty) {
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
