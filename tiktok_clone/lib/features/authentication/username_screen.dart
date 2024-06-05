// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/routes.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/email_screen.dart';

import 'widgets/form_button.dart';

class UsernameScreen extends StatefulWidget {
  static String routeURL = Routes.usernameScreen;
  static String routeName = RoutesName.usernameScreen;

  const UsernameScreen({super.key});

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  final TextEditingController _usernameController =
      TextEditingController(text: "YNJCH");

  String _username = "";

  @override
  void initState() {
    super.initState();

    // Textfield 의 텍스트 변화를 감지하기 위함
    _usernameController.addListener(() {
      setState(() {
        _username = _usernameController.text;
      });
    });
  }

  @override
  void dispose() {
    // _usernameController 와 연관된 이벤트 리스너를 모두 지움
    _usernameController.dispose();

    super.dispose();
  }

  /**StatelessWidget > _on*Tap(BuildContext context) 함수들과 다르게 context 를 받지 않아도 됨
   * StatefulWidget > State 안에 있다면 어디서든 context 사용 가능
   */
  void _onNextTap() {
    if (_username.isEmpty) return;

    // 17.4 pushNamed Args 변수 실어보내기 => 클래스 생성하여 변수로 사용
    /*Navigator.pushNamed(
      context,
      EmailScreen.routeURL,
      arguments: EmailScreenArgs(username: _username),
    );
    */

    // 18.3 Extra Parameter -> URL 에 담지 않고 데이터를 전달할 수 있음
    context.pushNamed(
      EmailScreen.routeName,
      extra: EmailScreenArgs(username: _username),
    );
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
              "Create Username",
              style: TextStyle(
                fontSize: Sizes.size24,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gaps.v8,
            const Text(
              "You can always change this later.",
              style: TextStyle(
                fontSize: Sizes.size16,
                fontWeight: FontWeight.w400,
                color: Colors.black45,
              ),
            ),
            Gaps.v16,
            TextField(
              // 위젯을 컨트롤하기 위해 Controller 추가
              controller: _usernameController,
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                hintText: "Username",
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
                disabled: _username.isEmpty,
                label: "Next",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
