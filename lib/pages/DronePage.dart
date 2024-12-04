import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/CheckList.dart';
import '../models/Drone.dart';
import '../providers/UserProvider.dart';

class DronePage extends StatefulWidget {
  final String title;

  const DronePage({super.key, required this.title});

  @override
  _DronePageState createState() => _DronePageState();
}

class _DronePageState extends State<DronePage> {
  @override
  Widget build(BuildContext context) {

    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      // Affiche la liste des drones du User
      body: ReorderableListView.builder(
        itemCount: userProvider.getDrones().length,
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) newIndex--;
            final Drone drone = userProvider.getDrones().removeAt(oldIndex);
            userProvider.getDrones().insert(newIndex, drone);
          });
        },
        itemBuilder: (context, index) {
          return ReorderableDragStartListener(
            key: ValueKey(userProvider.getDrones()[index]),
            index: index,
            child: ListTile(
              title: Text(userProvider.getDrones()[index].name),
              subtitle: Text(userProvider.getDrones()[index].model),
              trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => userProvider.updateDrone(userProvider.getDrones()[index]),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => userProvider.removeDrone(userProvider.getDrones()[index]),
                    ),
                    IconButton(
                      // bouton pour déplacer rapidemnt un item
                      icon: Icon(Icons.drag_handle, color: Colors.grey),

                    )
                  ]
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
      onPressed: () {
        userProvider.addDrone(Drone(id: userProvider.getDrones().length, name: "Drone ${userProvider.getDrones().length + 1}", model: "Model ${userProvider.getDrones().length + 1}", checkList: CheckList(id: userProvider.getDrones().length + 1, title: "Checklist ${userProvider.getDrones().length + 1}", categories: [])));
      },
      tooltip: 'Ajouter un drone',
      child: const Icon(Icons.add),
    ),
    );
  }
}



/*
return Scaffold(
  appBar: AppBar(
    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    title: Text(widget.title),
  ),
  // Affiche la liste des drones du User
  body: ReorderableListView.builder(
    itemCount: userProvider.getDrones().length + 1, // Augmenter le count pour inclure le bouton
    onReorder: (oldIndex, newIndex) {
      setState(() {
        if (newIndex > oldIndex) newIndex--;
        final Drone drone = userProvider.getDrones().removeAt(oldIndex);
        userProvider.getDrones().insert(newIndex, drone);
      });
    },
    itemBuilder: (context, index) {
      // Vérifie si l'index est le dernier élément
      if (index == userProvider.getDrones().length) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton.icon(
            onPressed: () {
              // Ajoutez votre logique pour ajouter un drone
              userProvider.addDrone(Drone(name: "New Drone", model: "Model X"));
            },
            icon: Icon(Icons.add),
            label: Text("Ajouter un drone"),
          ),
        );
      }
      return Container(
        key: ValueKey(userProvider.getDrones()[index]), // Nécessaire pour ReorderableListView
        color: index % 2 == 0
            ? Colors.grey.shade200
            : Colors.transparent, // Fond gris pour un sur deux
        child: ListTile(
          title: Text(userProvider.getDrones()[index].name),
          subtitle: Text(userProvider.getDrones()[index].model),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit, color: Colors.blue),
                onPressed: () => userProvider.updateDrone(userProvider.getDrones()[index]),
              ),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => userProvider.removeDrone(userProvider.getDrones()[index]),
              ),
            ],
          ),
        ),
      );
    },
  ),
);



 */

/*

  void _editDrone(int index) {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController nameController =
        TextEditingController(text: drones[index].name);
        final TextEditingController modelController =
        TextEditingController(text: drones[index].model);

        return AlertDialog(
          title: Text('Modifier le drone'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Nom'),
              ),
              TextField(
                controller: modelController,
                decoration: InputDecoration(labelText: 'Modèle'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  drones[index].name = nameController.text;
                  drones[index].model = modelController.text;
                });
                Navigator.pop(context);
              },
              child: Text('Sauvegarder'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Annuler'),
            ),
          ],
        );
      },
    );
  }

  void _viewDroneDetails(Drone drone) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Détails du Drone',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Nom : ${drone.name}'),
              Text('Modèle : ${drone.model}'),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Liste des Drones')),
      body: ReorderableListView.builder(
        itemCount: drones.length,
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) newIndex--;
            final Drone drone = drones.removeAt(oldIndex);
            drones.insert(newIndex, drone);
          });
        },
        itemBuilder: (context, index) {
          return Container(
            key: ValueKey(drones[index]), // Nécessaire pour ReorderableListView
            color: index % 2 == 0
                ? Colors.grey.shade200
                : Colors.transparent, // Fond gris pour un sur deux
            child: ListTile(
              leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _editDrone(index),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteDrone(index),
                  ),
                ],
              ),
              title: GestureDetector(
                onTap: () => _viewDroneDetails(drones[index]),
                child: Text(drones[index].name),
              ),
              subtitle: Text(drones[index].model),
              trailing: Icon(Icons.drag_handle, color: Colors.grey),
            ),
          );
        },
      ),
    );
  }
}*/
