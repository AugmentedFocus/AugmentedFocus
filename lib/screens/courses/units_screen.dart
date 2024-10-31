import 'package:flutter/material.dart';

import 'topics_screen.dart';

class UnitsScreen extends StatelessWidget {
  final String courseTitle;

  const UnitsScreen({super.key, required this.courseTitle});

  @override
  Widget build(BuildContext context) {
    final List<String> units = ["Unit 1", "Unit 2", "Unit 3", "Unit 4", "Unit 5"];

    return Scaffold(
      appBar: AppBar(
        title: Text(courseTitle),
      ),
      body: ListView.builder(
        itemCount: units.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.orangeAccent,
            child: ListTile(
              title: Text(units[index]),
              subtitle: Text('About the unit'),
              trailing: Icon(Icons.bookmark_border),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => TopicsScreen(unitTitle: units[index]),
                );
              },
            ),
          );
        },
      ),
    );
  }
}