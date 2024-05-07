// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /** MaterialApp
     *  - Widget 을 입력하고, 마우스를 갖다대어 필요한 타입을 확인
     *  Column
     *  - 수직 배열을 위함
     *  - Center 는 child 를 가지지만, Column 은 children 이라는 List 를 가짐
     *  - Rows 를 추가할 수 있음 (수평 배열을 위함)
     */
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Color(
              0xFF181818), // Color(0xFF) 를 적고 컬러 코드를 기재 or Color.fromARGB 사용하여 RGB 값 기재
          body: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 20,
            ),
            child: Column(
              // Column 의 mainAxisAlignment : 수직 방향 / CrossAxisAlignment : 수평 방향
              children: [
                SizedBox(
                  // 너무 상단부터 배치되고 있어서 size 가 있는 box 를 추가함
                  height: 50,
                ),
                Row(
                  // Row 의 mainAxisAlignment : 수평 방향 / CrossAxisAlignment : 수직 방향
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Hey, Selena',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          'Welcome back',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
