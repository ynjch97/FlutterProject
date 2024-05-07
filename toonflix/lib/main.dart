// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';

void main() { // main(): Dart 프로그래밍 언어에서 쓰는 함수
  /** void runApp(Widget app): material.dart 에서 가져온 void 함수
   *  Widget: Flutter 의 모든 것은 Widget 이며, Widget 을 합쳐 앱을 만듦
   *  Widget 을 만든다는 것은 class 를 만든다는 것
   */
  runApp(App());
}

/** App(): 앱의 root Widget 역할
 *  - class 를 Widget 으로 만들기 위해서는, flutter SDK 에 있는 3개의 core Widget 중 하나를 상속(extends) 받아야 함
 *  - 앱의 root Widget 은 두 가지 옵션 중 하나를 return 해야 함 (buid() 에서)
 *  - 1. material (구글의 디자인 시스템) / 2. cupertino (애플의 디자인 시스템)
 */
class App extends StatelessWidget {
  /** buid()
   *  - return 하려는 Widget 을 화면에 보여줌
   *  - BuildContext 타입의 context 라는 parameter 를 받아옴
   */
  @override
  Widget build(BuildContext context) {
    /** MaterialApp
     *  - Widget? home : MaterialApp class 의 property 
     *  - 화면은 scaffold(화면의 구조를 제공해줌) 를 가져야 함
     */
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar( // navigation bar
            title: Text('Flutter Demo'),
            centerTitle: true,
            elevation: 100,
            backgroundColor: Color.fromARGB(255, 255, 123, 0),
          ),
          body: Center(
            child: Text('Hello World'),
          ),
      ),
    );
  }
}