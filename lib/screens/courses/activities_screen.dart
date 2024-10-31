import 'package:flutter/material.dart';

class ActivitiesScreen extends StatelessWidget {
  final String topicTitle;

  const ActivitiesScreen({super.key, required this.topicTitle});

  @override
  Widget build(BuildContext context) {
    final List<String> activities = ["Activity 1", "Activity 2", "Activity 3", "Activity 4"];

    return Scaffold(
      appBar: AppBar(
        title: Text(topicTitle),
      ),
      body: ListView.builder(
        itemCount: activities.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.redAccent,
            child: ListTile(
              title: Text(activities[index]),
            ),
          );
        },
      ),
    );
  }
}