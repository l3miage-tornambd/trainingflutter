import 'package:flutter/material.dart';
import '../models/CheckList.dart';
import '../models/Drone.dart';
import '../models/UserProfil.dart';
import '../models/Vol.dart';

class UserProvider extends ChangeNotifier {
  UserProfil _user = UserProfil(
    id: 1,
    name: 'John Doe',
    drones: [
      Drone(
        id: 1,
        name: 'Drone 1',
        model: 'Model 1',
        description: 'Description 1',
        status: 'Status 1',
        battery: 'Battery 1',
        checkList: CheckList(
          id: 1,
          title: 'My Checklist 1',
          categories: [
            Category(
              name: 'Category A',
              backgroundColor: Colors.white38,
              items: [
                Item(id: 101, description: 'Item 1'),
                Item(id: 102, description: 'Item 2'),
              ],
            ),
            Category(
              name: 'Category B',
              backgroundColor: Colors.white30,
              items: [
                Item(id: 201, description: 'Item 3'),
                Item(id: 202, description: 'Item 4'),
              ],
            ),
            Category(
              name: 'Category C',
              backgroundColor: Colors.white24,
              items: [
                Item(id: 301, description: 'Item 5'),
                Item(id: 302, description: 'Item 6'),
              ],
            ),
          ],
        ),
      ),
      Drone(
        id: 2,
        name: 'Drone 2',
        model: 'Model 2',
        description: 'Description 2',
        status: 'Status 2',
        battery: 'Battery 2',
        checkList: CheckList(
          id: 2,
          title: 'My Checklist 2',
          categories: [
            Category(
              name: 'Category A',
              backgroundColor: Colors.white38,
              items: [
                Item(id: 101, description: 'Item 1'),
                Item(id: 102, description: 'Item 2'),
              ],
            ),
            Category(
              name: 'Category B',
              backgroundColor: Colors.white30,
              items: [
                Item(id: 201, description: 'Item 3'),
                Item(id: 202, description: 'Item 4'),
              ],
            ),
            Category(
              name: 'Category C',
              backgroundColor: Colors.white24,
              items: [
                Item(id: 301, description: 'Item 5'),
                Item(id: 302, description: 'Item 6'),
              ],
            ),
          ],
        ),
      ),
    ],
    vols: [],
  );

  UserProfil getUser() => _user;

  List<Drone> getDrones() => _user.drones;


  void addVol(Vol vol) {
    _user.vols.add(vol);
    notifyListeners();
  }

  void removeVol(Vol vol) {
    _user.vols.remove(vol);
    notifyListeners();
  }

  void addDrone(Drone drone) {
    _user.drones.add(drone);
    notifyListeners();
  }

  void removeDrone(Drone drone) {
    _user.drones.remove(drone);
    notifyListeners();
  }

  void updateDrone(Drone drone) {
    final index = _user.drones.indexWhere((element) => element.id == drone.id);
    _user.drones[index] = drone;
    notifyListeners();
  }




}
