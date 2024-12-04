import 'package:flutter/material.dart';
import 'package:projects/pages/VolPage.dart';
import 'package:projects/pages/NotamPage.dart';

import '../pages/DronePage.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key});

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  int _selectedIndex = 0;

  late List<Widget> customBody;

  @override
  void initState() {
    super.initState();

    customBody = [
      VolPage(title: 'Vol Page'),
      DronePage(title: 'Drone Page'),
      NotamPage(url: 'https://sofia-briefing.aviation-civile.gouv.fr/sofia/pages/notamadminmenu.html',title: 'Sofia-Briefing Notam')
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: customBody[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.flight_outlined), // Icon pour l'avion
            label: 'Vol',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.discord_rounded),
            label: 'Drones',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notification_important),
            label: 'Notam',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        selectedFontSize: 12,
        unselectedFontSize: 12,
      ),
    );
  }
}