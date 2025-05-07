import 'package:flutter/material.dart';

import '../../ar/ar_activity_1.dart';
import '../../ar/ar_lesson_solar.dart'; // Importamos el nuevo archivo

class ActivitiesScreen extends StatelessWidget {
  final String topicTitle;
  final String activityTitle;

  const ActivitiesScreen({super.key, required this.topicTitle, required this.activityTitle});

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
              // Descripción de la actividad actualizada para sistema solar
              const Text(
                "Actividad de Realidad Aumentada: Sistema Solar. En esta actividad, explorarás los planetas del sistema solar en 3D usando realidad aumentada. Podrás aprender sobre sus características, tamaños, órbitas y composición, todo mientras interactúas con ellos en tu entorno real.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              // Objetivos de aprendizaje
              const Text(
                "Objetivos:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "• Identificar los planetas del sistema solar\n"
                    "• Comparar tamaños relativos de los planetas\n"
                    "• Comprender la distribución orbital\n"
                    "• Conocer características básicas de cada planeta",
                style: TextStyle(fontSize: 16),
              ),
              const Spacer(),
              // Botones de Descargar e Iniciar Actividad
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
                          // Cambiamos para iniciar la nueva actividad ClaseSistemaSolarAR
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ClaseSistemaSolarAR()),
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