import 'package:flutter/material.dart';
import 'onboarding_page.dart';  // adjust the import to your file location

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Onboarding Demo',
      home: const OnboardingPage(),  // <-- Use your correct widget name here
    );
  }
}
