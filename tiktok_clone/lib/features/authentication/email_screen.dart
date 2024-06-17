// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/password_screen.dart';
import 'package:tiktok_clone/features/authentication/view_models/signup_view_model.dart';

import 'widgets/form_button.dart';

// 17.4 pushNamed Args 변수를 받기 위한 클래스 생성
class EmailScreenArgs {
  final String username;

  EmailScreenArgs({required this.username});
}

class EmailScreen extends ConsumerStatefulWidget {
  final String username;

  const EmailScreen({super.key, required this.username});

  @override
  EmailScreenState createState() => EmailScreenState();
}

class EmailScreenState extends ConsumerState<EmailScreen> {
  final TextEditingController _emailController =
      TextEditingController(text: "ynjch@gmail.com");

  String _email = "";

  @override
  void initState() {
    super.initState();

    // Textfield 의 텍스트 변화를 감지하기 위함
    _emailController.addListener(() {
      setState(() {
        _email = _emailController.text;
      });
    });
  }

  @override
  void dispose() {
    // _emailController 와 연관된 이벤트 리스너를 모두 지움
    _emailController.dispose();

    super.dispose();
  }

  // 이메일이 유효한지 판단
  String? _isEmailValid() {
    if (_email.isEmpty) return null;

    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(_email)) return "Email not valid";
    return null;
  }

  /**focus 된 것을 모두 unfocus 시키기
   * - 입력 필드가 아닌 아무 공간이나 탭할 경우, 키보드가 사라지도록 해야함
   */
  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSubmit() {
    if (_email.isEmpty || _isEmailValid() != null) return;
    // StateProvider signUpForm > state > 기존 state 에 email 값 전달
    final state = ref.read(signUpForm.notifier).state;
    ref.read(signUpForm.notifier).state = {...state, "email": _email};
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PasswordScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 17.4 pushNamed Args 변수를 사용하기 위해 ModalRoute as EmailScreenArgs 사용
    // final args = ModalRoute.of(context)!.settings.arguments as EmailScreenArgs;

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
              Text(
                "What is your Email, ${widget.username}?",
                style: const TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v16,
              // 여러 개의 input 유효성 검사하기에 적합한 위젯은 아님
              TextField(
                // 위젯을 컨트롤하기 위해 Controller 추가
                controller: _emailController,
                /**키보드의 Done 클릭 시에도 _onSubmit 이 작동해야 함
                 * 1. onSubmitted 속성 : value 입력값을 제공
                 * 2. onEditingComplete 속성 : 매개변수 없이 실행
                 */
                onSubmitted: (value) => _onSubmit,
                keyboardType: TextInputType.emailAddress, // 키보드 타입 지정
                autocorrect: false, // 자동완성 끄기
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                  hintText: "Email",
                  errorText: _isEmailValid(), // 에러 메시지 동적 처리
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
              Gaps.v28,
              GestureDetector(
                onTap: _onSubmit,
                child: FormButton(
                  disabled: _email.isEmpty || _isEmailValid() != null,
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
