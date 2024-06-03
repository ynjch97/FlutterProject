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
        body: ListWheelScrollView(
          diameterRatio: 2.0,
          offAxisFraction: 1.5,
          itemExtent: 200,
          children: [
            for (var x in [1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1])
              FractionallySizedBox(
                widthFactor: 1,
                child: Container(
                  color: Colors.teal,
                  alignment: Alignment.center,
                  child: const Text(
                    'Pick me',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
          ],
        ));
  }
}
