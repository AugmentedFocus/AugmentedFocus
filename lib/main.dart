import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:augmentedfocus/screens/login/welcome_screen.dart';
import 'package:augmentedfocus/providers/font_size_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => FontSizeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FontSizeProvider>(
      builder: (context, fontProvider, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'AugmentedFocus',
          theme: ThemeData(
            textTheme: TextTheme(
              bodyMedium: TextStyle(fontSize: fontProvider.fontSize),
              bodyLarge: TextStyle(fontSize: fontProvider.fontSize + 2),
              labelLarge: TextStyle(fontSize: fontProvider.fontSize),
            ),
          ),
          home: const WelcomeScreen(),
        );
      },
    );
  }
}