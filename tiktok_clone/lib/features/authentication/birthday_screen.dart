// ignore_for_file: slash_for_doc_comments
// Cupertino : Apple 의 디자인 가이드를 따라 만든 위젯

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/view_models/signup_view_model.dart';
import 'widgets/form_button.dart';

class BirthdayScreen extends ConsumerStatefulWidget {
  const BirthdayScreen({super.key});

  @override
  BirthdayScreenState createState() => BirthdayScreenState();
}

class BirthdayScreenState extends ConsumerState<BirthdayScreen> {
  final TextEditingController _birthdayController = TextEditingController();

  // format : 2024-05-24 01:45:31.204298
  DateTime initailDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    initailDate = DateTime(initailDate.year - 12);
    _setTextFieldDate(initailDate); // 초기값 세팅
  }

  @override
  void dispose() {
    // _birthdayController 와 연관된 이벤트 리스너를 모두 지움
    _birthdayController.dispose();

    super.dispose();
  }

  /**StatelessWidget > _on*Tap(BuildContext context) 함수들과 다르게 context 를 받지 않아도 됨
   * StatefulWidget > State 안에 있다면 어디서든 context 사용 가능
   */
  void _onNextTap() {
    // StateProvider signUpForm > state > 기존 state 에 email 값 전달
    final state = ref.read(signUpForm.notifier).state;
    ref.read(signUpForm.notifier).state = {...state, "birthday": _birthdayController.text};
    
    /**20.2 GoRoute 방식으로 변경 (context 확장)
     * - pushReplacementNamed : push 는 되지만 뒤로가기가 되지 않음
     *   - goNamed 와 동일하게 작동함
     */
    // context.pushReplacementNamed(InterestsScreen.routeName);
    // InterestsScreen 화면으로 이동 포함
    ref.read(signUpProvider.notifier).signUp(context);
  }

  void _setTextFieldDate(DateTime date) {
    final textDate = date.toString().split(" ").first;
    _birthdayController.value = TextEditingValue(text: textDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              "When's your birthday?",
              style: TextStyle(
                fontSize: Sizes.size24,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gaps.v8,
            const Text(
              "Your birthday won't be shown publicly.",
              style: TextStyle(
                fontSize: Sizes.size16,
                fontWeight: FontWeight.w400,
                color: Colors.black45,
              ),
            ),
            Gaps.v16,
            TextField(
              readOnly: true,
              controller: _birthdayController,
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
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
              onTap: _onNextTap,
              child: FormButton(
                disabled: ref.watch(signUpProvider).isLoading,
                label: "Next",
              ), // 항상 활성화
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 300,
        child: SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            onDateTimeChanged: _setTextFieldDate,
            mode: CupertinoDatePickerMode.date,
            maximumDate: initailDate,
            initialDateTime: initailDate,
          ),
        ),
      ),
    );
  }
}
