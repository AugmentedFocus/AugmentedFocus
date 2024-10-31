import 'package:flutter/material.dart';

import '../../shared/navbar_roots.dart';

class GradesScreen extends StatelessWidget {
  const GradesScreen({super.key});

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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text('Course title'),
                subtitle: Text('Teacher: Teacher name'),
                trailing: SingleChildScrollView(  // Envolver la columna en SingleChildScrollView
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Ajusta el tamaño según el contenido
                    crossAxisAlignment: CrossAxisAlignment.end, // Alinea las notas a la derecha
                    children: [
                      Text('Grade 1'),
                      Text('Grade 2'),
                      Text('Grade 3'),
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