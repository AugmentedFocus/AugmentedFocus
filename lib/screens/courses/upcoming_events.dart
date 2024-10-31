import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../shared/navbar_roots.dart';

class UpcomingEventsScreen extends StatelessWidget {
  const UpcomingEventsScreen({super.key});

  Future<List<String>> fetchEvents() async {
    var response = await http.get(Uri.parse("https://corporatebs-generator.sameerkumar.website"));
    var jsonResponse = json.decode(response.body);
    return List.generate(5, (index) => jsonResponse['phrase']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upcoming Events'),
      ),
      body: FutureBuilder(
        future: fetchEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading data'));
          } else {
            List<String> events = snapshot.data as List<String>;
            return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.orangeAccent,
                  child: ListTile(
                    title: Text(events[index]),
                    subtitle: Text('Due Date: Some date'),
                    trailing: Text('Time left'),
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