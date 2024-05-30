import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  // List.generate : 리스트 생성 -> 20개
  final List<String> _notifications = List.generate(20, (index) => "${index}h");

  void _onDismissed(String notification) {
    // List 에서 제거
    _notifications.remove(notification);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All activity"),
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
