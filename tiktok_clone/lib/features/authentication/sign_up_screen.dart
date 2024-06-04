// ignore_for_file: slash_for_doc_comments

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  // 메서드, 프로퍼티 앞에 _ 를 붙여 private type 으로 선언
  void _onLoginTap(BuildContext context) async {
    // 17.1 push 는 Future 이므로 await 할 수 있음
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );

    print(result); // pop()으로 돌아올 때 LoginScreen 에서 지정한 문구(result)가 출력됨
  }

  void _onEmailTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const UsernameScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                      text: 'Continue with Google',
                      icon: const FaIcon(FontAwesomeIcons.google),
                      onTapFunction: (context) {},
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
                            text: 'Continue with Google',
                            icon: const FaIcon(FontAwesomeIcons.google),
                            onTapFunction: (context) {},
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
