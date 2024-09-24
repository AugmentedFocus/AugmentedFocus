import 'package:augmentedfocus/screens/courses/courses.dart';
import 'package:augmentedfocus/screens/courses/grades.dart';
import 'package:augmentedfocus/screens/courses/upcoming_events.dart';
import 'package:augmentedfocus/screens/login/login_screen.dart';
import 'package:augmentedfocus/screens/login/register_screen.dart';
import 'package:augmentedfocus/screens/login/welcome_screen.dart';
import 'package:augmentedfocus/screens/profile/profile.dart';
import 'package:flutter/material.dart';

import 'config/theme/app_theme.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Optional: Remove the debug banner
      title: 'Augmented Focus App', // Optional: Set a title for your app
      theme: AppTheme.theme, // Assuming you have a defined theme
      initialRoute: '/', // Set initial route to welcome screen
      routes: {
        '/': (context) => WelcomeScreen(),
        '/register': (context) => RegisterScreen(),
        '/login': (context) => LoginScreen(),
        '/courses': (context) => CoursesScreen(),
        '/grades': (context) => GradesScreen(),
        '/upcoming-events': (context) => UpcomingEventsScreen(),
        '/profile': (context) => ProfileScreen(),
      },
    );
  }
}