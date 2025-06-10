import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:augmentedfocus/providers/font_size_provider.dart';

class GradesScreen extends StatelessWidget {
  const GradesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fontSize = Provider.of<FontSizeProvider>(context).fontSize;

    final List<Color> colors = [
      Colors.redAccent,
      Colors.greenAccent,
    ];

    final List<Map<String, dynamic>> courseGrades = [
      {
        "title": "Primer curso",
        "grades": [
          {"label": "Unidad 1 - Sistema solar", "score": "9.5"},
          {"label": "Unidad 2 - Álgebra", "score": "8.0"},
        ]
      },
      {
        "title": "Segundo curso",
        "grades": [
          {"label": "Sin unidades registradas", "score": "-"},
        ]
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calificaciones',
          style: TextStyle(fontSize: fontSize + 4, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: courseGrades.length,
        itemBuilder: (context, index) {
          final Color cardColor = colors[index % colors.length];
          final course = courseGrades[index];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Card(
              color: cardColor,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Colors.black, width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título del curso
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          course['title'],
                          style: TextStyle(
                            fontSize: fontSize + 2,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const Icon(
                          Icons.grade,
                          color: Colors.black,
                          size: 28,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Lista de calificaciones
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: course['grades'].map<Widget>((grade) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  grade['label'],
                                  style: TextStyle(
                                    fontSize: fontSize,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  grade['score'],
                                  style: TextStyle(
                                    fontSize: fontSize,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
