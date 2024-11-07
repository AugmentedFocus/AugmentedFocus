import 'package:flutter/material.dart';

class UnitsScreen extends StatelessWidget {
  final String courseTitle;

  const UnitsScreen({super.key, required this.courseTitle});

  @override
  Widget build(BuildContext context) {
    final List<String> units = ["Unit 1", "Unit 2", "Unit 3", "Unit 4", "Unit 5"];
    final Map<String, List<String>> topicsByUnit = {
      "Unit 1": ["Topic 1", "Topic 2", "Topic 3", "Topic 4"],
      "Unit 2": ["Topic 1", "Topic 2", "Topic 3"],
      "Unit 3": ["Topic 1", "Topic 2"],
      "Unit 4": ["Topic 1", "Topic 2", "Topic 3", "Topic 4"],
      "Unit 5": ["Topic 1", "Topic 2", "Topic 3"],
    };
    final Map<String, List<String>> activitiesByTopic = {
      "Topic 1": ["Activity 1", "Activity 2", "Activity 3", "Activity 4"],
      "Topic 2": ["Activity 1", "Activity 2"],
      "Topic 3": ["Activity 1", "Activity 2", "Activity 3"],
      "Topic 4": ["Activity 1", "Activity 2", "Activity 3", "Activity 4"],
    };

    final List<Color> colors = [
      Colors.redAccent,
      Colors.greenAccent,
      Colors.lightBlueAccent,
      Colors.yellowAccent,
      Colors.orangeAccent,
      Colors.purpleAccent,
      Colors.tealAccent,
      Colors.pinkAccent,
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
          final topicColor = Colors.white.withOpacity(0.4);
          final activityColor = Colors.white.withOpacity(0.4);

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
                subtitle: const Text('About the unit'),
                children: topics.map((topic) {
                  final activities = activitiesByTopic[topic] ?? [];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: Card(
                      color: topicColor,
                      child: ExpansionTile(
                        title: Text(topic),
                        subtitle: const Text('About the topic'),
                        children: activities.map((activity) {
                          return ListTile(
                            tileColor: activityColor, // Color aún más claro para activities
                            title: Text(activity),
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Selected $activity in $topic")),
                              );
                            },
                          );
                        }).toList(),
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