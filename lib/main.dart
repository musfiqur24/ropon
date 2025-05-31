import 'package:flutter/material.dart';
import 'onboarding_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Onboarding Demo',
      home: OnboardingPage(), // your onboarding page widget
    );
  }
}
