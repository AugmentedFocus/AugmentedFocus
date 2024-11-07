import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector64;

class ArActivity1 extends StatefulWidget {
  const ArActivity1({super.key});

  @override
  State<ArActivity1> createState() => _ArActivity1State();
}

class _ArActivity1State extends State<ArActivity1>{
  ArCoreController? coreController;

  augmentedRealityViewCreated(ArCoreController controller) {
    coreController = controller;

    displayCube(coreController!);
  }

  displayCube(ArCoreController controller){
    final materials = ArCoreMaterial(
      color: Colors.blue,
      metallic: 2,
    );

    final cube = ArCoreCube(
      size: vector64.Vector3(0.5, 0.5, 0.5),
      materials: [materials],
    );

    final node = ArCoreNode(
      shape: cube,
      position: vector64.Vector3(-0.5, 0.5, -3.0)
    );

    coreController!.addArCoreNode(node);
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: ArCoreView(
          onArCoreViewCreated: augmentedRealityViewCreated,
      ),
    );
  }
}

/*
class _ArActivity1State extends State<ArActivity1> {
  ArCoreController? arCoreController;

  @override
  void dispose() {
    arCoreController?.dispose();
    super.dispose();
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;

    _add3DSphere();
  }

  void _add3DSphere() {
    final material = ArCoreMaterial(color: Colors.blueAccent);
    final sphere = ArCoreSphere(materials: [material], radius: 0.1);
    final node = ArCoreNode(
      shape: sphere,
      position: vector64.Vector3(0, 0, -1),
    );

    arCoreController?.addArCoreNode(node);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clase de Lenguaje - AR"),
      ),
      body: Stack(
        children: [
          ArCoreView(
            onArCoreViewCreated: _onArCoreViewCreated,
            enableTapRecognizer: true,
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.white.withOpacity(0.8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    "Hello - Hola",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Esta es una actividad de realidad aumentada donde 'Hello' está representado como un objeto azul en el espacio AR.",
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

 */