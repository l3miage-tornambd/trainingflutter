import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:projects/pages/CheckListItemPage.dart';
import 'package:provider/provider.dart';
import '../models/CheckList.dart';
import '../models/Drone.dart';
import '../providers/UserProvider.dart';

class DroneCreatePage extends StatefulWidget {

  final Drone? drone;

  DroneCreatePage({super.key, this.drone});

  @override
  _DroneCreatePageState createState() => _DroneCreatePageState();
}

class _DroneCreatePageState extends State<DroneCreatePage> {
  late final TextEditingController _nameController = TextEditingController();
  late final TextEditingController _modelController = TextEditingController();
  late final TextEditingController _descriptionController = TextEditingController();
  late final TextEditingController _statusController = TextEditingController();
  late final TextEditingController _batteryController = TextEditingController();

  bool isSwitched = false;
  CheckList? importedCheckList;
  bool isACreation = true;

  @override
  void initState() {
    super.initState();

    // Si un drone est passé en paramètre, c'est qu'on est sur une update
    if (widget.drone != null) {
      isACreation = false;
      _nameController.text = widget.drone!.name;
      _modelController.text = widget.drone!.model;
      _descriptionController.text = widget.drone!.description ?? '';
      _statusController.text = widget.drone!.status ?? '';
      _batteryController.text = widget.drone!.battery ?? '';
    }
  }

  Future<void> _pickFile() async {

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      String fileContent = await file.readAsString();
      Map<String, dynamic> jsonMap = json.decode(fileContent);

      CheckList checklist = CheckList.fromJson(jsonMap);
      setState(() {
        importedCheckList = checklist;
      });
    }
  }

  Future<void> _exportFile(CheckList checklist) async {
    // Convertir l'objet CheckList en JSON
    String jsonContent = json.encode(checklist.toJson());
    print(jsonContent);

    // Obtenir un chemin pour sauvegarder le fichier
    String? outputPath = await FilePicker.platform.saveFile(
      dialogTitle: 'Sauvegarder le fichier',
      fileName: 'checklist.json',
    );

    if (outputPath != null) {
      try {
        File file = File(outputPath);
        await file.writeAsString(jsonContent);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fichier exporté avec succès : $outputPath')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de l\'exportation : $e')),
        );
      }
    }
  }



  void handleMenuClick(int item) {
    switch (item) {
      case 1:
        // Modifier la checklist
        break;
      case 2:
        // Importer la checklist
        _pickFile();
        break;
      case 3:
        _exportFile(widget.drone!.checkList);
        // Exporter la checklist
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.drone == null ? 'Create Drone' : 'Update Drone'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _modelController,
              decoration: InputDecoration(labelText: 'Model'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _statusController,
              decoration: InputDecoration(labelText: 'Status'),
            ),
            TextField(
              controller: _batteryController,
              decoration: InputDecoration(labelText: 'Battery'),
            ),
            if (isACreation)
              Center(
                heightFactor: 3.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                        });
                      },
                    ),
                    SizedBox(width: 8),
                    Text(
                      isSwitched ? 'Import checklist' : 'Checklist par défaut',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              )
            else
              Center(
                heightFactor: 3.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                        child: Container (
                          padding: EdgeInsets.only(right: 10.0),
                          child: Text('${widget.drone?.checkList.title}'),
                        )
                    ),
                    PopupMenuButton<int>(
                      onSelected: (item) => handleMenuClick(item),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 1,
                          child: Text('Modifier la checklist'),
                          onTap: () {
                            // Modifier la checklist
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) {
                                  CheckList checkListTmp = widget.drone!.checkList;
                                  Drone droneTmp = widget.drone!;
                                  return CheckListItemPage(checkList: checkListTmp, drone: droneTmp); // Remplacez par la page à ouvrir
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
                        PopupMenuItem(
                          value: 2,
                          child: Text('Importer la checklist'),
                          onTap: () {
                            // Importer la checklist
                            _pickFile();
                          },
                        ),
                        PopupMenuItem(
                          value: 3,
                          child: Text('Exporter la checklist'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            if (isSwitched)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue.shade50,
                ),
                onPressed: _pickFile,
                child: Text('Importer une checklist'),
              ),
            if (!isSwitched && importedCheckList != null && isACreation)
              Text("Checklist importée : ${importedCheckList?.title ?? ''}"),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue.shade50,
              ),
              onPressed: () {
                final newDrone = Drone(
                  id: userProvider.getDrones().length + 1,
                  name: _nameController.text,
                  model: _modelController.text,
                  description: _descriptionController.text,
                  status: _statusController.text,
                  battery: _batteryController.text,
                  checkList: isSwitched && importedCheckList != null
                      ? importedCheckList!
                      : CheckList(
                    id: userProvider.getDrones().length + 1,
                    title: 'Checklist par défaut',
                    categories: [],
                  ),
                );
                if (widget.drone == null) {
                  userProvider.addDrone(newDrone);
                } else {
                  widget.drone!.name = _nameController.text;
                  widget.drone!.model = _modelController.text;
                  widget.drone!.description = _descriptionController.text;
                  widget.drone!.status = _statusController.text;
                  widget.drone!.battery = _batteryController.text;
                  widget.drone!.checkList = newDrone.checkList;

                  userProvider.updateDrone(widget.drone!);
                }
                Navigator.of(context).pop();
              },
              child: Text(widget.drone == null ? 'Create' : 'Update'),
            ),
          ],
        ),
      ),
    );
  }
}