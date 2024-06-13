// ignore_for_file: slash_for_doc_comments

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/repos/playback_config_repo.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';
import 'package:tiktok_clone/firebase_options.dart';
import 'package:tiktok_clone/router.dart';

void main() async {
  /**앱 시작 전에 바꾸고 싶은 state 가 있다면
   * engine 자체와 engine-widget 연결을 확실히 초기화해야 함
   * WidgetsFlutterBinding : This is the glue that binds the framework to the Flutter engine.
   */
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // SystemChrome : main() 에서 기본값으로 설정해도 되고, 페이지마다 다르게 설정해도 됨
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  // 21.3 Provider 초기화
  final preferences = await SharedPreferences.getInstance();
  final repository = PlaybackConfigRepository(preferences);

  // 22.1 Riverpod 사용 가능한 환경으로 설정
  runApp(
    ProviderScope(overrides: [
      playbackConfigProvider.overrideWith(
        () => PlaybackConfigViewModel(repository),
      ),
    ], child: const TikTokApp()),
  );
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
    return MaterialApp.router(
      routerConfig: router,
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
    );
  }
}

/**LayoutBuilder (반응형)
 * - 화면 크기가 아닌 box 의 최대 크기를 알기 위해 사용함
 * - 전체 화면 사이즈보다 Widget 이 어느 정도 크기인지 중요
 * - 테스트를 위해 home 의 속성값으로 넣고 화면 확인하였음 
 */
class LayoutBuilderCodeLab extends StatelessWidget {
  const LayoutBuilderCodeLab({super.key});

  @override
  Widget build(BuildContext context) {
    /**Media Query (반응형)
     * - 화면 사이즈가 변경될 때마다 스스로 다시 build
     * - 화면의 사이즈, orientation(가로, 세로) 등 기기에 대한 정보를 알 수 있음
     * - MediaQuery.of(context).platformBrightness // 다크모드 여부
     * - padding : system UI(Status Bar 같은)에 의해 보이지 않는 부분 확인 가능
     */
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: LayoutBuilder(
        // constraints: box 가 커질 수 있는 최대치
        builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth, // size.width
            height: constraints.maxHeight, // size.height
            color: Colors.teal,
            child: Center(
              child: Text(
                "${size.width}",
                style: const TextStyle(
                  fontSize: Sizes.size40,
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
