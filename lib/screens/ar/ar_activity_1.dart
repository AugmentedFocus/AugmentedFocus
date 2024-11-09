import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector64;

class ArActivity1 extends StatefulWidget {
  const ArActivity1({super.key});

  @override
  State<ArActivity1> createState() => _ArActivity1State();
}

class _ArActivity1State extends State<ArActivity1> {
  ArCoreController? coreController;
  int currentPlanetIndex = 0;
  final List<Map<String, dynamic>> planets = [
    {'name': 'Mercurio', 'color': Colors.grey, 'size': 0.1, 'position': vector64.Vector3(0.5, 0.5, -1.0), 'description': 'Mercurio: El planeta más cercano al Sol. "Cercano" es un adjetivo para describir algo que está cerca.'},
    {'name': 'Venus', 'color': Colors.orange, 'size': 0.15, 'position': vector64.Vector3(-0.5, 0.5, -1.5), 'description': 'Venus: Un planeta brillante y caluroso. "Brillante" significa que emite mucha luz.'},
    {'name': 'Tierra', 'color': Colors.blue, 'size': 0.2, 'position': vector64.Vector3(0.0, 0.5, -2.0), 'description': 'Tierra: Nuestro hogar, donde vivimos. "Hogar" es donde uno vive.'},
    {'name': 'Marte', 'color': Colors.red, 'size': 0.15, 'position': vector64.Vector3(0.5, 0.5, -2.5), 'description': 'Marte: El planeta rojo. "Rojo" es un color que simboliza calor y fuerza.'},
    {'name': 'Júpiter', 'color': Colors.brown, 'size': 0.4, 'position': vector64.Vector3(-0.5, 0.5, -3.0), 'description': 'Júpiter: El planeta más grande. "Grande" describe algo de tamaño inmenso.'},
    {'name': 'Saturno', 'color': Colors.amber, 'size': 0.35, 'position': vector64.Vector3(0.5, 0.5, -3.5), 'description': 'Saturno: Famoso por sus anillos. "Famoso" se usa para algo que es bien conocido.'},
    {'name': 'Urano', 'color': Colors.lightBlueAccent, 'size': 0.25, 'position': vector64.Vector3(-0.5, 0.5, -4.0), 'description': 'Urano: Con un eje inclinado. "Inclinado" describe algo en una posición diagonal.'},
    {'name': 'Neptuno', 'color': Colors.blueAccent, 'size': 0.25, 'position': vector64.Vector3(0.0, 0.5, -4.5), 'description': 'Neptuno: El planeta más lejano. "Lejano" significa que está muy lejos.'},
  ];

  @override
  void dispose() {
    coreController?.dispose();
    super.dispose();
  }

  void augmentedRealityViewCreated(ArCoreController controller) {
    coreController = controller;
    displayPlanets(coreController!);
  }

  void displayPlanets(ArCoreController controller) {
    for (var planet in planets) {
      final material = ArCoreMaterial(color: planet['color'] as Color);
      final sphere = ArCoreSphere(
        materials: [material],
        radius: planet['size'] as double,
      );

      final node = ArCoreNode(
        shape: sphere,
        position: planet['position'] as vector64.Vector3,
      );

      controller.addArCoreNode(node);
    }
  }

  void updateDescription() {
    setState(() {
      currentPlanetIndex = (currentPlanetIndex + 1) % planets.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sistema Solar en AR"),
      ),
      body: Stack(
        children: [
          ArCoreView(
            onArCoreViewCreated: augmentedRealityViewCreated,
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: GestureDetector(
              onTap: updateDescription,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  planets[currentPlanetIndex]['description'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
