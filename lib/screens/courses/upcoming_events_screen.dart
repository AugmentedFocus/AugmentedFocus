import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UpcomingEventsScreen extends StatelessWidget {
  const UpcomingEventsScreen({super.key});

  Future<List<String>> fetchEvents() async {
    var response = await http.get(Uri.parse("https://corporatebs-generator.sameerkumar.website"));
    var jsonResponse = json.decode(response.body);
    return List.generate(6, (index) => jsonResponse['phrase']);
  }

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [
      Colors.orangeAccent,
      Colors.lightBlueAccent,
      Colors.redAccent,
      Colors.yellowAccent,
      Colors.greenAccent,
      Colors.pinkAccent,
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upcoming Events'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: fetchEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          } else {
            List<String> events = snapshot.data as List<String>;
            return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Card(
                    color: colors[index % colors.length],
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Contenido principal del evento
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Event title - Course title',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Date',
                                style: TextStyle(fontSize: 16),
                              ),
                              const Text(
                                'Due date',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          // "Time left" alineado a la derecha
                          const Text(
                            'Time left',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
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