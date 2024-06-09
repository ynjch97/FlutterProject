// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/routes.dart';
import 'package:tiktok_clone/features/authentication/email_screen.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/users/user_profile_screen.dart';

/**18.0 NAVIGATOR 2 
 * - NAVIGATOR 1 버전(Navigator.pushNamed)은 브라우저에서 사용 시, 앞으로 가기 버튼을 지원하지 않으므로 비추천..
 * - NAVIGATOR 2  => /video/1 과 같이 파라미터도 사용할 수 있도록 새로운 방법 사용
 *   - go_router: 6.0.2 다운로드
 *   - main.dart -> MaterialApp.router 사용
 */
final routerBackup = GoRouter(
  routes: [
    GoRoute(
      name: SignUpScreen.routeName,
      path: SignUpScreen.routeURL,
      builder: (context, state) => const SignUpScreen(),
      // 18.4 route 중첩시키기 (URL 경로도 / 제거하여 세팅)
      routes: [
        GoRoute(
          name: RoutesName.usernameScreen,
          path: Routes.usernameScreen,
          /**18.4 CustomTransitionPage
           * - 애니메이션 효과 추가
           */
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const UsernameScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: animation,
                    child: child,
                  ),
                );
              },
            );
          },
          routes: [
            GoRoute(
              name: RoutesName.emailScreen,
              path: Routes.emailScreen,
              builder: (context, state) {
                final args = state.extra as EmailScreenArgs;
                return EmailScreen(
                  username: args.username,
                );
              },
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      name: LoginScreen.routeName,
      path: LoginScreen.routeURL,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: "/users/:username", // parameter 를 받아옴
      builder: (context, state) {
        final username = state.params['username'];
        final tab = state.queryParams["show"];
        return UserProfileScreen(username: username!, tab: tab!);
      },
    )
  ],
);
