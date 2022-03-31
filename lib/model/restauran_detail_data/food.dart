import 'dart:convert';

class Food {
  final String name;
  Food({
    required this.name,
  });

  Food copyWith({
    String? name,
  }) {
    return Food(
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Food.fromJson(String source) => Food.fromMap(json.decode(source));

  @override
  String toString() => 'Food(name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Food && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
