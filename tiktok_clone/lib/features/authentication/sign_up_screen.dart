// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/routes.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/authentication/view_models/social_auth_view_model.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';

class SignUpScreen extends ConsumerWidget {
  static const routeURL = Routes.signUpScreen;
  static const routeName = RoutesName.signUpScreen;

  const SignUpScreen({super.key});

  // 메서드, 프로퍼티 앞에 _ 를 붙여 private type 으로 선언
  void _onLoginTap(BuildContext context) async {
    /**17.1 push 는 Future 이므로 await 할 수 있음
     * - pop()으로 돌아올 때 LoginScreen 에서 지정한 문구를 가져옴 => result
     * 17.3 route push 대신 pushNamed 방법 이용
     */
    // final result = await Navigator.pushNamed(context, LoginScreen.routeURL);

    // 18.0 pushNamed 대신 context.push() 사용 (go_router 패키지가 context 를 확장시킴)
    // context.push(LoginScreen.routeURL);

    context.pushNamed(LoginScreen.routeName);
  }

  void _onEmailTap(BuildContext context) {
    /*
    Navigator.of(context).push(
      // 17.2 MaterialPageRoute 대신, PageRouteBuilder 로 애니메이션 효과를 추가
      PageRouteBuilder(
        // 화면 전환 및 다시 원래대로 돌아올 때 전환 시간
        transitionDuration: const Duration(milliseconds: 300),
        reverseTransitionDuration: const Duration(milliseconds: 300),
        // child : pageBuilder 가 리턴하는 것
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // 두 개 state 사이의 애니메이션 Tween Animation
          final offsetAnimation =
              Tween(begin: const Offset(0, -1), end: Offset.zero)
                  .animate(animation);
          return SlideTransition(
            position: offsetAnimation, // 커스터마이징
            child: FadeTransition(
              opacity: animation, // 기본 파라미터 값
              child: child,
            ),
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) =>
            const UsernameScreen(),
      ),
    );
    */

    // 18.4 GoRoute > name 으로 pushNamed
    // context.pushNamed(UsernameScreen.routeName);

    // 20.2 URL이 바뀌지 않는 방법으로 변경
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UsernameScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OrientationBuilder(
      builder: (context, orientation) {
        // print(orientation); => Orientation.portrait or Orientation.landscape
        return Scaffold(
          /**SafeArea
           * - 그 안에 있는 모든 것은 특정 공간에 있을 것이라고 보장
           * - 상태바 아래로 내려올 수 있게 해줌
           */
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Gaps.v80,
                  const Text(
                    "Sign up for TicTok",
                    style: TextStyle(
                      fontSize: Sizes.size24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gaps.v20,
                  const Text(
                    "Create a profile, follow other accounts, make your own videos, and more.",
                    style: TextStyle(
                        fontSize: Sizes.size16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black45),
                    textAlign: TextAlign.center,
                  ),
                  Gaps.v40,
                  if (orientation == Orientation.portrait) ...[
                    AuthButton(
                      text: 'Use email & password',
                      icon: const FaIcon(FontAwesomeIcons.user),
                      // onTapFunction: (context) => _onEmailTap(context),
                      onTapFunction: _onEmailTap,
                    ),
                    Gaps.v16,
                    AuthButton(
                      text: 'Continue with Github',
                      icon: const FaIcon(FontAwesomeIcons.github),
                      onTapFunction: (context) {
                        // 깃허브 로그인
                        ref
                            .read(socialAuthProvider.notifier)
                            .githubSignIn(context);
                      },
                    ),
                  ],
                  if (orientation == Orientation.landscape)
                    Row(
                      children: [
                        Expanded(
                          child: AuthButton(
                            text: 'Use email & password',
                            icon: const FaIcon(FontAwesomeIcons.user),
                            // onTapFunction: (context) => _onEmailTap(context),
                            onTapFunction: _onEmailTap,
                          ),
                        ),
                        Gaps.h16,
                        Expanded(
                          child: AuthButton(
                            text: 'Continue with Github',
                            icon: const FaIcon(FontAwesomeIcons.github),
                            onTapFunction: (context) {
                              // 깃허브 로그인
                              ref
                                  .read(socialAuthProvider.notifier)
                                  .githubSignIn(context);
                            },
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          /**bottomNavigationBar
         * - 하단 영역을 고정하여 보여줌
         */
          bottomNavigationBar: BottomAppBar(
            color: Colors.grey.shade50,
            elevation: 2,
            padding: const EdgeInsets.only(bottom: 10),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: Sizes.size20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  Gaps.h5,
                  GestureDetector(
                    onTap: () => _onLoginTap(context),
                    child: Text(
                      "Log in",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
