import 'package:flutter/material.dart';
import 'package:projects/pages/CheckListItemPage.dart';
import '../models/CheckList.dart';
import '../widgets/AddItemDialog.dart';

class CheckListsPage extends StatefulWidget {

  final String title;

  CheckListsPage({super.key, required this.title});

  final List<CheckList> checkList = [
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

  @override
  State<CheckListsPage> createState() => _CheckListsPageState();
}

class _CheckListsPageState extends State<CheckListsPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Dynamic Checklist')),
      body: ListView.builder(
        itemCount: widget.checkList.length,
        itemBuilder: (context, index) {
          final checkList = widget.checkList[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ChecklistItemsPage(checklist: checkList),
              ));
              // Normalement le setState ici sert à reconstruire le widget quand on revient sur cette page pour prendre en compte les modifs
              setState(() {});
            },
            child: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    checkList.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Icon(
                    checkList.items.any((item) => !item.isDone)
                        ? Icons.radio_button_unchecked
                        : Icons.check_circle,
                    color: checkList.items.any((item) => !item.isDone)
                        ? Colors.grey
                        : Colors.green,
                  ),
                ]
              )
            )
          );
        },
      ),
    );
  }
}



