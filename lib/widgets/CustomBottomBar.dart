import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projects/pages/VolPage.dart';
import 'package:projects/pages/NotamPage.dart';
import '../pages/DronePage.dart';
import '../providers/CheckListProvider.dart';

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
      NotamPage(
        url: 'https://sofia-briefing.aviation-civile.gouv.fr/sofia/pages/notamadminmenu.html',
        title: 'Sofia-Briefing Notam',
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final checkListProvider = Provider.of<CheckListProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          customBody[_selectedIndex], // Page actuellement sélectionnée
          // Widget de checklist global
          if (checkListProvider.currentCheckList != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  checkListProvider.toggleExpanded();
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: checkListProvider.isExpanded
                      ? MediaQuery.of(context).size.height
                      : 60,
                  color: Colors.blueAccent,
                  child: checkListProvider.isExpanded
                      ? Padding(
                    padding: const EdgeInsets.only(
                        top: 70, left: 30, right: 30),
                    child: ListView(
                      children: checkListProvider
                          .currentCheckList!.categories
                          .map((category) {
                        return Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              category.name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: category.backgroundColor,
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics:
                              NeverScrollableScrollPhysics(),
                              itemCount: category.items.length,
                              itemBuilder: (context, itemIndex) {
                                final item = category
                                    .items[itemIndex];

                                return ListTile(
                                  title: Text(item.description),
                                  trailing: Checkbox(
                                    value: item.isDone,
                                    onChanged: (value) {
                                      item.isDone = value!;
                                      checkListProvider
                                          .notifyListeners();
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  )
                      : Center(
                    child: Text(
                      checkListProvider.currentCheckList!.title,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
        ],
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