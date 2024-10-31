import 'package:flutter/material.dart';

import 'activities_screen.dart';

class TopicsScreen extends StatelessWidget {
  final String unitTitle;

  const TopicsScreen({super.key, required this.unitTitle});

  @override
  Widget build(BuildContext context) {
    final List<String> topics = ["Topic 1", "Topic 2", "Topic 3", "Topic 4"];

    return Scaffold(
      appBar: AppBar(
        title: Text(unitTitle),
      ),
      body: ListView.builder(
        itemCount: topics.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.yellowAccent,
            child: ListTile(
              title: Text(topics[index]),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => ActivitiesScreen(topicTitle: topics[index]),
                );
              },
            ),
          );
        },
      ),
    );
  }
}