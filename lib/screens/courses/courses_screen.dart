import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:augmentedfocus/screens/courses/units_screen.dart';
import 'package:augmentedfocus/providers/font_size_provider.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> courses = ["Primer curso", "Segundo curso"];
    final List<Color> colors = [
      Colors.redAccent,
      Colors.greenAccent,
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Cursos'),
        centerTitle: true,
      ),
      body: ListView.builder(
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
                      builder: (context) =>
                          UnitsScreen(courseTitle: courses[index]),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Consumer<FontSizeProvider>(
                          builder: (context, fontSizeProvider, _) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  courses[index],
                                  style: TextStyle(
                                    fontSize: fontSizeProvider.fontSize + 4,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '', // Aquí puedes colocar una descripción si lo deseas
                                  style: TextStyle(
                                    fontSize: fontSizeProvider.fontSize,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            );
                          },
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
      ),
    );
  }
}