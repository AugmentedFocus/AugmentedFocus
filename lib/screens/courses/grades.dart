import 'package:flutter/material.dart';

class GradesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grades'),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.redAccent,
            child: ListTile(
              title: Text('Course title'),
              subtitle: Text('Teacher: Teacher name'),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Grade 1'),
                  Text('Grade 2'),
                  Text('Grade 3'),
                  Text('Grade 4'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}