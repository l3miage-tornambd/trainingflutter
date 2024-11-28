import 'package:flutter/material.dart';
import 'package:projects/models/CheckList.dart';

class ChecklistItemsPage extends StatefulWidget {
  final CheckList checklist;

  const ChecklistItemsPage({Key? key, required this.checklist}) : super(key: key);

  @override
  State<ChecklistItemsPage> createState() => _ChecklistItemsPageState();
}


class _ChecklistItemsPageState extends State<ChecklistItemsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.checklist.title),
      ),
      body: ListView.builder(
        itemCount: widget.checklist.items.length,
        itemBuilder: (context, index) {
          final item = widget.checklist.items[index];
          return CheckboxListTile(
            title: Text(item.description),
            subtitle: Text(item.category),
            value: item.isDone,
            onChanged: (value) {
              setState(() {
                item.isDone = value ?? false;
              });
            },
          );
        },
      ),
    );
  }
}