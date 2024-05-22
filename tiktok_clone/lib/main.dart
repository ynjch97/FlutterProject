// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';

void main() {
  runApp(const TikTokApp());
}

/**TikTok UX/UI 참고 사이트 (iOS, Android 확인) : https://mobbin.com/
 * 강의 기준 스크린샷 : https://nomadcoders.co/downloads/tiktok.zip
 */
class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  /**Scaffold
   * - navigation bar, body, navbar 사용
   * - Text 방향, 사이즈 등을 설정
   */
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TikTok Clone',
      theme: ThemeData(
        primaryColor: const Color(0xFFE9435A),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          // appBarTheme : AppBar 를 전역으로 꾸미기
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: Sizes.size18,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
      ),
      home: const SignUpScreen(),
    );
  }
}
