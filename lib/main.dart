import 'package:augmentedfocus/screens/courses/courses.dart';
import 'package:augmentedfocus/screens/courses/grades.dart';
import 'package:augmentedfocus/screens/courses/upcoming_events.dart';
import 'package:augmentedfocus/screens/profile/profile.dart';
import 'package:flutter/material.dart';

import 'config/theme/app_theme.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      routes: {
        '/courses': (context) => CoursesScreen(),
        '/grades': (context) => GradesScreen(),
        '/upcoming-events': (context) => UpcomingEventsScreen(),
        '/profile': (context) => ProfileScreen(),
      },
    );
  }
}