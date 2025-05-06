import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector64;
import 'dart:math' as math;

class ClaseSistemaSolarAR extends StatefulWidget {
  const ClaseSistemaSolarAR({super.key});

  @override
  State<ClaseSistemaSolarAR> createState() => _ClaseSistemaSolarARState();
}

class _ClaseSistemaSolarARState extends State<ClaseSistemaSolarAR> with TickerProviderStateMixin {
  ArCoreController? coreController;
  int currentPlanetIndex = 0;
  bool modoProfesor = false;
  bool mostrarComparacion = false;
  bool mostrarOrbitas = false;
  Map<String, ArCoreNode> planetNodes = {};
  late AnimationController rotationController;
  String currentTopic = "general"; // general, tamaño, distancia, composicion

  // Lista con información educativa sobre los planetas
  final List<Map<String, dynamic>> planets = [
    {
      'name': 'Mercurio',
      'color': Colors.grey,
      'size': 0.1,
      'realSize': 0.38, // En relación con la Tierra = 1
      'position': vector64.Vector3(0.5, 0.5, -1.0),
      'orbitRadius': 0.4,
      'orbitSpeed': 0.08,
      'rotationSpeed': 0.02,
      'general': 'Mercurio es el planeta más pequeño y más cercano al Sol. Completa una órbita en solo 88 días terrestres.',
      'tamaño': 'Con un diámetro de 4,880 km, Mercurio es solo un poco más grande que la Luna de la Tierra.',
      'distancia': 'Distancia promedio al Sol: 58 millones de km (0.4 UA).',
      'composicion': 'Tiene un núcleo metálico grande y una fina corteza rocosa. Su superficie está llena de cráteres similares a la Luna.',
      'dato_curioso': '¡Un día en Mercurio dura 59 días terrestres, mientras que su año dura solo 88 días!'
    },
    {
      'name': 'Venus',
      'color': Colors.orange,
      'size': 0.15,
      'realSize': 0.95, // En relación con la Tierra = 1
      'position': vector64.Vector3(-0.5, 0.5, -1.5),
      'orbitRadius': 0.7,
      'orbitSpeed': 0.06,
      'rotationSpeed': 0.005,
      'general': 'Venus es el planeta más caliente y el segundo más cercano al Sol. A menudo llamado "el gemelo de la Tierra" por su tamaño similar.',
      'tamaño': 'Con un diámetro de 12,104 km, Venus es casi del mismo tamaño que la Tierra.',
      'distancia': 'Distancia promedio al Sol: 108 millones de km (0.7 UA).',
      'composicion': 'Tiene una espesa atmósfera de dióxido de carbono que atrapa el calor, creando un efecto invernadero extremo.',
      'dato_curioso': '¡Venus gira en sentido contrario a la mayoría de los planetas! Su día es más largo que su año.'
    },
    {
      'name': 'Tierra',
      'color': Colors.blue,
      'size': 0.2,
      'realSize': 1.0, // Referencia
      'position': vector64.Vector3(0.0, 0.5, -2.0),
      'orbitRadius': 1.0,
      'orbitSpeed': 0.05,
      'rotationSpeed': 0.01,
      'general': 'La Tierra es nuestro hogar, el único planeta conocido que alberga vida. Está protegida por un campo magnético que desvía la radiación solar dañina.',
      'tamaño': 'Diámetro de 12,742 km. Usamos la Tierra como referencia de tamaño para comparar otros planetas.',
      'distancia': 'Distancia promedio al Sol: 150 millones de km (1 UA, donde UA significa Unidad Astronómica).',
      'composicion': 'Tiene una corteza rocosa, un manto de roca fundida y un núcleo de hierro y níquel. El 71% de su superficie está cubierta de agua.',
      'dato_curioso': '¡La Tierra es el único planeta que no fue nombrado después de un dios romano o griego!'
    },
    {
      'name': 'Marte',
      'color': Colors.red,
      'size': 0.15,
      'realSize': 0.53, // En relación con la Tierra = 1
      'position': vector64.Vector3(0.5, 0.5, -2.5),
      'orbitRadius': 1.5,
      'orbitSpeed': 0.04,
      'rotationSpeed': 0.01,
      'general': 'Marte es conocido como el planeta rojo por el óxido de hierro (herrumbre) que cubre su superficie. Es uno de los planetas más estudiados.',
      'tamaño': 'Con un diámetro de 6,779 km, Marte es aproximadamente la mitad del tamaño de la Tierra.',
      'distancia': 'Distancia promedio al Sol: 228 millones de km (1.5 UA).',
      'composicion': 'Tiene una fina atmósfera de dióxido de carbono y una superficie rocosa con volcanes extintos, cañones y casquetes polares de hielo.',
      'dato_curioso': '¡Marte tiene el volcán más grande del sistema solar: el Monte Olimpo, que mide 22 km de altura!'
    },
    {
      'name': 'Júpiter',
      'color': Colors.brown,
      'size': 0.4,
      'realSize': 11.2, // En relación con la Tierra = 1
      'position': vector64.Vector3(-0.5, 0.5, -3.0),
      'orbitRadius': 5.0,
      'orbitSpeed': 0.02,
      'rotationSpeed': 0.02,
      'general': 'Júpiter es el planeta más grande del sistema solar. Es un gigante gaseoso con una característica "Gran Mancha Roja", una tormenta que ha durado siglos.',
      'tamaño': 'Con un diámetro de 139,820 km, Júpiter es 11 veces más grande que la Tierra.',
      'distancia': 'Distancia promedio al Sol: 778 millones de km (5.2 UA).',
      'composicion': 'Compuesto principalmente de hidrógeno y helio, sin una superficie sólida. Tiene al menos 79 lunas.',
      'dato_curioso': '¡Júpiter tiene el día más corto de todos los planetas, girando en solo 10 horas!'
    },
    {
      'name': 'Saturno',
      'color': Colors.amber,
      'size': 0.35,
      'realSize': 9.45, // En relación con la Tierra = 1
      'position': vector64.Vector3(0.5, 0.5, -3.5),
      'orbitRadius': 9.0,
      'orbitSpeed': 0.015,
      'rotationSpeed': 0.018,
      'general': 'Saturno es famoso por sus impresionantes anillos, compuestos principalmente de partículas de hielo y rocas. Es el segundo planeta más grande.',
      'tamaño': 'Con un diámetro de 116,460 km, Saturno es 9 veces más grande que la Tierra.',
      'distancia': 'Distancia promedio al Sol: 1,427 millones de km (9.5 UA).',
      'composicion': 'Similar a Júpiter, es un gigante gaseoso compuesto principalmente de hidrógeno y helio. Sus anillos se extienden hasta 282,000 km desde el planeta.',
      'dato_curioso': '¡Saturno es tan poco denso que flotaría en agua si existiera un océano lo suficientemente grande!'
    },
    {
      'name': 'Urano',
      'color': Colors.lightBlueAccent,
      'size': 0.25,
      'realSize': 4.0, // En relación con la Tierra = 1
      'position': vector64.Vector3(-0.5, 0.5, -4.0),
      'orbitRadius': 18.0,
      'orbitSpeed': 0.01,
      'rotationSpeed': 0.012,
      'general': 'Urano es único porque gira "de lado", con su eje de rotación inclinado a casi 90 grados. Es el primer planeta descubierto con telescopio.',
      'tamaño': 'Con un diámetro de 50,724 km, Urano es 4 veces más grande que la Tierra.',
      'distancia': 'Distancia promedio al Sol: 2,871 millones de km (19.2 UA).',
      'composicion': 'Es un gigante de hielo compuesto principalmente de agua, metano y amoníaco en forma de hielo. El metano en su atmósfera le da su color azul-verdoso.',
      'dato_curioso': '¡Urano tiene 27 lunas conocidas, todas nombradas por personajes de las obras de Shakespeare y Alexander Pope!'
    },
    {
      'name': 'Neptuno',
      'color': Colors.blueAccent,
      'size': 0.25,
      'realSize': 3.88, // En relación con la Tierra = 1
      'position': vector64.Vector3(0.0, 0.5, -4.5),
      'orbitRadius': 28.0,
      'orbitSpeed': 0.008,
      'rotationSpeed': 0.014,
      'general': 'Neptuno es el planeta más lejano del Sol. Fue predicho matemáticamente antes de ser observado debido a las perturbaciones en la órbita de Urano.',
      'tamaño': 'Con un diámetro de 49,244 km, Neptuno es casi 4 veces más grande que la Tierra.',
      'distancia': 'Distancia promedio al Sol: 4,498 millones de km (30.1 UA).',
      'composicion': 'Similar a Urano, es un gigante de hielo con una atmósfera de hidrógeno, helio y metano que le da su color azul intenso.',
      'dato_curioso': '¡Neptuno tiene los vientos más fuertes del sistema solar, alcanzando velocidades de 2,100 km/h!'
    },
  ];

  @override
  void initState() {
    super.initState();
    rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 80),
    )..repeat();
  }

  @override
  void dispose() {
    coreController?.dispose();
    rotationController.dispose();
    super.dispose();
  }

  void augmentedRealityViewCreated(ArCoreController controller) {
    coreController = controller;
    displayPlanets(coreController!);
    if (mostrarOrbitas) {
      displayOrbits(coreController!);
    }
  }

  void displayPlanets(ArCoreController controller) {
    // Primero limpiamos los nodos existentes
    planetNodes.forEach((key, value) {
      controller.removeNode(nodeName: key);
    });
    planetNodes.clear();

    // Ahora creamos los nuevos planetas
    for (var planet in planets) {
      // Material para el planeta
      final material = ArCoreMaterial(color: planet['color'] as Color);

      // Tamaño real o tamaño visual dependiendo del modo
      double size = mostrarComparacion ?
      (planet['realSize'] as double) * 0.05 : // Tamaño a escala
      planet['size'] as double; // Tamaño visual para mejor visualización

      // Creamos la esfera para el planeta
      final sphere = ArCoreSphere(
        materials: [material],
        radius: size,
      );

      // Creamos el nodo del planeta
      final planetNode = ArCoreNode(
        name: planet['name'],
        shape: sphere,
        position: planet['position'] as vector64.Vector3,
      );

      // Añadimos el nodo a la escena y guardamos referencia
      controller.addArCoreNode(planetNode);
      planetNodes[planet['name']] = planetNode;

      // Si es el planeta actual, añadimos indicador
      if (planets[currentPlanetIndex]['name'] == planet['name']) {
        _addIndicatorToCurrentPlanet(controller, planet);
      }
    }

    // Añadimos el Sol como referencia
    final sunMaterial = ArCoreMaterial(color: Colors.yellow);
    final sunSphere = ArCoreSphere(
      materials: [sunMaterial],
      radius: 0.5,
    );
    final sunNode = ArCoreNode(
      name: 'Sol',
      shape: sunSphere,
      position: vector64.Vector3(0.0, 0.5, -0.5),
    );
    controller.addArCoreNode(sunNode);
    planetNodes['Sol'] = sunNode;
  }

  void displayOrbits(ArCoreController controller) {
    // Para cada planeta, dibujamos su órbita como una serie de puntos
    for (var planet in planets) {
      double orbitRadius = (planet['orbitRadius'] as double) * 0.3; // Escalar para visualización

      // Dibujamos 20 puntos para formar una órbita
      for (int i = 0; i < 60; i++) {
        double angle = i * (2 * math.pi / 60);
        double x = orbitRadius * math.cos(angle);
        double z = -0.5 - orbitRadius * math.sin(angle);

        final orbitPointMaterial = ArCoreMaterial(color: Colors.white.withOpacity(0.5));
        final orbitPoint = ArCoreSphere(
          materials: [orbitPointMaterial],
          radius: 0.01,
        );

        final orbitNode = ArCoreNode(
          name: '${planet['name']}_orbit_$i',
          shape: orbitPoint,
          position: vector64.Vector3(x, 0.5, z),
        );

        controller.addArCoreNode(orbitNode);
      }
    }
  }

  void _addIndicatorToCurrentPlanet(ArCoreController controller, Map<String, dynamic> planet) {
    // Flecha o indicador encima del planeta seleccionado
    final indicatorMaterial = ArCoreMaterial(color: Colors.white);
    final indicator = ArCoreCylinder(
      materials: [indicatorMaterial],
      radius: 0.02,
      height: 0.1,
    );

    // Posición justo encima del planeta
    vector64.Vector3 planetPos = planet['position'] as vector64.Vector3;
    vector64.Vector3 indicatorPos = vector64.Vector3(
        planetPos.x,
        planetPos.y + 0.3,
        planetPos.z
    );

    final indicatorNode = ArCoreNode(
      name: 'currentPlanetIndicator',
      shape: indicator,
      position: indicatorPos,
    );

    controller.addArCoreNode(indicatorNode);
  }

  void nextPlanet() {
    setState(() {
      currentPlanetIndex = (currentPlanetIndex + 1) % planets.length;
      _updateScene();
    });
  }

  void previousPlanet() {
    setState(() {
      currentPlanetIndex = (currentPlanetIndex - 1 + planets.length) % planets.length;
      _updateScene();
    });
  }

  void toggleModoProfesor() {
    setState(() {
      modoProfesor = !modoProfesor;
    });
  }

  void toggleComparacionTamanos() {
    setState(() {
      mostrarComparacion = !mostrarComparacion;
      if (coreController != null) {
        displayPlanets(coreController!);
      }
    });
  }

  void toggleOrbitas() {
    setState(() {
      mostrarOrbitas = !mostrarOrbitas;
      if (coreController != null) {
        if (mostrarOrbitas) {
          displayOrbits(coreController!);
        } else {
          // Eliminar órbitas
          for (var planet in planets) {
            for (int i = 0; i < 20; i++) {
              coreController!.removeNode(nodeName: '${planet['name']}_orbit_$i');
            }
          }
        }
      }
    });
  }

  void changeTopic(String topic) {
    setState(() {
      currentTopic = topic;
    });
  }

  void _updateScene() {
    if (coreController != null) {
      // Actualizar indicador del planeta actual
      coreController!.removeNode(nodeName: 'currentPlanetIndicator');
      _addIndicatorToCurrentPlanet(coreController!, planets[currentPlanetIndex]);
    }
  }

  String _getCurrentPlanetInfo() {
    var planet = planets[currentPlanetIndex];

    switch (currentTopic) {
      case 'tamaño':
        return planet['tamaño'];
      case 'distancia':
        return planet['distancia'];
      case 'composicion':
        return planet['composicion'];
      case 'general':
      default:
        return planet['general'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clase del Sistema Solar en AR"),
        actions: [
          IconButton(
            icon: Icon(modoProfesor ? Icons.school : Icons.person),
            onPressed: toggleModoProfesor,
            tooltip: modoProfesor ? "Modo Profesor (activo)" : "Modo Estudiante",
          ),
        ],
      ),
      body: Stack(
        children: [
          // Vista AR
          ArCoreView(
            onArCoreViewCreated: augmentedRealityViewCreated,
          ),

          // Panel de información del planeta
          Positioned(
            bottom: 100,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white30, width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Título del planeta con su color característico
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: planets[currentPlanetIndex]['color'] as Color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        planets[currentPlanetIndex]['name'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Pestañas de información
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _infoTab('General', 'general'),
                      _infoTab('Tamaño', 'tamaño'),
                      _infoTab('Distancia', 'distancia'),
                      _infoTab('Composición', 'composicion'),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Descripción según la pestaña seleccionada
                  Text(
                    _getCurrentPlanetInfo(),
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),

                  // Dato curioso solo en modo profesor
                  if (modoProfesor) ...[
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.lightbulb, color: Colors.yellow, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "Dato para el profesor: ${planets[currentPlanetIndex]['dato_curioso']}",
                              style: const TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    heroTag: "btnPrevio",
                    onPressed: previousPlanet,
                    backgroundColor: Colors.blueGrey,
                    child: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 20),
                  FloatingActionButton(
                    heroTag: "btnComparar",
                    onPressed: toggleComparacionTamanos,
                    backgroundColor: mostrarComparacion ? Colors.green : Colors.blueGrey,
                    child: const Icon(Icons.compare_arrows),
                    tooltip: "Comparar tamaños reales",
                  ),
                  const SizedBox(width: 20),
                  FloatingActionButton(
                    heroTag: "btnOrbitas",
                    onPressed: toggleOrbitas,
                    backgroundColor: mostrarOrbitas ? Colors.green : Colors.blueGrey,
                    child: const Icon(Icons.track_changes),
                    tooltip: "Mostrar órbitas",
                  ),
                  const SizedBox(width: 20),
                  FloatingActionButton(
                    heroTag: "btnSiguiente",
                    onPressed: nextPlanet,
                    backgroundColor: Colors.blueGrey,
                    child: const Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoTab(String label, String topic) {
    bool isSelected = currentTopic == topic;
    return GestureDetector(
      onTap: () => changeTopic(topic),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white30),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white70,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}