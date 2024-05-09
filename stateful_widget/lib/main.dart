import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

// Stateless Widget 그 자체
class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

// State : Widget 에 들어갈 데이터와 UI 를 저장
class _AppState extends State<App> {
  int counter = 0;
  bool showSmallTitle = true;
  IconData showIcon = Icons.toggle_on_outlined;

  // IconButton > onPressed
  void onClicked() {
    // setState : State 클래스에게 데이터가 변경되었다고 알리는 함수
    // State 에게 새로운 데이터가 있음을 알리고 스스로 새로고침하게 함
    setState(() {
      // 호출 시마다 build() 메소드가 재실행 됨
      counter += 1;
    });
  }

  // IconButton > onPressed > 큰 타이틀 노출 토글
  void toggleTitle() {
    setState(() {
      showSmallTitle = !showSmallTitle;
      showIcon =
          showSmallTitle ? Icons.toggle_on_outlined : Icons.toggle_off_outlined;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          textTheme: const TextTheme(
            titleLarge: TextStyle(color: Colors.red),
            titleSmall: TextStyle(color: Colors.lightGreen),
          ),
        ),
        home: Scaffold(
          backgroundColor: const Color(0xFFF4EDDB),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Click Count',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                Text(
                  '$counter',
                  style: const TextStyle(
                    fontSize: 35,
                  ),
                ),
                IconButton(
                  onPressed: onClicked, // 클릭할 때마다 실행될 함수를 할당
                  iconSize: 40,
                  icon: const Icon(
                    Icons.add_circle_sharp,
                  ),
                ),
                const MyLargeTitle(),
                showSmallTitle ? const MySmallTitle() : const Text(''),
                IconButton(
                  onPressed: toggleTitle,
                  iconSize: 40,
                  icon: Icon(showIcon),
                ),
              ],
            ),
          ),
        ));
  }
}

// MyLargeTitle = StatelessWidget
class MyLargeTitle extends StatelessWidget {
  const MyLargeTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'My Large Title',
      style: TextStyle(
        fontSize: 30,
        color: Theme.of(context).textTheme.titleLarge?.color,
        // 부모 요소에서 context 의 Theme 를 가져옴
        /** the property 'color' can't be unconditionally accessed because the receiver can be 'null'. 
         *  - titleLarge, color 는 명확히 존재한다고 알려줌 -> titleLarge!.color 
         *  - 아마 존재할 것이다 -> titleLarge?.color
         * */
      ),
    );
  }
}

// MySmallTitle = StatefulWidget
class MySmallTitle extends StatefulWidget {
  const MySmallTitle({
    super.key,
  });

  @override
  State<MySmallTitle> createState() => _MySmallTitleState();
}

class _MySmallTitleState extends State<MySmallTitle> {
  @override
  void initState() {
    super.initState();
    print('initState-!'); // MySmallTitle 영역이 생성되면 print 됨
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose-!'); // MySmallTitle 영역이 사라지면 print 됨
  }

  @override
  Widget build(BuildContext context) {
    print('build-!');
    return Text(
      'My Small Title',
      style: TextStyle(
        fontSize: 15,
        color: Theme.of(context).textTheme.titleSmall?.color,
        // 부모 요소에서 context 의 Theme 를 가져옴
        /** the property 'color' can't be unconditionally accessed because the receiver can be 'null'. 
         *  - titleLarge, color 는 명확히 존재한다고 알려줌 -> titleLarge!.color 
         *  - 아마 존재할 것이다 -> titleLarge?.color
         * */
      ),
    );
  }
}
