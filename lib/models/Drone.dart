import 'CheckList.dart';

class Drone {
  int id;
  String name;
  String model;
  String? description;
  String? status;
  String? battery;

  CheckList checkList;

  Drone({
    required this.id,
    required this.name,
    required this.model,
    this.description,
    this.status,
    this.battery,
    required this.checkList,
  });

}
