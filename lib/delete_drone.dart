import 'package:crud_with_isar/drone.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

class DeleteDrone extends StatefulWidget {
  List<Drone?> droneList;
  final Isar isar;

  DeleteDrone({super.key, required this.droneList, required this.isar});

  @override
  State<DeleteDrone> createState() => _DeleteDroneState();
}

class _DeleteDroneState extends State<DeleteDrone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delete a drone"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            if (widget.droneList.isNotEmpty) {
              await widget.isar.writeTxn(() async {
                await widget.isar.drones.delete(widget.droneList[0]!.id);
              });

              setState(() {
                widget.droneList = [];
              });
            }
          },
          child: const Text("Drohne löschen"),
        ),
      ),
    );
  }
}
