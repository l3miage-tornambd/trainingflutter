/*
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Item {
  final int id;
  final String description;
  final String category;
  bool isDone;

  Item({
    required this.id,
    required this.description,
    required this.category,
    this.isDone = false,
  });
}

class Category {
  final String name;
  final Color backgroundColor;
  final List<Item> items;

  Category({
    required this.name,
    required this.backgroundColor,
    required this.items,
  });
}

class CheckList {
  final String title;
  final List<Category> categories;

  CheckList({required this.title, required this.categories});
}

class CheckListNotifier extends ChangeNotifier {
  CheckList checkList = CheckList(
    title: 'My Checklist',
    categories: [
      Category(
        name: 'Category A',
        backgroundColor: Colors.blue,
        items: [
          Item(id: 1, description: 'Item 1', category: 'Category A'),
          Item(id: 2, description: 'Item 2', category: 'Category A'),
        ],
      ),
      Category(
        name: 'Category B',
        backgroundColor: Colors.green,
        items: [
          Item(id: 3, description: 'Item 3', category: 'Category B'),
          Item(id: 4, description: 'Item 4', category: 'Category B'),
        ],
      ),
      Category(
        name: 'Category C',
        backgroundColor: Colors.orange,
        items: [
          Item(id: 5, description: 'Item 5', category: 'Category C'),
          Item(id: 6, description: 'Item 6', category: 'Category C'),
        ],
      ),
    ],
  );

  void reorderCategories(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final category = checkList.categories.removeAt(oldIndex);
    checkList.categories.insert(newIndex, category);
    notifyListeners();
  }

  void reorderItemsInCategory(int categoryIndex, int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final category = checkList.categories[categoryIndex];
    final item = category.items.removeAt(oldIndex);
    category.items.insert(newIndex, item);
    notifyListeners();
  }

  void toggleItem(int categoryIndex, int itemIndex) {
    final item = checkList.categories[categoryIndex].items[itemIndex];
    item.isDone = !item.isDone;
    notifyListeners();
  }

  void addItemToCategory(int categoryIndex) {
    final category = checkList.categories[categoryIndex];
    category.items.add(
      Item(
        id: category.items.length + 1,
        description: 'New Item ${category.items.length + 1}',
        category: category.name,
      ),
    );
    notifyListeners();
  }
}



class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final checkListNotifier = context.watch<CheckListNotifier>();
    final checkList = checkListNotifier.checkList;

    return Scaffold(
      appBar: AppBar(title: Text(checkList.title)),
      body: ReorderableListView.builder(
        itemCount: checkList.categories.length,
        onReorder: (oldIndex, newIndex) {
          checkListNotifier.reorderCategories(oldIndex, newIndex);
        },
        proxyDecorator: (child, index, animation) {
          // Applique un style visuel aux catégories pendant le glissement
          return Material(
            elevation: 6,
            color: Colors.grey.withOpacity(0.9),
            child: child,
          );
        },
        itemBuilder: (context, categoryIndex) {
          final category = checkList.categories[categoryIndex];
          return GestureDetector(
            key: ValueKey(category.name),
            onHorizontalDragStart: (_) {}, // Démarrage instantané
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              padding: const EdgeInsets.all(8.0),
              color: category.backgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  ReorderableListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: category.items.length,
                    onReorder: (oldIndex, newIndex) {
                      checkListNotifier.reorderItemsInCategory(
                          categoryIndex, oldIndex, newIndex);
                    },
                    proxyDecorator: (child, index, animation) {
                      // Style visuel pour les items
                      return Material(
                        elevation: 3,
                        color: Colors.blue.withOpacity(0.8),
                        child: child,
                      );
                    },
                    itemBuilder: (context, itemIndex) {
                      final item = category.items[itemIndex];
                      return CheckboxListTile(
                        key: ValueKey(item.id),
                        title: Text(item.description),
                        subtitle: Text(item.category),
                        value: item.isDone,
                        onChanged: (bool? value) {
                          checkListNotifier.toggleItem(categoryIndex, itemIndex);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          checkListNotifier.addItemToCategory(0); // Ajoute dans la première catégorie par défaut
        },
        child: Icon(Icons.add),
      ),
    );
  }
}*/
