import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All activity"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          // horizontal: Sizes.size20,
          horizontal: 0,
        ),
        children: [
          Gaps.v14,
          Text(
            'New',
            style:
                TextStyle(fontSize: Sizes.size14, color: Colors.grey.shade500),
          ),
          Gaps.v14,
          /**Dismissible : 옆으로 밀어내는 동작으로 삭제 등을 처리할 때 사용
           * - 옆으로 미는 동작을 통해 Widget 을 사라지게 하면(Dismiss) Flutter 가 그만 렌더링 할 것을 요구함
           */
          Dismissible(
            key: const Key("x"),
            background: Container(
              alignment: Alignment.centerLeft,
              color: Colors.green,
              child: const Padding(
                padding: EdgeInsets.only(
                  left: Sizes.size10,
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
                  right: Sizes.size10,
                ),
                child: FaIcon(
                  FontAwesomeIcons.trashCan,
                  color: Colors.white,
                  size: Sizes.size30,
                ),
              ),
            ),
            child: ListTile(
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
                      text: " 1h",
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
