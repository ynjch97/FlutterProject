// ignore_for_file: slash_for_doc_comments

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';

/**ConsumerWidget, ConsumerStatefulWidget
 * - Riverpod 에서 오는 위젯
 * - WidgetRef ref : Provide 를 가져오고, 읽을 수 있는 레퍼런스
 *   - ref.watch : 변화를 listen 하기 위함
 *   - ref.read : 한 번 읽는 것
 */
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  /**CloseButton() : 이 코드만으로도 닫기 버튼을 만들 수 있음 
   * CupertinoActivityIndicator(), CircularProgressIndicator() : 로딩 중임을 표시
   * CircularProgressIndicator.adaptive() : Android, iOS 환경에 맞는 아이콘으로 표시함
   * ListWheelScrollView : 휠 모양의 ScrollView 사용 가능
  */

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          // CupertinoSwitch(iOS), Switch(Android) 환경에 맞는 아이콘으로 표시함
          // SharedPreferences 음소거 정보 (Riverpod + WidgetRef)
          SwitchListTile.adaptive(
            value: ref.watch(playbackConfigProvider).muted,
            onChanged: (value) =>
                ref.read(playbackConfigProvider.notifier).setMuted(value),
            title: const Text("Mute video"),
            subtitle: const Text("Videos will be muted by default."),
          ),
          // SharedPreferences 자동재생 정보 (Riverpod + WidgetRef)
          SwitchListTile.adaptive(
            value: ref.watch(playbackConfigProvider).autoplay,
            onChanged: (value) =>
                ref.read(playbackConfigProvider.notifier).setAutoplay(value),
            title: const Text("Autoplay"),
            subtitle: const Text("Video will start playing automatically."),
          ),
          ListTile(
            /**app 정보 표시를 위한 팝업
             * View licenses : 현재 앱에서 사용 중인 모든 오픈소스 소프트웨어 관련 내용 포함
             */
            onTap: () => showAboutDialog(
              context: context,
              applicationVersion: "1.0",
              applicationLegalese: "All rights reseverd. Please dont copy me.",
            ),
            title: const Text(
              "About",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: const Text("About this app....."),
          ),
          const AboutListTile(
            applicationVersion: "1.0",
            applicationLegalese: "Don't copy me.",
          ), // showAboutDialog 를 자동으로 생성
          // 날짜 선택 기능 추가
          ListTile(
            onTap: () async {
              // showDatePicker, showTimePicker, showDateRangePicker : 아무것도 고르지 않으면 null 반환
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1980),
                lastDate: DateTime(2030),
              );
              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              final booking = await showDateRangePicker(
                context: context,
                firstDate: DateTime(1980),
                lastDate: DateTime(2030),
                builder: (context, child) {
                  return Theme(
                    data: ThemeData(
                        appBarTheme: const AppBarTheme(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.black)),
                    child: child!,
                  );
                },
              );
              // print(date);
              // print(time);
              // print(booking);
            },
            title: const Text("What is your birthday?"),
            subtitle: const Text("I need to know!"),
          ),
          CheckboxListTile(
            activeColor: Theme.of(context).primaryColor,
            checkColor: Colors.black,
            value: false,
            onChanged: (value) {},
            title: const Text("Marketing emails"),
            subtitle: const Text("We won't spam you."),
          ),
          ListTile(
            title: const Text("Log out (iOS)"),
            subtitle: const Text("showCupertinoDialog 는 팝업 바깥을 눌러 팝업을 끌 수 없음"),
            textColor: Colors.red,
            onTap: () {
              showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: const Text("Are you sure?"),
                  content: const Text("Plx dont go"),
                  actions: [
                    CupertinoDialogAction(
                      // pop-up 을 제거하려면 Navigator pop
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("No"),
                    ),
                    CupertinoDialogAction(
                      // 로그아웃 처리 및 홈으로 돌아가기
                      onPressed: () {
                        ref.read(authRepo).signOut();
                        context.goNamed(SignUpScreen.routeName);
                      },
                      isDestructiveAction: true,
                      child: const Text("Yes"),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Log out (Android)"),
            textColor: Colors.red,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  icon: const FaIcon(FontAwesomeIcons.skull),
                  title: const Text("Are you sure?"),
                  content: const Text("Plx dont go"),
                  actions: [
                    // 원하는 아무 Widget 렌더링 가능
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const FaIcon(FontAwesomeIcons.car),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Yes"),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Log out (iOS / Bottom)"),
            subtitle:
                const Text("showCupertinoModalPopup 은 팝업 바깥을 눌러 팝업을 끌 수 있음"),
            textColor: Colors.red,
            onTap: () {
              showCupertinoModalPopup(
                context: context,
                builder: (context) => CupertinoActionSheet(
                  title: const Text("Are you sure?"),
                  actions: [
                    CupertinoActionSheetAction(
                      isDefaultAction: true,
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Not Log Out"),
                    ),
                    CupertinoActionSheetAction(
                      isDestructiveAction: true,
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Yes"),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
