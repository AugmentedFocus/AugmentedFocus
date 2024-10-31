import 'package:augmentedfocus/shared/navbar_roots.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  Future<List<String>> fetchCourses() async {
    var response = await http.get(Uri.parse("https://corporatebs-generator.sameerkumar.website"));
    var jsonResponse = json.decode(response.body);
    return List.generate(5, (index) => jsonResponse['phrase']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Courses'),
      ),
      body: FutureBuilder(
        future: fetchCourses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading data'));
          } else {
            List<String> courses = snapshot.data as List<String>;
            return ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.greenAccent,
                  child: ListTile(
                    title: Text(courses[index]),
                    subtitle: Text('Teacher: Teacher Name'),
                    trailing: Icon(Icons.bookmark_border),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}