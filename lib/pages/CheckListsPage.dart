import 'package:flutter/material.dart';
import 'package:projects/models/CheckListNotifier.dart';
import 'package:projects/pages/CheckListItemPage.dart';
import 'package:provider/provider.dart';

class CheckListsPage extends StatefulWidget {

  final String title;

  CheckListsPage({super.key, required this.title});

  @override
  State<CheckListsPage> createState() => _CheckListsPageState();
}

class _CheckListsPageState extends State<CheckListsPage> {

  @override
  Widget build(BuildContext context) {

    final checkListNotifier = context.watch<CheckListNotifier>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: checkListNotifier.checkLists.length,
        itemBuilder: (context, index) {
          final checkList = checkListNotifier.checkLists[index];
          return ListTile(
            title: Text(checkList.title),
            subtitle: checkList.items.isEmpty ? Text('0/0') :
            Text(checkList.items.every((item) => (item.isDone)) ?
              '${checkList.items.where((item) => item.isDone).length}/${checkList.items.length} Completed' :
              '${checkList.items.where((item) => item.isDone).length}/${checkList.items.length}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CheckListItemPage(checkList: checkList),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          checkListNotifier.addCheckList(
            checkListNotifier.checkLists,
            CheckList(
              id: checkListNotifier.checkLists.length + 1,
              title: 'New Checklist',
              items: [],
            ),
          );
        },
        tooltip: 'Add a new checklist',
        child: const Icon(Icons.add),
      ),
    );
  }
}



