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
      body: ReorderableListView.builder(
        key: ValueKey(userProvider.getDrones()),
        itemCount: userProvider.getDrones().length,
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) newIndex--;
            final Drone drone = userProvider.getDrones().removeAt(oldIndex);
            userProvider.getDrones().insert(newIndex, drone);
          });
        },
        itemBuilder: (context, index) {
          final drone = userProvider.getDrones()[index];
          return Card(
            key: ValueKey(drone.id),
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: GestureDetector(
              onTap: () {
                // Afficher la modale avec les informations du drone
                _showDroneDetails(context, drone);
              },
              child: ListTile(
                title: Text(drone.name),
                subtitle: Text(drone.model),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => userProvider.updateDrone(drone),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => userProvider.removeDrone(drone),
                    ),
                    ReorderableDragStartListener(
                      index: index,
                      child: Icon(Icons.drag_handle, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          userProvider.addDrone(userProvider.getUser());
        },
        tooltip: 'Ajouter un drone',
        child: const Icon(Icons.add),
      ),
    );
  }

  // Fonction pour afficher les détails du drone dans une modale
  void _showDroneDetails(BuildContext context, Drone drone) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(drone.name),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text("Model: ${drone.model}"),
                if (drone.description != null) Text("Description: ${drone.description!}"),
                if (drone.status != null) Text("Status: ${drone.status!}"),
                if (drone.battery != null) Text("Battery: ${drone.battery!}"),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fermer la modale
              },
              child: Text('Fermer'),
            ),
          ],
        );
      },
    );
  }
}