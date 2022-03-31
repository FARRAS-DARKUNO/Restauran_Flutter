import 'api.dart';
import 'dart:convert';

import '../model/restauran_detail_data/restaurant.dart';

class RestaurantDetail {
  final Api? api = Api();

  Future<Restaurant> getRestaurantDetail(String id) async {
    final url = "http://restaurant-api.dicoding.dev/detail/" + id;

    final response = await api!.get(url);

    var jsonResponse = jsonDecode(response);
    jsonResponse = jsonResponse["restaurant"];
    print(jsonResponse.runtimeType);

    final restaurant = Restaurant.fromJson(jsonResponse);
    return restaurant;
  }
}
