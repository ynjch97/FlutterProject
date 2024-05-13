// ignore_for_file: slash_for_doc_comments, constant_identifier_names

import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

/**Flexible : 하드 코딩되는 값을 만들게 해줌 -> 정해진 픽셀 값이 아니라 비율에 기반해 유연하게 UI 를 만듦
 * - flex : 비율 지정 (px 값이 아님)
 */
class _HomeScreenState extends State<HomeScreen> {
  /**Timer
   * - Dart 의 표준 라이브러리
   * - 정해진 간격에 한 번씩 함수 실행 가능
   * - periodic > 정해진 주기마다 내부의 함수 실행
   * - 미리 초기화 하지 않고 사용자가 버튼을 누를 때만 타이머가 생성되게 함
   * - late variable modifier 사용하는 것이 적합
  */
  late Timer timer;

  static const int SETTING_SECONDS = 60;
  bool isRunning = false; // 현재 작동 여부
  int totalSeconds = SETTING_SECONDS; // 타이머용 총 소요시간 (초)
  int totalPomodoros = 0; // 총 Pomodoro 카운트

  // 타이머가 바뀔 때마다 (= 1초마다) setState 를 실행함
  void onTick(Timer timer) {
    // 초를 다 세면, Pause 및 Restart + totalSeconds 초기화
    if (totalSeconds == 0) {
      setState(() {
        totalPomodoros = totalPomodoros + 1;
        isRunning = false;
        totalSeconds = SETTING_SECONDS;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  void onStartPressed() {
    // (timer) 사용 함수 : 매 초마다 몇 초 째인지 print 할 수 있음
    // timer = Timer.periodic(
    //   const Duration(seconds: 1),
    //   (timer) {
    //     print('timer.tick');
    //   },
    // );

    // onTick() : 괄호를 쓰면 지금 바로 실행한다는 의미 -> 괄호를 지움
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick, // The argument type 'void Function()' can't be assigned to the parameter type 'void Function(Timer)' : Timer 를 인자로 넣어주면 됨
    );

    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onStopPressed() {
    timer.cancel();
    setState(() {
      totalSeconds = SETTING_SECONDS;
      isRunning = false;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split('.').first.substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).backgroundColor,
      /**'backgroundColor' is deprecated and shouldn't be used. ~ 오류
       * - 버전 이슈 > 플러터 버전 다운그레이드 or 다음과 같이 코드 수정
       */
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              // decoration: const BoxDecoration(color: Colors.amber),
              alignment: Alignment.bottomCenter,
              child: Text(
                // '$totalSeconds',
                // 포맷하여 보내기 위함
                format(totalSeconds),
                style: TextStyle(
                  color: Theme.of(context).cardColor, // 지정해놓은 cardColor 를 계속 사용
                  fontSize: 89,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: isRunning ? onPausePressed : onStartPressed,
                  color: Theme.of(context).cardColor,
                  iconSize: 120,
                  icon: Icon(isRunning
                      ? Icons.pause_circle_outline
                      : Icons.play_circle_outline),
                ),
                IconButton(
                  onPressed: onStopPressed,
                  color: Theme.of(context).cardColor,
                  iconSize: 80,
                  icon: const Icon(Icons.stop_circle_outlined),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                // Expanded 를 사용해 주어진 공간으로 모두 확장되게 함 (한 요소가 전체 공간을 차지)
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: const BorderRadiusDirectional.only(
                          topStart: Radius.circular(20),
                          topEnd: Radius.circular(20),
                        )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pomodoros',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).textTheme.displayLarge!.color,
                          ), // displayLarge 의 값이 can be null 이라 오류 발생 > displayLarge! 로 확실히 존재함을 표시
                        ),
                        Text(
                          '$totalPomodoros',
                          style: TextStyle(
                            fontSize: 58,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).textTheme.displayLarge!.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
