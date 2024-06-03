// ignore_for_file: slash_for_doc_comments

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
        ],
      ),
    );
  }
}
