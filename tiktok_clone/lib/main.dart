// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/main_navigation/main_navigation_screen.dart';

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
        // TextField 스타일 조정
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
        ),
        // 버튼 클릭 시 번쩍거리는 Splash 효과를 꺼줌
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          // appBarTheme : AppBar 를 전역으로 꾸미기
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          surfaceTintColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: Sizes.size18,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
      ),
      home: const MainNavigationScreen(),
    );
  }
}
