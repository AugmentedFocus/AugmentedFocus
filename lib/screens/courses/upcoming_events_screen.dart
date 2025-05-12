import 'package:flutter/material.dart';
import 'activities/activities_screen_solar.dart';
import 'activities/activities_screen_math.dart';

class UpcomingEventsScreen extends StatelessWidget {
  const UpcomingEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [
      Colors.redAccent,
      Colors.greenAccent,
    ];

    final List<Map<String, dynamic>> events = [
      {
        "title": "Sistema solar",
        "course": "Primer curso",
        "date": "12/05/2025",
        "due": "15/05/2025",
        "timeLeft": "3 días",
        "screen": ActivitiesScreen(
          topicTitle: "Sistema solar",
          activityTitle: "Actividad 1",
        ),
      },
      {
        "title": "Álgebra",
        "course": "Primer curso",
        "date": "13/05/2025",
        "due": "18/05/2025",
        "timeLeft": "5 días",
        "screen": ActivitiesScreenMath(
          topicTitle: "Álgebra",
          activityTitle: "Actividad 1",
        ),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Actividades pendientes'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          final color = colors[index % colors.length];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Card(
              color: color,
              elevation: 4,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => event["screen"]),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Contenido principal del evento
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${event["title"]} - ${event["course"]}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text('Fecha: ${event["date"]}', style: const TextStyle(fontSize: 16)),
                          Text('Entrega: ${event["due"]}', style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                      // "Time left" alineado a la derecha
                      Text(
                        event["timeLeft"],
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}