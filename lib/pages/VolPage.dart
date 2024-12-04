import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/TimerProvider.dart';

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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
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
                  child: Text('Arrêter le timer'))
            else
              ElevatedButton(
                  onPressed: timerProvider.startTimer,
                  child: Text('Démarrer le timer'))
          ]
        ),
      ),
    );
  }
}
