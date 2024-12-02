import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/CheckListNotifier.dart';

class CheckListItemPage extends StatelessWidget {
  final CheckList checkList;

  CheckListItemPage({required this.checkList});

  @override
  Widget build(BuildContext context) {

    final checkListNotifier = context.watch<CheckListNotifier>();

    return Scaffold(
      appBar: AppBar(title: Text(checkList.title)),
      body: ReorderableListView.builder(
        itemCount: checkList.items.length,
        onReorder: (oldIndex, newIndex) {
          checkListNotifier.reorderItems(checkList, oldIndex, newIndex);
        },
        itemBuilder: (context, index) {
          final item = checkList.items[index];
          return buildItem(checkListNotifier, index, item, checkList);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          checkListNotifier.addItem(
            checkList,
            Item(
              id: ((checkList.id * 100) + checkList.items.length + 1),
              description: 'New item',
              category: 'Category',)
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildItem(CheckListNotifier checkListNotifier, int index, Item item, CheckList checkList) {
    return CheckboxListTile(
      key: ValueKey(item.id), // Nécessaire pour ReorderableListView
      title: Text(item.description),
      subtitle: Text(item.category),
      value: item.isDone,
      onChanged: (bool? value) {
        checkListNotifier.toggleItem(checkList, item);
      },
    );
  }
}