// ignore_for_file: slash_for_doc_comments

import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/routes.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';

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
  routes: [
    GoRoute(
      name: SignUpScreen.routeName,
      path: SignUpScreen.routeURL,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      name: LoginScreen.routeName,
      path: LoginScreen.routeURL,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: InterestsScreen.routeName,
      path: InterestsScreen.routeURL,
      builder: (context, state) => const InterestsScreen(),
    ),
  ],
);
