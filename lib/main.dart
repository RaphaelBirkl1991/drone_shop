import 'package:crud_with_isar/drone.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [DroneSchema],
    directory: dir.path,
  );
  runApp(MainApp(isar: isar));
}

class MainApp extends StatefulWidget {
  final Isar isar;
  const MainApp({super.key, required this.isar});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  List<Drone?> droneList = [];
  List<Drone?> currentList = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  final raptor = Drone(
                      id: 1,
                      name: "raptor",
                      price: 100.00,
                      color: "black",
                      velocity: 87,
                      flightDuration: 45,
                      camResolution: 10,
                      imgUrl: "undefined");

                  await widget.isar.writeTxn(() async {
                    await widget.isar.drones.put(raptor);
                  });
                  setState(() {
                    droneList = [raptor];
                  });
                },
                child: const Text("Drohne anlegen")),
            ElevatedButton(
                onPressed: () async {
                  var currentDrone = await widget.isar.drones.get(1);
                  setState(() {
                    droneList = [currentDrone];
                  });
                },
                child: const Text("Drohne(n) anzeigen")),
            ElevatedButton(
              onPressed: () async {
                if (droneList.isNotEmpty) {
                  await widget.isar.writeTxn(() async {
                    await widget.isar.drones.delete(droneList[0]!.id);
                  });

                  setState(() {
                    droneList = [];
                  });
                }
              },
              child: const Text("Drohne löschen"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: droneList.length,
                itemBuilder: (context, index) {
                  final drone = droneList[index];
                  return ListTile(
                    title: Text(drone!.name),
                    subtitle: Text("Price: ${drone.price}"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
