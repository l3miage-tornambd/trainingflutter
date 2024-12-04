/*
import 'package:flutter/material.dart';



class CheckListNotifier extends ChangeNotifier {

  final List<CheckList> checkLists = [
    CheckList(
      id: 1,
      title: 'My Checklist 1',
      categories: [
        Category(
          name: 'Category A',
          backgroundColor: Colors.blue,
          items: [
            Item(id: 101, description: 'Item 1', category: 'Category A'),
            Item(id: 102, description: 'Item 2', category: 'Category A'),
          ],
        ),
        Category(
          name: 'Category B',
          backgroundColor: Colors.green,
          items: [
            Item(id: 201, description: 'Item 3', category: 'Category B'),
            Item(id: 202, description: 'Item 4', category: 'Category B'),
          ],
        ),
        Category(
          name: 'Category C',
          backgroundColor: Colors.orange,
          items: [
            Item(id: 301, description: 'Item 5', category: 'Category C'),
            Item(id: 302, description: 'Item 6', category: 'Category C'),
          ],
        ),
      ],
    ),
    CheckList(
      id: 2,
      title: 'My Checklist 2',
      categories: [
        Category(
          name: 'Category A',
          backgroundColor: Colors.blue,
          items: [
            Item(id: 101, description: 'Item 1', category: 'Category A'),
            Item(id: 102, description: 'Item 2', category: 'Category A'),
          ],
        ),
        Category(
          name: 'Category B',
          backgroundColor: Colors.green,
          items: [
            Item(id: 201, description: 'Item 3', category: 'Category B'),
            Item(id: 202, description: 'Item 4', category: 'Category B'),
          ],
        ),
        Category(
          name: 'Category C',
          backgroundColor: Colors.orange,
          items: [
            Item(id: 301, description: 'Item 5', category: 'Category C'),
            Item(id: 302, description: 'Item 6', category: 'Category C'),
          ],
        ),
      ],
    ),
  ];


  void addCheckList(List<CheckList> checkLists, CheckList checkList) {
    print('Checklist id: ${checkList.id}');
    checkLists.add(checkList);
    notifyListeners();
  }

  void removeCheckList(List<CheckList> checkLists, CheckList checkList) {
    checkLists.remove(checkList);
    notifyListeners();
  }

  void addItem(CheckList checkList, int categoryIndex, Item item) {
    print('Item id: ${item.id}');
    checkList.categories[categoryIndex].items.add(item);
    notifyListeners();
  }

  void removeItem(CheckList checkList, int categoryIndex, Item item) {
    checkList.categories[categoryIndex].items.remove(item);
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

  void reorderCategories(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final category = checkLists.categories.removeAt(oldIndex);
    checkLists.categories.insert(newIndex, category);
    notifyListeners();
  }

  void reorderItemsInCategory(int categoryIndex, int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final category = checkLists.categories[categoryIndex];
    final item = category.items.removeAt(oldIndex);
    category.items.insert(newIndex, item);
    notifyListeners();
  }

  void toggleItem(int categoryIndex, int itemIndex) {
    final item = checkLists.categories[categoryIndex].items[itemIndex];
    item.isDone = !item.isDone;
    notifyListeners();
  }

  void addItemToCategory(int categoryIndex) {
    final category = checkLists.categories[categoryIndex];
    category.items.add(
      Item(
        id: category.items.length + 1,
        description: 'New Item ${category.items.length + 1}',
        category: category.name,
      ),
    );
    notifyListeners();
  }

}*/
