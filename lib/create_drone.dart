import 'package:crud_with_isar/drone.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

class CreateDrone extends StatefulWidget {
  List<Drone?> droneList;
  final Isar isar;
  CreateDrone({Key? key, required this.droneList, required this.isar})
      : super(key: key);

  @override
  State<CreateDrone> createState() => _CreateDroneState();
}

class _CreateDroneState extends State<CreateDrone> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController velocityController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController resolutionController = TextEditingController();
  TextEditingController imgUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create a drone")),
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: priceController,
            decoration: const InputDecoration(labelText: 'Price'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          TextField(
            controller: colorController,
            decoration: const InputDecoration(labelText: 'Color'),
          ),
          TextField(
            controller: velocityController,
            decoration: const InputDecoration(labelText: 'Velocity'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: durationController,
            decoration: const InputDecoration(labelText: 'Flight Duration'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: resolutionController,
            decoration: const InputDecoration(labelText: 'Camera Resolution'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: imgUrlController,
            decoration: const InputDecoration(labelText: 'Image URL'),
          ),
          ElevatedButton(
            onPressed: () async {
              final newDrone = Drone(
                name: nameController.text,
                price: double.tryParse(priceController.text) ?? 0.0,
                color: colorController.text,
                velocity: int.tryParse(velocityController.text) ?? 0,
                flightDuration: int.tryParse(durationController.text) ?? 0,
                camResolution: int.tryParse(resolutionController.text) ?? 0,
                imgUrl: imgUrlController.text,
              );

              await widget.isar.writeTxn(() async {
                await widget.isar.drones.put(newDrone);
              });
              //So Fehler sollte alle gefixt sein
              setState(() {
                widget.droneList = [newDrone];
                nameController.clear();
                priceController.clear();
                colorController.clear();
                velocityController.clear();
                durationController.clear();
                resolutionController.clear();
                imgUrlController.clear();
              });
            },
            child: const Text("Drohne anlegen"),
          ),
        ],
      ),
    );
  }
}
