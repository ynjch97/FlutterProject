// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

/**애니메이션 효과
 * 1. AnimationController 의 value 를 수정 => controller 에 event listener 룰 추가 => setState() 로 rebuild
 * 2. Animation Builder 사용
 * 3. 현재 방법 : _animation 과 _animationController 을 연결하기만 함
 */

// SingleTickerProviderStateMixin : Ticker 를 가져다주고, widget tree 에 없는 widget 때문에 리소스 낭비하는 것을 방지
class _ActivityScreenState extends State<ActivityScreen>
    with SingleTickerProviderStateMixin {
  // List.generate : 리스트 생성 -> 20개
  final List<String> _notifications = List.generate(20, (index) => "${index}h");

  // this 를 참조하려면, late 선언 후 initState() 에서 지정하거나, late 선언과 함께 사용해야 함-!
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );

  // 숫자 값이 아닌 다른 애니메이션을 추가 (Color, Position, Turn 등)
  // Animation<double> 의 자료형과 begin/end 자료형이 동일해야 함
  late final Animation<double> _animation =
      Tween(begin: 0.0, end: 0.5).animate(_animationController);

  void _onDismissed(String notification) {
    // List 에서 제거
    _notifications.remove(notification);
    setState(() {});
  }

  void _onTitleTap() {
    if (_animationController.isCompleted) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: _onTitleTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("All activity"),
              Gaps.h6,
              RotationTransition(
                turns: _animation,
                child: const FaIcon(
                  FontAwesomeIcons.chevronDown,
                  size: Sizes.size14,
                ),
              )
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          Gaps.v14,
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size12,
            ),
            child: Text(
              'New',
              style: TextStyle(
                  fontSize: Sizes.size14, color: Colors.grey.shade500),
            ),
          ),
          Gaps.v14,
          /**Dismissible : 옆으로 밀어내는 동작으로 삭제 등을 처리할 때 사용
           * - 옆으로 미는 동작을 통해 Widget 을 사라지게 하면(Dismiss) Flutter 가 그만 렌더링 할 것을 요구함
           * - 실제로 build 메서드 안에서 지워주지 않으면 에러 발생
           * => List 를 기반으로 Notification 을 만들어서 List 아이템을 제거, setState() 설정으로 화면 rebuild
           *    Dismiss 된 Widget 은 위젯 트리에서 완전히 삭제
           */
          for (var notification in _notifications)
            Dismissible(
              key: Key(notification), // 실제 unique key
              // Dismiss 시 실행될 함수 지정 (direction : 스와이프한 방향)
              onDismissed: (direction) => _onDismissed(notification),
              background: Container(
                alignment: Alignment.centerLeft,
                color: Colors.green,
                child: const Padding(
                  padding: EdgeInsets.only(
                    left: Sizes.size15,
                  ),
                  child: FaIcon(
                    FontAwesomeIcons.checkDouble,
                    color: Colors.white,
                    size: Sizes.size30,
                  ),
                ),
              ),
              secondaryBackground: Container(
                alignment: Alignment.centerRight,
                color: Colors.red,
                child: const Padding(
                  padding: EdgeInsets.only(
                    right: Sizes.size15,
                  ),
                  child: FaIcon(
                    FontAwesomeIcons.trashCan,
                    color: Colors.white,
                    size: Sizes.size30,
                  ),
                ),
              ),
              child: ListTile(
                minVerticalPadding: Sizes.size16,
                // contentPadding: EdgeInsets.zero, // Padding 없애기
                leading: Container(
                  width: Sizes.size52,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey.shade400,
                      width: Sizes.size1,
                    ),
                  ),
                  child: const Center(
                    child: FaIcon(
                      FontAwesomeIcons.bell,
                      color: Colors.black,
                    ),
                  ),
                ),
                // Row 를 사용하지 않고도 다양한 스타일의 텍스트를 하나의 위젯에서 관리할 수 있음
                title: RichText(
                  text: TextSpan(
                    text: "Account updates:",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: Sizes.size16,
                    ),
                    children: [
                      const TextSpan(
                        text: " Upload longer videos. Let's try it.",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      TextSpan(
                        text: " $notification",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
                trailing: const FaIcon(
                  FontAwesomeIcons.chevronRight,
                  size: Sizes.size16,
                ),
              ),
            )
        ],
      ),
    );
  }
}
