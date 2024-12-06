import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import '../models/CheckList.dart';
import '../models/Drone.dart';
import '../providers/UserProvider.dart';
import 'DroneCreatePage.dart';

class DronePage extends StatefulWidget {
  final String title;

  const DronePage({super.key, required this.title});

  @override
  _DronePageState createState() => _DronePageState();
}

class _DronePageState extends State<DronePage> {


  Future<void> _dialogBuilder(BuildContext context, Drone drone) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            drone.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min, // Ajuste la taille au contenu
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Model: ${drone.model}"),
              if (drone.description != null)
                Text("Description: ${drone.description!}"),
              if (drone.status != null) Text("Status: ${drone.status!}"),
              if (drone.battery != null) Text("Battery: ${drone.battery!}"),
              Text("Checklist: ${drone.checkList.title}"),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {

    UserProvider userProvider = Provider.of<UserProvider>(context);
    final Color oddItemColor = Colors.lightBlue.shade50;
    final Color evenItemColor = Colors.lightBlue.shade50;

    final List<Card> cards = [
      for (int index = 0; index < userProvider.getDrones().length; index++)
        Card(
          key: Key('$index'),
          color: userProvider.getDrones()[index].id.isOdd ? oddItemColor : evenItemColor,
          child: InkWell(
            onTap: () {
              _dialogBuilder(context, userProvider.getDrones()[index]);
            },
            child: SizedBox(
              height: 90,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/drone_process_logo.jpg'),
                      backgroundColor: Colors.grey[300],
                      radius: 25,
                    ),
                  ),
                  // Nom du drone
                  Expanded(
                    flex: 2,
                    child: Text(
                      userProvider.getDrones()[index].name,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // Bouton d'update
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) {
                              return DroneCreatePage(drone: userProvider.getDrones()[index]);
                            },
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              var begin = Offset(1.0, 0.0);
                              var end = Offset.zero;
                              var curve = Curves.easeInOut;

                              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                              var offsetAnimation = animation.drive(tween);

                              return SlideTransition(position: offsetAnimation, child: child);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  // Bouton de suppression
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        userProvider.removeDrone(userProvider.getDrones()[index]);
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child:
                      ReorderableDragStartListener(
                        index: index,
                        child: Icon(Icons.drag_handle, color: Colors.grey),
                      ),
                  )
                ],
              ),
            ),
          ),
        )
    ];

    Widget proxyDecorator(
        Widget child, int index, Animation<double> animation) {
      return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          final double animValue = Curves.easeInOut.transform(animation.value);
          final double elevation = lerpDouble(1, 6, animValue)!;
          final double scale = lerpDouble(1, 1.02, animValue)!;
          return Transform.scale(
            scale: scale,
            child: Card(
              elevation: elevation,
              color: cards[index].color,
              child: cards[index].child,
            ),
          );
        },
        child: child,
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ReorderableListView(
        buildDefaultDragHandles: false,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        proxyDecorator: proxyDecorator,
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final Drone drone = userProvider.getDrones().removeAt(oldIndex);
            userProvider.getDrones().insert(newIndex, drone);
          });
        },
        children: cards,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return DroneCreatePage(); // Remplacez par la page à ouvrir
              },
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                var begin = Offset(1.0, 0.0);
                var end = Offset.zero;
                var curve = Curves.easeInOut;

                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);

                return SlideTransition(position: offsetAnimation, child: child);
              },
            ),
          );
        },
        tooltip: 'Ajouter un drone',
        child: const Icon(Icons.add),
      ),
    );
  }
}
