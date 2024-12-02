import 'package:flutter/material.dart';

class Item {
  final int id;
  final String description;
  final String category;
  bool isDone;

  Item({required this.id, required this.description, required this.category, this.isDone = false});
}

class CheckList {
  final int id;
  final String title;
  final List<Item> items;

  CheckList({required this.id, required this.title, required this.items});
}

class CheckListNotifier extends ChangeNotifier {

  final List<CheckList> checkLists = [
    CheckList(
      id: 1,
      title: 'Checklist 1',
      items: [
        Item(id:101, description: 'Item 1', category: 'Categorie A'),
        Item(id:102, description: 'Item 2', category: 'Categorie B'),
      ],
    ),
    CheckList(
      id: 2,
      title: 'Checklist 2',
      items: [
        Item(id:201, description: 'Monter', category: 'Categorie A'),
        Item(id:202, description: 'Descendre', category: 'Categorie B'),
      ],
    ),
  ];

  void toggleItem(CheckList checkList, Item item) {
    item.isDone = !item.isDone;
    notifyListeners();
  }

  void addCheckList(List<CheckList> checkLists, CheckList checkList) {
    print('Checklist id: ${checkList.id}');
    checkLists.add(checkList);
    notifyListeners();
  }

  void removeCheckList(List<CheckList> checkLists, CheckList checkList) {
    checkLists.remove(checkList);
    notifyListeners();
  }

  void addItem(CheckList checkList, Item item) {
    print('Item id: ${item.id}');
    checkList.items.add(item);
    notifyListeners();
  }

  void removeItem(CheckList checkList, Item item) {
    checkList.items.remove(item);
    notifyListeners();
  }

  void reorderItems(CheckList checkList, int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final item = checkList.items.removeAt(oldIndex);
    checkList.items.insert(newIndex, item);
    notifyListeners();
  }

  void reorderCheckLists(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final checkList = checkLists.removeAt(oldIndex);
    checkLists.insert(newIndex, checkList);
    notifyListeners();
  }
}