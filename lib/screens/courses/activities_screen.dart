import 'package:flutter/material.dart';


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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  activityTitle,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Date: ${dateCreated.toLocal().toString().split(' ')[0]}'),
                    Text('Due Date: ${dueDate.toLocal().toString().split(' ')[0]}'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              "Descripción de la actividad:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Esta es una descripción detallada de la actividad, explicando los objetivos y las tareas necesarias para completarla.",
              style: TextStyle(fontSize: 16),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 150,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Descargando actividad...")),
                        );
                      },
                      icon: const Icon(Icons.download),
                      label: const Text("Descargar"),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Iniciando actividad...")),
                        );
                      },
                      icon: const Icon(Icons.play_arrow),
                      label: const Text("Iniciar Actividad"),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}