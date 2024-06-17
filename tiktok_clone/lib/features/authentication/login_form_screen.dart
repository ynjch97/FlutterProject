// ignore_for_file: slash_for_doc_comments
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/view_models/login_view_model.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';

/**Form
 * - 고유 식별자 역할을 하는 Global Key 필요
 * - Form 의 State 에 접근 가능 / Method Trigger 실행 가능 
 * - Controller 를 이용해 추적할 필요가 없음
 */
class LoginFormScreen extends ConsumerStatefulWidget {
  const LoginFormScreen({super.key});

  @override
  LoginFormScreenState createState() => LoginFormScreenState();
}

class LoginFormScreenState extends ConsumerState<LoginFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> formData = {};

  void _onSubmitTap() {
    // _formKey.currentState?.validate();
    if (_formKey.currentState != null) {
      // 유효성 검사 수행 -> return bool
      if (_formKey.currentState!.validate()) {
        /**save()
         * - 모든 텍스트 입력에 onSaved 콜백 함수 실행
         */
        _formKey.currentState!.save();

        /**로그인이 완료되면 InterestsScreen 으로 이동
         * But, 뒤로가기를 눌러도 로그인 화면으로 다시 돌아오면 안됨
         */
        /*
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute( builder: (context) => const InterestsScreen(), ),
          (route) => false,
        );
        */
        // context.goNamed(VideoTimelineScreen.routeName);
        // VideoTimelineScreen 화면으로 이동 포함
        ref.read(loginProvider.notifier).login(
              formData["email"]!,
              formData["password"]!,
              context,
            );
      }
    }
  }

  String? _chkTextField(String? text) {
    if (text == null || text.isEmpty) return "Enter the value";
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log in"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: "ynjch6@gmail.com",
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                  hintText: "Email",
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 1.5,
                    ),
                  ),
                ),
                validator: _chkTextField,
                // newValue : 저장된 순간의 입력값
                onSaved: (newValue) {
                  if (newValue != null) formData['email'] = newValue;
                },
              ),
              Gaps.v16,
              TextFormField(
                initialValue: "abcd1234",
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                  hintText: "Password",
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 1.5,
                    ),
                  ),
                ),
                validator: _chkTextField,
                onSaved: (newValue) {
                  if (newValue != null) formData['password'] = newValue;
                },
              ),
              Gaps.v28,
              GestureDetector(
                onTap: _onSubmitTap,
                child: FormButton(
                  disabled: ref.watch(loginProvider).isLoading,
                  label: "Log in",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
