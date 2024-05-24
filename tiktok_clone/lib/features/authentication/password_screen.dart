// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/birthday_screen.dart';

import 'widgets/form_button.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _passwordController =
      TextEditingController(text: "abcd1234");

  String _password = "";
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();

    // Textfield 의 텍스트 변화를 감지하기 위함
    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
  }

  @override
  void dispose() {
    // _passwordController 와 연관된 이벤트 리스너를 모두 지움
    _passwordController.dispose();

    super.dispose();
  }

  // 이메일이 유효한지 판단
  bool _isPasswordValid() {
    if (_password.isNotEmpty &&
        _password.length >= 8 &&
        _password.length <= 20) {
      final regExp = RegExp(
          r"^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[@$!%*#?&\^])[A-Za-z0-9@$!%*#?&\^]{8,20}$");
      if (!regExp.hasMatch(_password)) {
        return true;
      }
    }
    return false;
  }

  /**focus 된 것을 모두 unfocus 시키기
   * - 입력 필드가 아닌 아무 공간이나 탭할 경우, 키보드가 사라지도록 해야함
   */
  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSubmit() {
    if (!_isPasswordValid()) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const BirthdayScreen(),
      ),
    );
  }

  void _onClearTap() {
    _passwordController.clear();
  }

  void _toggleObscureText() {
    _obscureText = !_obscureText;
    setState(() {}); // 이렇게 작성해도 값이 업데이트 됨
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Sign up"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v20,
              const Text(
                "Password",
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v16,
              // 여러 개의 input 유효성 검사하기에 적합한 위젯은 아님
              TextField(
                // 위젯을 컨트롤하기 위해 Controller 추가
                controller: _passwordController,
                /**키보드의 Done 클릭 시에도 _onSubmit 이 작동해야 함
                 * 1. onSubmitted 속성 : value 입력값을 제공
                 * 2. onEditingComplete 속성 : 매개변수 없이 실행
                 */
                onSubmitted: (value) => _onSubmit,
                obscureText: _obscureText, // 키보드 타입 지정 => password
                autocorrect: false, // 자동완성 끄기
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                  suffix: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: _onClearTap,
                        child: FaIcon(
                          FontAwesomeIcons.xmark,
                          color: Colors.grey.shade500,
                          size: Sizes.size20,
                        ),
                      ),
                      Gaps.h10,
                      GestureDetector(
                        onTap: _toggleObscureText,
                        child: FaIcon(
                          _obscureText
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          color: Colors.grey.shade500,
                          size: Sizes.size20,
                        ),
                      ),
                    ],
                  ),
                  hintText: "Make it strong",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                ),
              ),
              Gaps.v14,
              const Text(
                "Your password must have:",
                style: TextStyle(
                    fontSize: Sizes.size12, fontWeight: FontWeight.w600),
              ),
              Gaps.v10,
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.circleCheck,
                    size: Sizes.size20,
                    color: _isPasswordValid()
                        ? Colors.green
                        : Colors.grey.shade400,
                  ),
                  Gaps.h5,
                  const Text(
                    "8 to 20 characters",
                    style: TextStyle(fontSize: Sizes.size12),
                  ),
                ],
              ),
              Gaps.v28,
              GestureDetector(
                onTap: _onSubmit,
                child: FormButton(
                  disabled: !_isPasswordValid(),
                  label: "Next",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
