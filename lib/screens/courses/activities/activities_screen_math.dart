import 'package:flutter/material.dart';

import '../../ar/ar_lesson_math.dart';

class ActivitiesScreenMath extends StatelessWidget {
  final String topicTitle;
  final String activityTitle;

  const ActivitiesScreenMath({super.key, required this.topicTitle, required this.activityTitle});

  @override
  Widget build(BuildContext context) {
    final DateTime dateCreated = DateTime.now();
    final DateTime dueDate = dateCreated.add(const Duration(days: 7));

    return Scaffold(
      appBar: AppBar(
        title: Text(topicTitle),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            border: Border.all(color: Colors.black),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    activityTitle,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Fecha: ${dateCreated.day}/${dateCreated.month}/${dateCreated.year}',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text('Entrega: ${dueDate.day}/${dueDate.month}/${dueDate.year}',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                "Actividad de Realidad Aumentada: Matemática. En esta actividad, usarás realidad aumentada para explorar conceptos matemáticos como figuras geométricas en 3D, fracciones y operaciones básicas. Podrás visualizar y manipular objetos matemáticos, lo cual facilitará tu comprensión espacial y lógica.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                "Objetivos:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "• Visualizar figuras geométricas tridimensionales\n"
                    "• Comprender fracciones y su representación gráfica\n"
                    "• Practicar operaciones básicas (suma, resta, multiplicación y división)\n"
                    "• Fortalecer habilidades de razonamiento espacial mediante la interacción en AR",
                style: TextStyle(fontSize: 16),
              ),
              const Spacer(),
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Descargando recursos de AR...")),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                        ),
                        child: const Text(
                          "Descargar recursos",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MathematicsAR()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                        ),
                        child: const Text(
                          "Iniciar actividad",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}