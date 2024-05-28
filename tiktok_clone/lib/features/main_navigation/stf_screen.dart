// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

/**StfScreen Widget 을 NavigationBar 각 탭마다 사용하고 있는 경우,
 * 각 state 를 혼동하게 됨
 * => 이때 key 파라미터를 사용하여, 서로 다른 Widget 인 것처럼 렌더링함
 * => StfScreen( key: GlobalKey(), )
 * 
 * body: screens.elementAt(_selectedIndex),
 * NavigationBar 선택 탭만을 보여주고, 선택되지 않은 이전 화면은 Flutter 가 없애게 됨
 * 선택된 화면만을 보여주도록 build
 * => Tab Navigation 은 있던 자리를 기억함
 */
class StfScreen extends StatefulWidget {
  final String text;

  const StfScreen({super.key, required this.text});

  @override
  State<StfScreen> createState() => _StfScreenState();
}

class _StfScreenState extends State<StfScreen> {
  int _clicks = 0;

  void _increase() {
    setState(() {
      _clicks++;
    });
  }

  @override
  void dispose() {
    // dispose 되었는지 확인할 수 있음
    print(_clicks);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.text,
            style: const TextStyle(fontSize: Sizes.size36),
          ),
          Text(
            "$_clicks",
            style: const TextStyle(fontSize: Sizes.size36),
          ),
          TextButton(
            onPressed: _increase,
            child: const Text(
              "+",
              style: TextStyle(fontSize: Sizes.size36),
            ),
          ),
        ],
      ),
    );
  }
}
