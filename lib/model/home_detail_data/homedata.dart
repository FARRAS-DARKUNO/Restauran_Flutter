import 'dart:convert';
import 'homerestoran.dart';

class HomeData {
  final bool error;
  final String message;
  final int count;
  final List<Restaurant> restaurants;
  HomeData({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  HomeData copyWith({
    bool? error,
    String? message,
    int? count,
    List<Restaurant>? restaurants,
  }) {
    return HomeData(
      error: error ?? this.error,
      message: message ?? this.message,
      count: count ?? this.count,
      restaurants: restaurants ?? this.restaurants,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'error': error});
    result.addAll({'message': message});
    result.addAll({'count': count});
    result.addAll({'restaurants': restaurants.map((x) => x.toMap()).toList()});

    return result;
  }

  factory HomeData.fromMap(Map<String, dynamic> map) {
    return HomeData(
      error: map['error'] ?? false,
      message: map['message'] ?? '',
      count: map['count']?.toInt() ?? 0,
      restaurants: List<Restaurant>.from(
          map['restaurants']?.map((x) => Restaurant.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeData.fromJson(Map<String, dynamic> source) =>
      HomeData.fromMap(source);

  @override
  String toString() {
    return 'HomeData(error: $error, message: $message, count: $count, restaurants: $restaurants)';
  }

  @override
  int get hashCode {
    return error.hashCode ^
        message.hashCode ^
        count.hashCode ^
        restaurants.hashCode;
  }
}
