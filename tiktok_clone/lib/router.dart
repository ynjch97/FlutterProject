// ignore_for_file: slash_for_doc_comments

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/common/widgets/main_navigation/main_navigation_screen.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/features/inbox/activity_screen.dart';
import 'package:tiktok_clone/features/inbox/chat_detail_screen.dart';
import 'package:tiktok_clone/features/inbox/chats_screen.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';
import 'package:tiktok_clone/features/videos/views/video_recording_screen.dart';

/**#23 FIREBASE SETUP
 * => 기존 개발 내용을 Provider 로 감싸서 사용 (백업 : router_backup2.dart)
 * => ref.watch, ref.read 로 다른 Provider 에 접근할 수 있게 됨
 */
final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: "/inbox", // 시작 화면 설정
    redirect: (context, state) {
      final isLoggedIn = ref.read(authRepo).isLoggedIn;
      if (!isLoggedIn) {
        if (state.subloc != SignUpScreen.routeURL &&
            state.subloc != LoginScreen.routeURL) {
          // 회원가입, 로그인 페이지 제외 접근 불가하도록
          return SignUpScreen.routeURL;
        }
      }
      return null;
    },
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
});
