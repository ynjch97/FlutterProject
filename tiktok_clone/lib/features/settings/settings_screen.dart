// ignore_for_file: slash_for_doc_comments

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  /**CloseButton() : 이 코드만으로도 닫기 버튼을 만들 수 있음 
   * CupertinoActivityIndicator(), CircularProgressIndicator() : 로딩 중임을 표시
   * CircularProgressIndicator.adaptive() : 안드로이드, iOS 환경에 맞는 아이콘으로 표시함
   * ListWheelScrollView : 휠 모양의 ScrollView 사용 가능
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
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
          const AboutListTile(), // showAboutDialog 를 자동으로 생성
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
              print(date);
              if (!context.mounted) return;
              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              print(time);
              if (!context.mounted) return;
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
              print(booking);
            },
            title: const Text("What is your birthday?"),
          )
        ],
      ),
    );
  }
}
