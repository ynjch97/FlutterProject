// ignore_for_file: slash_for_doc_comments

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uichallenge/widgets/button.dart';

// compile 전에 이미 value 를 알고 있는 변수
const taxAmount = 15;
const priceAmount = 30;

var finalPrice = taxAmount + priceAmount;

void main() {
  runApp(const App());
}

/** 파란 줄 오류 발생
 *  - Use 'const' with the constructor to improve performance.
 *  - constant constructor 는 const 를 쓰는 걸 추천한다
 *  - backgroundColor: const Color(0xFF181818) : const 로 만들어주는 것이 효과적, const 붙이면 밑줄 사라짐
 *  - SizedBox 도 const 를 붙일 수 있음
 */
class App extends StatelessWidget {
  const App({super.key});

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
          backgroundColor: const Color(
              0xFF181818), // Color(0xFF) 를 적고 컬러 코드를 기재 or Color.fromARGB 사용하여 RGB 값 기재
          body: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 20,
            ),
            child: Column(
              // Column 의 mainAxisAlignment : 수직 방향 / CrossAxisAlignment : 수평 방향
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
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
                        const Text(
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
                ),
                const SizedBox(
                  height: 120,
                ),
                Text(
                  'Total Balance',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 22,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  '\$5 195 582',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 44,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Row(
                  /** Container
                   *  - <div> 와 같은 Widget (child 를 가지는 단순한 box)
                   *  - 버튼 디자인 시 사용하게 됨
                  */
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // 두 버튼 사이 align 값
                  children: [
                    // Container 의 코드가 일부 색상 값 제외 유사하므로, 재사용 가능한 Button Widget 을 사용
                    /*
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2B33A),
                        borderRadius: BorderRadius.circular(45),
                      ),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                        child: Text(
                          'Transfer',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    */
                    Button(
                      text: 'Transfer',
                      bgColor: Color(0xFFF2B33A),
                      textColor: Colors.black,
                    ),
                    Button(
                      text: 'Request',
                      bgColor: Color(0xFF1F2123),
                      textColor: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Wallets',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'View All',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white.withOpacity(0.8),
                        // Opacity 는 컴파일 시 알 수 없는 값이라 const 위치 유의
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  // clipBehavior: overflow 된 아이템에 대해 어떻게 동작하게 할건지 알려주는 장치
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F2123),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Euro',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const Text(
                                  '6 428',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'EUR',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Transform.scale(
                          // 아이콘이 overflow 되도록 transform.scale Widget 추가 (scale 설정 필수)
                          scale: 2.2,
                          child: Transform.translate(
                            // 아이콘이 이동되도록 transform.translate Widget 추가 (offset 설정 필수)
                            offset: const Offset(-5, 12),
                            child: const Icon(
                              Icons.euro_symbol_sharp,
                              color: Colors.white,
                              size: 88,
                              // size 조절 : 카드 등 주변 요소까지 함께 커짐 -> transform : 해당 요소만 overflow 및 move
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
