
import 'package:flutter/material.dart';

class Item {
  final int id;
  final String description;
  final String category;
  bool isDone;

  Item({required this.id, required this.description, required this.category, this.isDone = false});
}

class Category {
  final String name;
  final Color backgroundColor; // On pourrait mettre en couleur le thème de l'application + une certaine valeur pour différencier chaque catégorie
  final List<Item> items;

  Category({required this.name, required this.backgroundColor, required this.items});
}

class CheckList {
  final int id;
  final String title;
  final List<Category> categories;

  CheckList({required this.id, required this.title, required this.categories});
}