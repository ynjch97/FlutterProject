// ignore_for_file: slash_for_doc_comments

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/common/widgets/main_navigation/main_navigation_screen.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/features/inbox/activity_screen.dart';
import 'package:tiktok_clone/features/inbox/chat_detail_screen.dart';
import 'package:tiktok_clone/features/inbox/chats_screen.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';
import 'package:tiktok_clone/features/videos/views/video_recording_screen.dart';

/**#19 VIDEO RECORDING => 기존 개발 내용 지우고 VideoRecordingScreen 만 사용 (백업 : router_backup.dart)
 */

/**#20 STATE MANAGEMENT => 기존 개발 내용 지우고 새롭게 구성
 * - 18.0 NAVIGATOR 2 기반 + Navigator API 사용
 * 
 * - Sign Up("/") 단계에서 회원가입 선택 시 /username, /email, /password, /birthday 등을 거쳐야 함
 * - 모든 것을 url 로 만들면 주소창에 직접 입력하여 화면을 진입할 수 있음
 * - Onboarding 단계에서도 interest, tutorial 화면은 같은 URL을 사용하려고 함
 * => 위와 같은 경우 URL이 변경되지 않도록 Navigator API 사용, 이외의 경우 GoRouter 사용
 */
final router = GoRouter(
  initialLocation: "/upload", // 시작 화면 설정
  routes: [
    // 회원가입
    GoRoute(
      name: SignUpScreen.routeName,
      path: SignUpScreen.routeURL,
      builder: (context, state) => const SignUpScreen(),
    ),
    // 로그인
    GoRoute(
      name: LoginScreen.routeName,
      path: LoginScreen.routeURL,
      builder: (context, state) => const LoginScreen(),
    ),
    // 튜토리얼
    GoRoute(
      name: InterestsScreen.routeName,
      path: InterestsScreen.routeURL,
      builder: (context, state) => const InterestsScreen(),
    ),
    // 메인
    GoRoute(
      name: MainNavigationScreen.routeName,
      path: MainNavigationScreen.routeURL, // home|discover|inbox|profile
      builder: (context, state) {
        final tab = state.params["tab"]!;
        return MainNavigationScreen(
          tab: tab,
        );
      },
    ),
    // Inbox > Activity
    GoRoute(
      name: ActivityScreen.routeName,
      path: ActivityScreen.routeURL,
      builder: (context, state) => const ActivityScreen(),
    ),
    // Inbox > Chats
    GoRoute(
      name: ChatsScreen.routeName,
      path: ChatsScreen.routeURL,
      builder: (context, state) => const ChatsScreen(),
      routes: [
        GoRoute(
          name: ChatDetailScreen.routeName,
          path: ChatDetailScreen.routeURL,
          builder: (context, state) {
            final chatId = state.params["chatId"]!;
            return ChatDetailScreen(
              chatId: chatId,
            );
          },
        ),
      ],
    ),
    // Post Video
    GoRoute(
      name: VideoRecordingScreen.routeName,
      path: VideoRecordingScreen.routeURL,
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const VideoRecordingScreen(),
        transitionDuration: const Duration(milliseconds: 200),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final position = Tween(begin: const Offset(0, 1), end: Offset.zero)
              .animate(animation);
          return SlideTransition(
            position: position, // 밑에서부터 슬라이드하여 올라오는 애니메이션
            child: child,
          );
        },
      ),
    ),
  ],
);
