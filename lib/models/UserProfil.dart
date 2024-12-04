import 'Drone.dart';
import 'Vol.dart';

class UserProfil {
  final int id;
  final String name;
  final List<Drone> drones;
  final List<Vol> vols;

  UserProfil({required this.id, required this.name, required this.drones, required this.vols});
}