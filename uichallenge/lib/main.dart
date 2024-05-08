// ignore_for_file: slash_for_doc_comments

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uichallenge/widgets/button.dart';
import 'package:uichallenge/widgets/currency_card.dart';

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
          body: SingleChildScrollView(
            child: Padding(
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
                    height: 90,
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
                    height: 90,
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
                  const CurrencyCard(
                    name: 'Euro',
                    code: 'EUR',
                    amount: '6 428',
                    icon: Icons.euro_symbol_sharp,
                    isInverted: false,
                  ),
                  Transform.translate(
                    // 카드가 겹쳐보이도록 Transform.translate > Offset 활용
                    offset: const Offset(0, -25),
                    child: const CurrencyCard(
                      name: 'Dollar',
                      code: 'USD',
                      amount: '55 622',
                      icon: Icons.attach_money_sharp,
                      isInverted: true,
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(0, -50),
                    child: const CurrencyCard(
                      name: 'Bitcoin',
                      code: 'BTC',
                      amount: '9 875',
                      icon: Icons.currency_bitcoin_outlined,
                      isInverted: false,
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
