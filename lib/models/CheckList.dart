
import 'package:flutter/material.dart';

class Item {
  final int id;
  final String description;
  bool isDone;

  Item({required this.id, required this.description, this.isDone = false});

  // Méthode pour créer un Item à partir de JSON
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      description: json['description'],
      isDone: json['isDone'] ?? false,
    );
  }

  // Méthode pour convertir un Item en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'isDone': isDone,
    };
  }

}

class Category {
  final String name;
  final Color backgroundColor; // On pourrait mettre en couleur le thème de l'application + une certaine valeur pour différencier chaque catégorie
  final List<Item> items;

  Category({required this.name, required this.backgroundColor, required this.items});

  // Méthode pour créer une Category à partir de JSON
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'],
      backgroundColor: Color(json['backgroundColor']),
      items: (json['items'] as List)
          .map((itemJson) => Item.fromJson(itemJson))
          .toList(),
    );
  }

  // Méthode pour convertir une Category en JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'backgroundColor': backgroundColor.value,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

class CheckList {
  final int id;
  final String title;
  final List<Category> categories;

  CheckList({required this.id, required this.title, required this.categories});

  // Méthode pour créer une CheckList à partir de JSON
  factory CheckList.fromJson(Map<String, dynamic> json) {
    return CheckList(
      id: json['id'],
      title: json['title'],
      categories: (json['categories'] as List)
          .map((categoryJson) => Category.fromJson(categoryJson))
          .toList(),
    );
  }

  // Méthode pour convertir une CheckList en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'categories': categories.map((category) => category.toJson()).toList(),
    };
  }
}