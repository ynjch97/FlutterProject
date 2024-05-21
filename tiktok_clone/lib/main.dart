// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';

void main() {
  runApp(const TikTokApp());
}

/**TikTok UX/UI 참고 사이트 (iOS, Android 확인) : https://mobbin.com/
 * 강의 기준 스크린샷 : https://nomadcoders.co/downloads/tiktok.zip
 */
class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TikTok Clone',
      theme: ThemeData(primaryColor: const Color(0xFFE9435A)),
      home: Container(),
    );
  }
}
