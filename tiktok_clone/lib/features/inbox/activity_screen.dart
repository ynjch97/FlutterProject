// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/routes.dart';
import 'package:tiktok_clone/constants/sizes.dart';

final List<Map<String, dynamic>> _tabs = [
  {
    "title": "All activity",
    "icon": FontAwesomeIcons.solidMessage,
  },
  {
    "title": "Likes",
    "icon": FontAwesomeIcons.solidHeart,
  },
  {
    "title": "Comments",
    "icon": FontAwesomeIcons.solidComments,
  },
  {
    "title": "Mentions",
    "icon": FontAwesomeIcons.at,
  },
  {
    "title": "Followers",
    "icon": FontAwesomeIcons.solidUser,
  },
  {
    "title": "From TikTok",
    "icon": FontAwesomeIcons.tiktok,
  }
];

class ActivityScreen extends StatefulWidget {
  static const routeURL = Routes.activityScreen;
  static const routeName = RoutesName.activityScreen;

  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

/**애니메이션 효과
 * 1. AnimationController 의 value 를 수정 => controller 에 event listener 룰 추가 => setState() 로 rebuild
 * 2. Animation Builder 사용
 * 3. 현재 방법 : _animation 여러 개를 하나의 _animationController 에 연결하기만 함 (추천)
 */

// SingleTickerProviderStateMixin : Ticker 를 가져다주고, widget tree 에 없는 widget 때문에 리소스 낭비하는 것을 방지
class _ActivityScreenState extends State<ActivityScreen>
    with SingleTickerProviderStateMixin {
  // List.generate : 리스트 생성 -> 20개
  final List<String> _notifications = List.generate(20, (index) => "${index}h");

  // 오버레이(overlay) : 패널 뒤에 있는 것 => 이 부분을 어둡게 만들기 위해 변수 선언
  bool _showBarrier = false;

  // this 를 참조하려면, late 선언 후 initState() 에서 지정하거나, late 선언과 함께 사용해야 함-!
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );

  /* ====== 숫자 값이 아닌 다른 애니메이션을 추가 (Color, Position, Turn 등) ====== */

  // Animation<double> 의 자료형과 begin/end 자료형이 동일해야 함
  late final Animation<double> _arrowAnimation = Tween(
    begin: 0.0,
    end: 0.5,
  ).animate(_animationController);

  // Animation<Offset> 의 자료형과 동일한 begin/end 을 이용해, 숨겨져 있다가 나타나는 방식으로
  late final Animation<Offset> _panelAnimation = Tween(
    begin: const Offset(0, -1),
    end: Offset.zero,
  ).animate(_animationController);

  // 오버레이(overlay) 어두워지는 효과 => AnimatedModalBarrier 위젯에 적용
  late final Animation<Color?> _barrierAnimation = ColorTween(
    begin: Colors.transparent,
    end: Colors.black38,
  ).animate(_animationController);

  /* =========================================================================== */

  void _onDismissed(String notification) {
    // List 에서 제거
    _notifications.remove(notification);
    setState(() {});
  }

  void _toggleAnimations() async {
    if (_animationController.isCompleted) {
      await _animationController.reverse();
    } else {
      _animationController.forward();
    }

    setState(() {
      // 사라질 때는 애니메이션 효과 후 사라져야 하기 때문에, setState 로 인해 바로 사라지는 것을 방지 => await
      _showBarrier = !_showBarrier;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: _toggleAnimations,
          child: Row(
            mainAxisSize: MainAxisSize.min, // 뒤로가기 버튼이 있어도 가운데 정렬
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("All activity"),
              Gaps.h6,
              // turns 속성을 이용해 Rotation 효과
              RotationTransition(
                turns: _arrowAnimation,
                child: const FaIcon(
                  FontAwesomeIcons.chevronDown,
                  size: Sizes.size14,
                ),
              )
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView(
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
          // 알림 목록의 터치를 막으므로, build 시 사라질 수 있도록 if 문 처리
          if (_showBarrier)
            // color 속성을 이용해 ModalBarrier 효과
            // 모든 이벤트를 무시하도록 설정
            AnimatedModalBarrier(
              color: _barrierAnimation,
              // onDismiss 시, 패널이 올라가고 ModalBarrier 가 꺼지는 등 효과를 주기 위해 true 로 설정
              dismissible: true,
              onDismiss: _toggleAnimations,
            ),
          // position 속성을 이용해 Slide 효과
          SlideTransition(
            position: _panelAnimation,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Sizes.size7),
                  bottomRight: Radius.circular(Sizes.size7),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // 최소한의 세로 공간 사용
                children: [
                  for (var tab in _tabs)
                    ListTile(
                      title: Row(
                        children: [
                          FaIcon(
                            tab["icon"],
                            color: Colors.black,
                            size: Sizes.size16,
                          ),
                          Gaps.h20,
                          Text(
                            tab["title"],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
