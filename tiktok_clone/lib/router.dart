// ignore_for_file: slash_for_doc_comments

import 'package:go_router/go_router.dart';
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
final router = GoRouter(
  routes: [
    GoRoute(
      path: SignUpScreen.routeName,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: LoginScreen.routeName,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: UsernameScreen.routeName,
      builder: (context, state) => const UsernameScreen(),
    ),
    GoRoute(
      path: EmailScreen.routeName,
      builder: (context, state) {
        final args = state.extra as EmailScreenArgs;
        return EmailScreen(
          username: args.username,
        );
      },
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
