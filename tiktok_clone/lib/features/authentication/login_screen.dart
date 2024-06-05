// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/routes.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/login_form_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';

class LoginScreen extends StatelessWidget {
  static const routeURL = Routes.loginScreen;
  static const routeName = RoutesName.loginScreen;

  const LoginScreen({super.key});

  /**Navigator.push : 화면을 기존 화면 위에 쌓음
   * Navigator.pop : Navigator 가장 상단의 화면 즉, 유저가 현재 보고있는 화면을 stack 에서 제거
   */
  void _onSignUpTap(BuildContext context) {
    context.pop(); // 18.0 context.pop() 사용 (go_router 패키지가 context 를 확장시킴)
  }

  void _onEmailLoginTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginFormScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Gaps.v80,
              const Text(
                "Log in to TicTok",
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v20,
              const Text(
                "Manage your account, check notifications, comment on videos, and more.",
                style: TextStyle(
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black45),
                textAlign: TextAlign.center,
              ),
              Gaps.v40,
              GestureDetector(
                child: AuthButton(
                  text: 'Use email & password',
                  icon: const FaIcon(FontAwesomeIcons.user),
                  onTapFunction: _onEmailLoginTap,
                ),
              ),
              Gaps.v16,
              AuthButton(
                text: 'Continue with Apple',
                icon: const FaIcon(FontAwesomeIcons.apple),
                onTapFunction: (context) {},
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey.shade50,
        elevation: 2,
        padding: const EdgeInsets.only(bottom: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Sizes.size20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account?"),
              Gaps.h5,
              GestureDetector(
                onTap: () => _onSignUpTap(context),
                child: Text(
                  "Sign up",
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
  }
}
