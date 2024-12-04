/*
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/CheckListNotifier.dart';

class CheckListItemPage extends StatelessWidget {
  final CheckList checkList;

  CheckListItemPage({required this.checkList});

  @override
  Widget build(BuildContext context) {

    final checkListNotifier = context.watch<CheckListNotifier>();

    final itemsByCategory = <String, List<Item>>{};
    for (var item in checkList.items) {
      if (!itemsByCategory.containsKey(item.category)) {
        itemsByCategory[item.category] = [];
      }
      itemsByCategory[item.category]!.add(item);
    }

    return Scaffold(
      appBar: AppBar(title: Text(checkList.title)),
      body: ReorderableListView.builder(
        itemCount: checkList.items.length,
        onReorder: (oldIndex, newIndex) {
          checkListNotifier.reorderItems(checkList, oldIndex, newIndex);
        },
        itemBuilder: (context, index) {
          final String category = itemsByCategory.keys.toList()[index];
          final List<Item>? items = itemsByCategory[category];
          return buildItem(checkListNotifier, category, items, checkList);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          checkListNotifier.addItem(
            checkList,
            Item(
              id: ((checkList.id * 100) + checkList.items.length + 1),
              description: 'Item ${checkList.items.length + 1}',
              category: 'Category A')
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildItem(CheckListNotifier checkListNotifier, String category, List<Item>? items, CheckList checkList) {
    return ExpansionTile(
      key: ValueKey(category),
      title: Text(category),
      children: items!.map((item) {
        final itemIndex = checkList.items.indexOf(item);
        return ReorderableDragStartListener(
          key: ValueKey(item.id),
          index: itemIndex,
          child: CheckboxListTile(
            title: Text(item.description),
            value: item.isDone,
            onChanged: (value) {
              checkListNotifier.toggleItem(checkList, item);
            },
          ),
        );
      }).toList(),
    );
  }
}
*/
