import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/UserProvider.dart';
import '../providers/TimerProvider.dart';
import '../providers/CheckListProvider.dart';
import '../models/Drone.dart';

class VolPage extends StatefulWidget {
  final String title;

  const VolPage({super.key, required this.title});

  @override
  State<VolPage> createState() => _VolPageState();
}

class _VolPageState extends State<VolPage> {
  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final checkListProvider = Provider.of<CheckListProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nombre de secondes écoulées: ${timerProvider.counter}'),
            if (timerProvider.isTimerRunning)
              ElevatedButton(
                onPressed: timerProvider.stopTimer,
                child: Text('Arrêter le timer'),
              )
            else
              ElevatedButton(
                onPressed: () async {
                  final selectedDrone = await _selectDrone(context, userProvider);
                  if (selectedDrone != null) {
                    checkListProvider.setCheckList(selectedDrone.checkList); // Mettre à jour la checklist globale
                    timerProvider.startTimer();
                  }
                },
                child: Text('Démarrer le timer'),
              ),
          ],
        ),
      ),
    );
  }

  Future<Drone?> _selectDrone(BuildContext context, UserProvider userProvider) async {
    return showDialog<Drone>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sélectionner un Drone'),
          content: SingleChildScrollView(
            child: Column(
              children: userProvider.getDrones().map((drone) {
                return ListTile(
                  title: Text(drone.name),
                  onTap: () {
                    Navigator.of(context).pop(drone);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}