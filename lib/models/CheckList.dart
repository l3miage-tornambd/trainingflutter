import 'package:flutter/material.dart';

class CheckList {
  final String title;
  final List<ChecklistItem> items;

  CheckList({required this.title, required this.items});
}

class ChecklistItem {
  final String description;
  final String category;
  bool isDone = false;

  ChecklistItem({required this.description, required this.category});
}

class CheckListNotifier extends ChangeNotifier {

  final checkLists = <CheckList> [
    CheckList(
      title: 'Checklist 1',
      items: [
        ChecklistItem(description: 'Item 1', category: 'Categorie A'),
        ChecklistItem(description: 'Item 2', category: 'Categorie B'),
        ChecklistItem(description: 'Item 3', category: 'Categorie C'),
        ChecklistItem(description: 'Item 4', category: 'Categorie D'),
        ChecklistItem(description: 'Item 5', category: 'Categorie A'),
        ChecklistItem(description: 'Item 6', category: 'Categorie B'),
        ChecklistItem(description: 'Item 7', category: 'Categorie C'),
        ChecklistItem(description: 'Item 8', category: 'Categorie D'),
        ChecklistItem(description: 'Item 9', category: 'Categorie A'),
      ],
    ),
    CheckList(
      title: 'Checklist 2',
      items: [
        ChecklistItem(description: 'Monter', category: 'Categorie A'),
        ChecklistItem(description: 'Descendree', category: 'Categorie B'),
        ChecklistItem(description: 'Laver', category: 'Categorie C'),
        ChecklistItem(description: 'Manger', category: 'Categorie B'),
        ChecklistItem(description: 'Mordre', category: 'Categorie A'),
        ChecklistItem(description: 'Dormir', category: 'Categorie A'),
      ],
    ),
  ];

  void addCheckList(CheckList checkList) {
    checkLists.add(checkList);
    notifyListeners();
  }

  void removeCheckList(CheckList checkList) {
    checkLists.remove(checkList);
    notifyListeners();
  }

  void addItem(CheckList checkList, ChecklistItem item) {
    checkList.items.add(item);
    notifyListeners();
  }

  void removeItem(CheckList checkList, ChecklistItem item) {
    checkList.items.remove(item);
    notifyListeners();
  }

  void toggleItem(ChecklistItem item) {
    item.isDone = !item.isDone;
    notifyListeners();
  }
}
