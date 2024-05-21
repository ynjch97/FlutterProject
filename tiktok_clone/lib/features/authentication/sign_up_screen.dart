// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  void onLoginTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /**SafeArea
       * - 그 안에 있는 모든 것은 특정 공간에 있을 것이라고 보장
       * - 상태바 아래로 내려올 수 있게 해줌
       */
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.size40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Gaps.v80,
              Text(
                "Sign up for TicTok",
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v20,
              Text(
                "Create a profile, follow other accounts, make your own videos, and more.",
                style: TextStyle(
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black45),
                textAlign: TextAlign.center,
              ),
              Gaps.v40,
              AuthButton(
                text: 'Use email & password',
                icon: FaIcon(FontAwesomeIcons.user),
              ),
              Gaps.v16,
              AuthButton(
                text: 'Continue with Facebook',
                icon: FaIcon(FontAwesomeIcons.facebook),
              ),
              Gaps.v16,
              AuthButton(
                text: 'Continue with Apple',
                icon: FaIcon(FontAwesomeIcons.apple),
              ),
              Gaps.v16,
              AuthButton(
                text: 'Continue with Google',
                icon: FaIcon(FontAwesomeIcons.google),
              ),
            ],
          ),
        ),
      ),
      /**bottomNavigationBar
       * - 하단 영역을 고정하여 보여줌
       */
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey.shade100,
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
                onTap: () => onLoginTap(context),
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
  }
}
