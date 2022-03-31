import 'dart:convert';

class Searching {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  Searching({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  Searching copyWith({
    String? id,
    String? name,
    String? description,
    String? pictureId,
    String? city,
    double? rating,
  }) {
    return Searching(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      pictureId: pictureId ?? this.pictureId,
      city: city ?? this.city,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'description': description});
    result.addAll({'pictureId': pictureId});
    result.addAll({'city': city});
    result.addAll({'rating': rating});

    return result;
  }

  factory Searching.fromMap(Map<String, dynamic> map) {
    return Searching(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      pictureId: map['pictureId'] ?? '',
      city: map['city'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Searching.fromJson(Map<String, dynamic> source) =>
      Searching.fromMap(source);

  @override
  String toString() {
    return 'Restaurant(id: $id, name: $name, description: $description, pictureId: $pictureId, city: $city, rating: $rating)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Searching &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.pictureId == pictureId &&
        other.city == city &&
        other.rating == rating;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        pictureId.hashCode ^
        city.hashCode ^
        rating.hashCode;
  }
}
