import 'package:augmentedfocus/screens/login/login_screen.dart';
import 'package:augmentedfocus/screens/login/welcome_screen.dart';
import 'package:augmentedfocus/widgets/navbar_roots.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AugmentedFocus',
      home: WelcomeScreen(),
    );
  }
}