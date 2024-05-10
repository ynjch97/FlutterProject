// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:pomodoro/screens/home_screen.dart';

/**POMODORO : 25분 일하고 5분 쉬는 생산성 기술
 * 
 * 구조
 * - App 은 StatelessWidget
 * - 하위의 HomeScreen 은 StatefulWidget
 */
void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: const Color(0xFFE7626C),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Color(0xFF232B55),
          ),
        ),
        cardColor: const Color(0xFFF4EDDB),
      ),
      home: const HomeScreen(),
    );
  }
}
