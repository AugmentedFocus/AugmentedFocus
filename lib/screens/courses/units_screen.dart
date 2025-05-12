import 'package:flutter/material.dart';

import 'activities/activities_screen_solar.dart';
import 'activities/activities_screen_math.dart';

class UnitsScreen extends StatelessWidget {
  final String courseTitle;

  const UnitsScreen({super.key, required this.courseTitle});

  @override
  Widget build(BuildContext context) {
    final List<String> units = ["Unidad 1", "Unidad 2"];
    final Map<String, List<String>> topicsByUnit = {
      "Unidad 1": ["Sistema solar"],
      "Unidad 2": ["Álgebra"],
    };

    final List<Color> colors = [
      Colors.redAccent,
      Colors.greenAccent,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(courseTitle),
      ),
      body: ListView.builder(
        itemCount: units.length,
        itemBuilder: (context, index) {
          final unitTitle = units[index];
          final topics = topicsByUnit[unitTitle] ?? [];
          final unitColor = colors[index % colors.length];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Card(
              color: unitColor,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Colors.black, width: 1),
              ),
              child: ExpansionTile(
                title: Text(
                  unitTitle,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: const Text('Contenido de la unidad'),
                children: topics.map((topic) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: Card(
                      color: Colors.white.withOpacity(0.5),
                      child: ListTile(
                        title: Text(topic),
                        subtitle: const Text("Actividad 1"),
                        onTap: () {
                          if (unitTitle == "Unidad 1") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ActivitiesScreen(
                                  topicTitle: topic,
                                  activityTitle: "Actividad 1",
                                ),
                              ),
                            );
                          } else if (unitTitle == "Unidad 2") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ActivitiesScreenMath(
                                  topicTitle: topic,
                                  activityTitle: "Actividad 1",
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}