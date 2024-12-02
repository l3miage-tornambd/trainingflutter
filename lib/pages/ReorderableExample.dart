import 'package:flutter/material.dart';

class ReorderableExample extends StatefulWidget {
  @override

  _ReorderableExampleState createState() => _ReorderableExampleState();
}

class _ReorderableExampleState extends State<ReorderableExample> {

  List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reorderable List Example')),
      body: ReorderableListView(
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) newIndex -= 1; // Décale le nouvel index si nécessaire
            final item = items.removeAt(oldIndex);  // Retire l'élément
            items.insert(newIndex, item);           // Insère l'élément à la nouvelle position
          });
        },
        children: List.generate(
          items.length,
              (index) {
            return ListTile(
              key: ValueKey(items[index]),  // Assurez-vous que chaque élément a une clé unique
              title: Text(items[index]),
              trailing: Icon(Icons.drag_handle),
            );
          },
        ),
      ),
    );
  }
}