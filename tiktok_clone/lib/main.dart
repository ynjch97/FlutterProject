// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';

void main() async {
  /**앱 시작 전에 바꾸고 싶은 state 가 있다면
   * engine 자체와 engine-widget 연결을 확실히 초기화해야 함
   * WidgetsFlutterBinding : This is the glue that binds the framework to the Flutter engine.
   */
  WidgetsFlutterBinding.ensureInitialized();

  // SystemChrome : main() 에서 기본값으로 설정해도 되고, 페이지마다 다르게 설정해도 됨
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

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
      // 상단 debug 리본 제거
      debugShowCheckedModeBanner: false,
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
      home: const SignUpScreen(),
    );
  }
}
