import 'dart:convert';
import 'food.dart';
import 'drink.dart';

class Menus {
  final List<Food> foods;
  final List<Drink> drinks;
  Menus({
    required this.foods,
    required this.drinks,
  });

  Menus copyWith({
    List<Food>? foods,
    List<Drink>? drinks,
  }) {
    return Menus(
      foods: foods ?? this.foods,
      drinks: drinks ?? this.drinks,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'foods': foods.map((x) => x.toMap()).toList(),
      'drinks': drinks.map((x) => x.toMap()).toList(),
    };
  }

  factory Menus.fromMap(Map<String, dynamic> map) {
    return Menus(
      foods: List<Food>.from(map['foods']?.map((x) => Food.fromMap(x))),
      drinks: List<Drink>.from(map['drinks']?.map((x) => Drink.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Menus.fromJson(String source) => Menus.fromMap(json.decode(source));

  @override
  String toString() => 'Menus(foods: $foods, drinks: $drinks)';

  @override
  int get hashCode => foods.hashCode ^ drinks.hashCode;
}
