import 'package:augmentedfocus/screens/courses/units_screen.dart';
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
    final List<Color> colors = [
      Colors.redAccent,
      Colors.greenAccent,
      Colors.lightBlueAccent,
      Colors.yellowAccent,
      Colors.orangeAccent,
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Course List'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: fetchCourses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          } else {
            List<String> courses = snapshot.data as List<String>;
            return ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Card(
                    color: colors[index % colors.length],
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Colors.black, width: 1),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UnitsScreen(courseTitle: courses[index]),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    courses[index],
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    'Teacher name',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.bookmark_border,
                              color: Colors.black,
                              size: 28,
                            ),
                          ],
                        ),
                      ),
                    ),
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