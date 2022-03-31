import 'dart:convert';
import 'searching.dart';

class SearchingDara {
  final bool error;
  final int founded;
  final List<Searching> restaurants;
  SearchingDara({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  SearchingDara copyWith({
    bool? error,
    int? founded,
    List<Searching>? restaurants,
  }) {
    return SearchingDara(
      error: error ?? this.error,
      founded: founded ?? this.founded,
      restaurants: restaurants ?? this.restaurants,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'error': error});
    result.addAll({'founded': founded});
    result.addAll({'restaurants': restaurants.map((x) => x.toMap()).toList()});

    return result;
  }

  factory SearchingDara.fromMap(Map<String, dynamic> map) {
    return SearchingDara(
      error: map['error'] ?? false,
      founded: map['founded']?.toInt() ?? 0,
      restaurants: List<Searching>.from(
          map['restaurants']?.map((x) => Searching.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchingDara.fromJson(Map<String, dynamic> source) =>
      SearchingDara.fromMap(source);

  @override
  String toString() =>
      'SearchingDara(error: $error, founded: $founded, restaurants: $restaurants)';

  @override
  int get hashCode => error.hashCode ^ founded.hashCode ^ restaurants.hashCode;
}
