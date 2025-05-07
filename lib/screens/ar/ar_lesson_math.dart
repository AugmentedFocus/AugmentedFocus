import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector64;
import 'dart:math' as math;

class MathematicsAR extends StatefulWidget {
  const MathematicsAR({super.key});

  @override
  State<MathematicsAR> createState() => _MathematicsARState();
}

class _MathematicsARState extends State<MathematicsAR> with TickerProviderStateMixin {
  ArCoreController? coreController;
  int currentShapeIndex = 0;
  bool modoProfesor = false;
  bool mostrarFormulas = false;
  bool mostrarEjes = false;
  Map<String, ArCoreNode> shapeNodes = {};
  late AnimationController rotationController;
  String currentTopic = "general"; // general, volumen, area, propiedades
  double currentScale = 1.0;
  int currentProblemIndex = 0;
  bool showingSolution = false;

  // Lista con información de formas geométricas
  final List<Map<String, dynamic>> shapes = [
    {
      'name': 'Cubo',
      'color': Colors.blue,
      'size': 0.2,
      'position': vector64.Vector3(0.0, 0.5, -1.0),
      'shape': 'cube',
      'general': 'El cubo es un sólido con 6 caras cuadradas iguales, 12 aristas y 8 vértices.',
      'volumen': 'Volumen = a³, donde a es la longitud de un lado. Si a = 5, entonces V = 5³ = 125 unidades cúbicas.',
      'area': 'Área superficial = 6a², donde a es la longitud de un lado. Si a = 5, entonces A = 6 × 5² = 150 unidades cuadradas.',
      'propiedades': 'Todas las caras son perpendiculares a las caras adyacentes. Las diagonales internas tienen la misma longitud y se cruzan en el punto medio.',
      'dato_curioso': 'El cubo es el único hexaedro regular (poliedro de 6 caras) y es uno de los 5 sólidos platónicos.',
      'problema': '¿Cuál es la longitud de la diagonal interna de un cubo de lado 4 cm?',
      'solución': 'La diagonal interna mide d = a√3 = 4√3 ≈ 6.93 cm',
      'formula': 'd = a√3'
    },
    {
      'name': 'Esfera',
      'color': Colors.red,
      'size': 0.2,
      'position': vector64.Vector3(0.0, 0.5, -1.0),
      'shape': 'sphere',
      'general': 'La esfera es una superficie perfectamente redonda donde todos los puntos están a igual distancia del centro.',
      'volumen': 'Volumen = (4/3)πr³, donde r es el radio. Si r = 3, entonces V = (4/3)π × 3³ ≈ 113.1 unidades cúbicas.',
      'area': 'Área superficial = 4πr², donde r es el radio. Si r = 3, entonces A = 4π × 3² ≈ 113.1 unidades cuadradas.',
      'propiedades': 'La esfera tiene la menor área superficial para un volumen dado comparada con cualquier otra forma.',
      'dato_curioso': 'Aunque parezca coincidencia, para una esfera de radio 3, su volumen y su área superficial son numéricamente iguales.',
      'problema': '¿Cuál es el volumen de una esfera con radio 5 cm?',
      'solución': 'V = (4/3)π × 5³ ≈ 523.6 cm³',
      'formula': 'V = (4/3)πr³'
    },
    {
      'name': 'Cilindro',
      'color': Colors.green,
      'size': 0.2,
      'position': vector64.Vector3(0.0, 0.5, -1.0),
      'shape': 'cylinder',
      'general': 'El cilindro es un sólido formado por dos círculos paralelos e idénticos unidos por una superficie curva.',
      'volumen': 'Volumen = πr²h, donde r es el radio y h la altura. Si r = 2 y h = 5, entonces V = π × 2² × 5 ≈ 62.8 unidades cúbicas.',
      'area': 'Área superficial = 2πr² + 2πrh, donde r es el radio y h la altura. Si r = 2 y h = 5, entonces A = 2π × 2² + 2π × 2 × 5 ≈ 87.96 unidades cuadradas.',
      'propiedades': 'Un cilindro recto tiene generatrices perpendiculares a las bases. Las secciones paralelas a la base son círculos idénticos.',
      'dato_curioso': 'El cilindro de altura igual al diámetro de su base tiene una relación óptima entre volumen y superficie, útil en diseño de latas de conserva.',
      'problema': '¿Qué altura debe tener un cilindro de radio 3 cm para que su volumen sea 100 cm³?',
      'solución': 'h = V/(πr²) = 100/(π × 3²) ≈ 3.54 cm',
      'formula': 'V = πr²h'
    },
    {
      'name': 'Cono',
      'color': Colors.orange,
      'size': 0.2,
      'position': vector64.Vector3(0.0, 0.5, -1.0),
      'shape': 'cone',
      'general': 'El cono es un sólido con una base circular y un vértice. La superficie lateral se estrecha desde la base hasta el vértice.',
      'volumen': 'Volumen = (1/3)πr²h, donde r es el radio de la base y h la altura. Si r = 3 y h = 4, entonces V = (1/3)π × 3² × 4 ≈ 37.7 unidades cúbicas.',
      'area': 'Área superficial = πr² + πrl, donde r es el radio, l es la longitud lateral (l = √(r² + h²)). Si r = 3 y h = 4, entonces l = 5 y A = π × 3² + π × 3 × 5 ≈ 75.4 unidades cuadradas.',
      'propiedades': 'El volumen de un cono es exactamente 1/3 del volumen del cilindro con la misma base y altura.',
      'dato_curioso': 'Si cortas un cono con un plano inclinado, puedes obtener diferentes secciones cónicas: círculos, elipses, parábolas o hipérbolas.',
      'problema': '¿Cuál es la longitud lateral (generatriz) de un cono con radio de base 6 cm y altura 8 cm?',
      'solución': 'l = √(r² + h²) = √(6² + 8²) = √(36 + 64) = √100 = 10 cm',
      'formula': 'l = √(r² + h²)'
    },
    {
      'name': 'Pirámide Cuadrada',
      'color': Colors.purple,
      'size': 0.2,
      'position': vector64.Vector3(0.0, 0.5, -1.0),
      'shape': 'pyramid',
      'general': 'Una pirámide cuadrada tiene una base cuadrada y 4 caras triangulares que se unen en un vértice.',
      'volumen': 'Volumen = (1/3)Bh, donde B es el área de la base y h la altura. Si el lado de la base es a = 4 y h = 6, entonces V = (1/3) × 4² × 6 = 32 unidades cúbicas.',
      'area': 'Área superficial = a² + 2a√(a²/4 + h²), donde a es el lado de la base y h la altura. Si a = 4 y h = 6, entonces A = 4² + 2 × 4 × √(16/4 + 36) = 16 + 8√(4 + 36) = 16 + 8√40 ≈ 66.6 unidades cuadradas.',
      'propiedades': 'La altura de cada cara triangular (apotema) es diferente de la altura de la pirámide. El centro de gravedad está a 1/4 de la altura desde la base.',
      'dato_curioso': 'La Gran Pirámide de Giza en Egipto es una pirámide cuadrada y fue la estructura más alta hecha por humanos durante más de 3,800 años.',
      'problema': '¿Cuál es la altura de una cara triangular (apotema) de una pirámide cuadrada con base de lado 6 cm y altura 8 cm?',
      'solución': 'Apotema = √(h² + (a/2)²) = √(8² + 3²) = √(64 + 9) = √73 ≈ 8.54 cm',
      'formula': 'Apotema = √(h² + (a/2)²)'
    },
    {
      'name': 'Prisma Triangular',
      'color': Colors.teal,
      'size': 0.2,
      'position': vector64.Vector3(0.0, 0.5, -1.0),
      'shape': 'prism',
      'general': 'Un prisma triangular tiene dos bases triangulares idénticas y tres caras rectangulares.',
      'volumen': 'Volumen = Bh, donde B es el área de la base triangular y h la altura del prisma. Para un triángulo equilátero de lado a = 4 y altura del prisma h = 5, V = (√3/4 × a²) × h = (√3/4 × 16) × 5 ≈ 34.6 unidades cúbicas.',
      'area': 'Área superficial = 2B + Ph, donde B es el área de la base, P el perímetro de la base y h la altura del prisma. Para un triángulo equilátero de lado a = 4 y altura del prisma h = 5, A = 2(√3/4 × 16) + 3 × 4 × 5 = 2 × 6.93 + 60 ≈ 73.86 unidades cuadradas.',
      'propiedades': 'El prisma triangular es el poliedro más simple con el menor número de caras (5) que puede existir en un espacio tridimensional.',
      'dato_curioso': 'El prisma triangular es usado en óptica para descomponer la luz blanca en los colores del arcoíris.',
      'problema': '¿Cuál es el volumen de un prisma triangular recto cuya base es un triángulo rectángulo con catetos de 3 cm y 4 cm, y altura del prisma 10 cm?',
      'solución': 'V = Bh = (1/2 × 3 × 4) × 10 = 6 × 10 = 60 cm³',
      'formula': 'V = Bh = (1/2 × base × altura del triángulo) × altura del prisma'
    },
  ];

  // Lista de problemas matemáticos adicionales
  final List<Map<String, dynamic>> mathProblems = [
    {
      'pregunta': 'Un cubo tiene un volumen de 27 cm³. ¿Cuál es la longitud de sus aristas?',
      'respuesta': 'a = ∛V = ∛27 = 3 cm',
      'tema': 'Cubo'
    },
    {
      'pregunta': 'Si el área superficial de una esfera es 256π cm², ¿cuál es su radio?',
      'respuesta': 'r = √(A/4π) = √(256π/4π) = √64 = 8 cm',
      'tema': 'Esfera'
    },
    {
      'pregunta': 'Un cilindro tiene radio 5 cm y altura 10 cm. ¿Cuál es su volumen?',
      'respuesta': 'V = πr²h = π × 5² × 10 = 250π ≈ 785.4 cm³',
      'tema': 'Cilindro'
    },
    {
      'pregunta': 'La suma de todas las aristas de un cubo es 60 cm. ¿Cuál es su volumen?',
      'respuesta': 'Suma de aristas = 12a, entonces 12a = 60, a = 5 cm. Volumen = a³ = 5³ = 125 cm³',
      'tema': 'Cubo'
    },
    {
      'pregunta': 'Un cono y un cilindro tienen la misma base y la misma altura. Si el volumen del cilindro es 120 cm³, ¿cuál es el volumen del cono?',
      'respuesta': 'Vcono = (1/3)Vcilindro = (1/3) × 120 = 40 cm³',
      'tema': 'Cono'
    },
    {
      'pregunta': 'La diagonal de un cubo mide 6√3 cm. ¿Cuál es el volumen del cubo?',
      'respuesta': 'd = a√3, por lo tanto a = d/√3 = 6√3/√3 = 6 cm. Volumen = a³ = 6³ = 216 cm³',
      'tema': 'Cubo'
    },
    {
      'pregunta': 'Una pirámide cuadrada tiene una base de área 36 cm² y una altura de 10 cm. ¿Cuál es su volumen?',
      'respuesta': 'V = (1/3)Bh = (1/3) × 36 × 10 = 120 cm³',
      'tema': 'Pirámide Cuadrada'
    },
  ];

  @override
  void initState() {
    super.initState();
    rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
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
    displayShape(coreController!);
    if (mostrarEjes) {
      displayCoordinateAxes(coreController!);
    }
  }

  void displayShape(ArCoreController controller) {
    // Limpiamos los nodos existentes
    shapeNodes.forEach((key, value) {
      controller.removeNode(nodeName: key);
    });
    shapeNodes.clear();

    // Creamos la nueva forma geométrica
    final currentShape = shapes[currentShapeIndex];
    final material = ArCoreMaterial(color: currentShape['color'] as Color);

    late var arCoreShape;

    switch (currentShape['shape']) {
      case 'cube':
        arCoreShape = ArCoreCube(
          materials: [material],
          size: vector64.Vector3(
            (currentShape['size'] as double) * currentScale,
            (currentShape['size'] as double) * currentScale,
            (currentShape['size'] as double) * currentScale,
          ),
        );
        break;
      case 'sphere':
        arCoreShape = ArCoreSphere(
          materials: [material],
          radius: (currentShape['size'] as double) * currentScale,
        );
        break;
      case 'cylinder':
        arCoreShape = ArCoreCylinder(
          materials: [material],
          radius: (currentShape['size'] as double) * currentScale,
          height: (currentShape['size'] as double) * 2 * currentScale,
        );
        break;
      case 'cone':
      // Fake a cone by using a cylinder and scaling it to create a tapering effect
        arCoreShape = ArCoreCylinder(
          materials: [material],
          radius: (currentShape['size'] as double) * currentScale,  // Bottom radius
          height: (currentShape['size'] as double) * 2 * currentScale, // Height of the cone
        );

        // Apply scaling to narrow the top to fake the cone
        final coneNode = ArCoreNode(
          name: 'cone',
          shape: arCoreShape,
          position: vector64.Vector3(0, 0, -1),
          rotation: vector64.Vector4(0, 0, 0, 1),
          scale: vector64.Vector3(1.0, 0.2, 1.0),  // Make the top part smaller
        );
        controller.addArCoreNode(coneNode);
        break;
      case 'pyramid':
      // Simulate a pyramid by scaling a cube to form a narrowing shape
        arCoreShape = ArCoreCube(
          materials: [material],
          size: vector64.Vector3(
            (currentShape['size'] as double) * currentScale,
            (currentShape['size'] as double) * currentScale, // Adjust height for pyramid effect
            (currentShape['size'] as double) * currentScale,
          ),
        );

        // Scale to create the pointy pyramid effect
        final pyramidNode = ArCoreNode(
          name: 'pyramid',
          shape: arCoreShape,
          position: vector64.Vector3(0, 0, -1),
          rotation: vector64.Vector4(0, 0, 0, 1),
          scale: vector64.Vector3(1.0, 0.3, 1.0),  // Make the pyramid top smaller
        );
        controller.addArCoreNode(pyramidNode);
        break;
      case 'prism':
      // Simulate a triangular prism with a cube (flattened in one direction)
        arCoreShape = ArCoreCube(
          materials: [material],
          size: vector64.Vector3(
            (currentShape['size'] as double) * 1.5 * currentScale,  // Width adjusted to simulate triangular shape
            (currentShape['size'] as double) * currentScale,
            (currentShape['size'] as double) * 2 * currentScale,
          ),
        );

        // Scale it to get the "triangular" effect by reducing one side
        final prismNode = ArCoreNode(
          name: 'prism',
          shape: arCoreShape,
          position: vector64.Vector3(0, 0, -1),
          rotation: vector64.Vector4(0, 0, 0, 1),
          scale: vector64.Vector3(0.5, 1.0, 1.0),  // Flatten it to create the illusion of a prism
        );
        controller.addArCoreNode(prismNode);
        break;
      default:
        arCoreShape = ArCoreCube(
          materials: [material],
          size: vector64.Vector3(
            (currentShape['size'] as double) * currentScale,
            (currentShape['size'] as double) * currentScale,
            (currentShape['size'] as double) * currentScale,
          ),
        );
    }


    // Creamos el nodo de la forma
    final shapeNode = ArCoreNode(
      name: currentShape['name'],
      shape: arCoreShape,
      position: currentShape['position'] as vector64.Vector3,
      rotation: vector64.Vector4(0, 0, 0, 0),
    );

    // Añadimos el nodo a la escena
    controller.addArCoreNode(shapeNode);
    shapeNodes[currentShape['name']] = shapeNode;

    // Si estamos mostrando fórmulas, las añadimos
    if (mostrarFormulas) {
      displayFormula(controller);
    }

    // Añadimos indicador a la forma actual
    _addIndicatorToCurrentShape(controller, currentShape);

    // Rotación animada de la forma

    rotationController.addListener(() {
      if (shapeNodes.containsKey(currentShape['name'])) {
        // Get the current node
        final node = shapeNodes[currentShape['name']]!;

        // Remove the current node
        controller.removeNode(nodeName: node.name);

        // Create a new node with updated rotation
        final updatedNode = ArCoreNode(
          name: node.name,
          shape: node.shape,
          position: node.position?.value,
          rotation: vector64.Vector4(0, rotationController.value * 360, 0, 1),
        );

        // Add the updated node
        controller.addArCoreNode(updatedNode);

        // Update our reference
        shapeNodes[currentShape['name']] = updatedNode;
      }
    });
  }

  void displayFormula(ArCoreController controller) {
    // Implementación básica - en una aplicación real se usaría una textura o texto 3D
    final currentShape = shapes[currentShapeIndex];
    final formulaMaterial = ArCoreMaterial(color: Colors.white.withOpacity(0.8));

    // Use ArCoreCube instead of ArCorePlane (which doesn't have an unnamed constructor)
    // A flat cube can work as a plane
    final formulaPlane = ArCoreCube(
      materials: [formulaMaterial],
      size: vector64.Vector3(0.15, 0.01, 0.05), // Very thin in Y direction to make it plane-like
    );

    final formulaNode = ArCoreNode(
      name: 'formula',
      shape: formulaPlane, // This should work now since ArCoreCube is an ArCoreShape
      position: vector64.Vector3(
        (currentShape['position'] as vector64.Vector3).x,
        (currentShape['position'] as vector64.Vector3).y + 0.3,
        (currentShape['position'] as vector64.Vector3).z,
      ),
    );

    controller.addArCoreNode(formulaNode);
  }

  void displayCoordinateAxes(ArCoreController controller) {
    // Eje X (rojo)
    final xAxisMaterial = ArCoreMaterial(color: Colors.red);
    final xAxis = ArCoreCylinder(
      materials: [xAxisMaterial],
      radius: 0.01,
      height: 1.0,
    );

    final xAxisNode = ArCoreNode(
      name: 'xAxis',
      shape: xAxis,
      position: vector64.Vector3(0.5, 0.5, -1.0),
      rotation: vector64.Vector4(0, 0, 90, 90), // Rotación para orientar el cilindro
    );

    controller.addArCoreNode(xAxisNode);
    shapeNodes['xAxis'] = xAxisNode;

    // Eje Y (verde)
    final yAxisMaterial = ArCoreMaterial(color: Colors.green);
    final yAxis = ArCoreCylinder(
      materials: [yAxisMaterial],
      radius: 0.01,
      height: 1.0,
    );

    final yAxisNode = ArCoreNode(
      name: 'yAxis',
      shape: yAxis,
      position: vector64.Vector3(0.0, 1.0, -1.0),
    );

    controller.addArCoreNode(yAxisNode);
    shapeNodes['yAxis'] = yAxisNode;

    // Eje Z (azul)
    final zAxisMaterial = ArCoreMaterial(color: Colors.blue);
    final zAxis = ArCoreCylinder(
      materials: [zAxisMaterial],
      radius: 0.01,
      height: 1.0,
    );

    final zAxisNode = ArCoreNode(
      name: 'zAxis',
      shape: zAxis,
      position: vector64.Vector3(0.0, 0.5, -0.5),
      rotation: vector64.Vector4(90, 0, 0, 90), // Rotación para orientar el cilindro
    );

    controller.addArCoreNode(zAxisNode);
    shapeNodes['zAxis'] = zAxisNode;

    // Etiquetas de los ejes
    _addAxisLabel(controller, 'X', vector64.Vector3(1.0, 0.5, -1.0), Colors.red);
    _addAxisLabel(controller, 'Y', vector64.Vector3(0.0, 1.5, -1.0), Colors.green);
    _addAxisLabel(controller, 'Z', vector64.Vector3(0.0, 0.5, 0.0), Colors.blue);
  }

  void _addAxisLabel(ArCoreController controller, String axis, vector64.Vector3 position, Color color) {
    final labelMaterial = ArCoreMaterial(color: color);
    final labelSphere = ArCoreSphere(
      materials: [labelMaterial],
      radius: 0.03,
    );

    final labelNode = ArCoreNode(
      name: '${axis}Label',
      shape: labelSphere,
      position: position,
    );

    controller.addArCoreNode(labelNode);
    shapeNodes['${axis}Label'] = labelNode;
  }

  void _addIndicatorToCurrentShape(ArCoreController controller, Map<String, dynamic> shape) {
    // Indicador encima de la forma seleccionada
    final indicatorMaterial = ArCoreMaterial(color: Colors.yellow);
    final indicator = ArCoreSphere(
      materials: [indicatorMaterial],
      radius: 0.02,
    );

    // Posición justo encima de la forma
    vector64.Vector3 shapePos = shape['position'] as vector64.Vector3;
    vector64.Vector3 indicatorPos = vector64.Vector3(
        shapePos.x,
        shapePos.y + 0.3 * currentScale,
        shapePos.z
    );

    final indicatorNode = ArCoreNode(
      name: 'currentShapeIndicator',
      shape: indicator,
      position: indicatorPos,
    );

    controller.addArCoreNode(indicatorNode);
    shapeNodes['currentShapeIndicator'] = indicatorNode;
  }

  void nextShape() {
    setState(() {
      currentShapeIndex = (currentShapeIndex + 1) % shapes.length;
      currentTopic = "general";
      showingSolution = false;
      _updateScene();
    });
  }

  void previousShape() {
    setState(() {
      currentShapeIndex = (currentShapeIndex - 1 + shapes.length) % shapes.length;
      currentTopic = "general";
      showingSolution = false;
      _updateScene();
    });
  }

  void toggleModoProfesor() {
    setState(() {
      modoProfesor = !modoProfesor;
    });
  }

  void toggleFormulas() {
    setState(() {
      mostrarFormulas = !mostrarFormulas;
      if (coreController != null) {
        if (mostrarFormulas) {
          displayFormula(coreController!);
        } else {
          coreController!.removeNode(nodeName: 'formula');
          shapeNodes.remove('formula');
        }
      }
    });
  }

  void toggleEjes() {
    setState(() {
      mostrarEjes = !mostrarEjes;
      if (coreController != null) {
        if (mostrarEjes) {
          displayCoordinateAxes(coreController!);
        } else {
          // Eliminar ejes
          coreController!.removeNode(nodeName: 'xAxis');
          coreController!.removeNode(nodeName: 'yAxis');
          coreController!.removeNode(nodeName: 'zAxis');
          coreController!.removeNode(nodeName: 'XLabel');
          coreController!.removeNode(nodeName: 'YLabel');
          coreController!.removeNode(nodeName: 'ZLabel');
          shapeNodes.remove('xAxis');
          shapeNodes.remove('yAxis');
          shapeNodes.remove('zAxis');
          shapeNodes.remove('XLabel');
          shapeNodes.remove('YLabel');
          shapeNodes.remove('ZLabel');
        }
      }
    });
  }

  void incrementScale() {
    setState(() {
      currentScale += 0.1;
      if (coreController != null) {
        displayShape(coreController!);
      }
    });
  }

  void decrementScale() {
    setState(() {
      if (currentScale > 0.2) {
        currentScale -= 0.1;
        if (coreController != null) {
          displayShape(coreController!);
        }
      }
    });
  }

  void changeTopic(String topic) {
    setState(() {
      currentTopic = topic;
      showingSolution = false;
    });
  }

  void toggleSolution() {
    setState(() {
      showingSolution = !showingSolution;
    });
  }

  void nextProblem() {
    setState(() {
      // Filtrar problemas que coincidan con la forma actual
      final relevantProblems = mathProblems.where(
              (problem) => problem['tema'] == shapes[currentShapeIndex]['name']
      ).toList();

      if (relevantProblems.isNotEmpty) {
        currentProblemIndex = (currentProblemIndex + 1) % relevantProblems.length;
      } else {
        // Si no hay problemas específicos, usar el problema incorporado en la forma
        currentProblemIndex = 0;
      }
      showingSolution = false;
    });
  }

  void _updateScene() {
    if (coreController != null) {
      displayShape(coreController!);
    }
  }

  String _getCurrentShapeInfo() {
    var shape = shapes[currentShapeIndex];

    switch (currentTopic) {
      case 'volumen':
        return shape['volumen'];
      case 'area':
        return shape['area'];
      case 'propiedades':
        return shape['propiedades'];
      case 'general':
      default:
        return shape['general'];
    }
  }

  Map<String, dynamic> _getCurrentProblem() {
    // Intentamos encontrar un problema específico para esta forma
    final relevantProblems = mathProblems.where(
            (problem) => problem['tema'] == shapes[currentShapeIndex]['name']
    ).toList();

    if (relevantProblems.isNotEmpty) {
      return {
        'pregunta': relevantProblems[currentProblemIndex]['pregunta'],
        'respuesta': relevantProblems[currentProblemIndex]['respuesta']
      };
    } else {
      // Si no hay problemas específicos, usamos el incorporado en la forma
      return {
        'pregunta': shapes[currentShapeIndex]['problema'],
        'respuesta': shapes[currentShapeIndex]['solución']
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Matemáticas 3D en AR"),
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

          // Panel de control de escala
          Positioned(
            top: 20,
            right: 20,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: "btnIncrementarEscala",
                  onPressed: incrementScale,
                  mini: true,
                  backgroundColor: Colors.blueGrey,
                  child: const Icon(Icons.add),
                  tooltip: "Aumentar tamaño",
                ),
                Text(
                  "${(currentScale * 100).toStringAsFixed(0)}%",
                  style: TextStyle(
                    color: Colors.white,
                    backgroundColor: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FloatingActionButton(
                  heroTag: "btnDecrementarEscala",
                  onPressed: decrementScale,
                  mini: true,
                  backgroundColor: Colors.blueGrey,
                  child: const Icon(Icons.remove),
                  tooltip: "Disminuir tamaño",
                ),
              ],
            ),
          ),

          // Panel de información de la forma
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
                  // Título de la forma con su color característico
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: shapes[currentShapeIndex]['color'] as Color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        shapes[currentShapeIndex]['name'],
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
                      _infoTab('Volumen', 'volumen'),
                      _infoTab('Área', 'area'),
                      _infoTab('Propiedades', 'propiedades'),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Descripción según la pestaña seleccionada
                  Text(
                    _getCurrentShapeInfo(),
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
                              "Dato para el profesor: ${shapes[currentShapeIndex]['dato_curioso']}",
                              style: const TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  // Fórmula relacionada
                  if (mostrarFormulas && shapes[currentShapeIndex].containsKey('formula')) ...[
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.purple.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.functions, color: Colors.white, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "Fórmula: ${shapes[currentShapeIndex]['formula']}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
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

          // Panel de problemas matemáticos (aparece cuando estamos en modo profesor)
          if (modoProfesor) Positioned(
            bottom: 280,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.indigo.withOpacity(0.8),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white30, width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Problema:",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.navigate_next, color: Colors.white),
                        onPressed: nextProblem,
                        tooltip: "Siguiente problema",
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _getCurrentProblem()['pregunta'],
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  if (showingSolution) ...[
                    const Text(
                      "Solución:",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      _getCurrentProblem()['respuesta'],
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ] else ...[
                    Center(
                      child: ElevatedButton(
                        onPressed: toggleSolution,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        ),
                        child: const Text(
                          "Mostrar Solución",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),

          // Controles de navegación
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Botón anterior
                FloatingActionButton(
                  heroTag: "btnPrevio",
                  onPressed: previousShape,
                  backgroundColor: Colors.blueGrey,
                  child: const Icon(Icons.arrow_back),
                ),
                const SizedBox(width: 20),

                // Botón de fórmulas
                FloatingActionButton(
                  heroTag: "btnFormulas",
                  onPressed: toggleFormulas,
                  backgroundColor: mostrarFormulas ? Colors.green : Colors.blueGrey,
                  child: const Icon(Icons.functions),
                  tooltip: "Mostrar fórmulas",
                ),

                const SizedBox(width: 20),

                // Botón para mostrar ejes de coordenadas
                FloatingActionButton(
                  heroTag: "btnEjes",
                  onPressed: toggleEjes,
                  backgroundColor: mostrarEjes ? Colors.green : Colors.blueGrey,
                  child: const Icon(Icons.grid_3x3),
                  tooltip: "Mostrar ejes de coordenadas",
                ),

                const SizedBox(width: 20),

                // Botón siguiente
                FloatingActionButton(
                  heroTag: "btnSiguiente",
                  onPressed: nextShape,
                  backgroundColor: Colors.blueGrey,
                  child: const Icon(Icons.arrow_forward),
                ),
              ],
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