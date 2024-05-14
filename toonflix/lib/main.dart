// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:toonflix/screens/home_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key}); // 이 Widget 의 key 를 StatelessWidget 이라는 슈퍼 클래스에 보냄

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFF00DC64),
      ),
      home: Scaffold(
        body: HomeScreen(),
      ),
    );
  }
}
