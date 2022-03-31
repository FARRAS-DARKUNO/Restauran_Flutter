import 'dart:convert';
import 'menu.dart';

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String city;
  final String pictureId;
  final Menus menus;
  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.pictureId,
    required this.menus,
  });

  Restaurant copyWith({
    String? id,
    String? name,
    String? description,
    String? city,
    String? pictureId,
    Menus? menus,
  }) {
    return Restaurant(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      city: city ?? this.city,
      pictureId: pictureId ?? this.pictureId,
      menus: menus ?? this.menus,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'city': city,
      'pictureId': pictureId,
      'menus': menus.toMap(),
    };
  }

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      city: map['city'] ?? '',
      pictureId: map['pictureId'] ?? '',
      menus: Menus.fromMap(map['menus']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Restaurant.fromJson(Map<String, dynamic> source) =>
      Restaurant.fromMap(source);

  @override
  String toString() {
    return 'Restaurant(id: $id, name: $name, description: $description, city: $city, pictureId: $pictureId, menus: $menus)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Restaurant &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.city == city &&
        other.pictureId == pictureId &&
        other.menus == menus;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        city.hashCode ^
        pictureId.hashCode ^
        menus.hashCode;
  }
}
