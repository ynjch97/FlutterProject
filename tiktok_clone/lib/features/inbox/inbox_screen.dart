import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/activity_screen.dart';
import 'package:tiktok_clone/features/inbox/chats_screen.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

// BuildContext context 를 많이 사용할 바엔 StatefulWidget 이 좋지만,
// StatelessWidget 를 사용하는 것을 권장
class _InboxScreenState extends State<InboxScreen> {
  // DM 전송 버튼
  void _onDmPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ChatsScreen(),
      ),
    );
  }

  // Activity 클릭
  void _onActivityTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ActivityScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text('Inbox'),
        actions: [
          IconButton(
            onPressed: _onDmPressed,
            icon: const FaIcon(
              FontAwesomeIcons.paperPlane,
              size: Sizes.size20,
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          // ListView 내에서 ListTile 을 사용하여 관련 속성 사용 가능
          ListTile(
            onTap: _onActivityTap,
            // selected: true,
            // selectedColor: Theme.of(context).primaryColor,
            title: const Text(
              'Activity',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Sizes.size16,
              ),
            ),
            // leading 가장 앞에, trailing 가장 뒤에 나타날 위젯
            trailing: const FaIcon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size14,
              color: Colors.black,
            ),
          ),
          // 가로선 (ListView.separated 를 사용하면 builder 도 추가해야하기 때문에 Container 로 사용)
          Container(
            height: Sizes.size1,
            color: Colors.grey.shade200,
          ),
          ListTile(
            leading: Container(
              width: Sizes.size52,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: const Center(
                child: FaIcon(
                  FontAwesomeIcons.users,
                  color: Colors.white,
                ),
              ),
            ),
            title: const Text(
              'New followers',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Sizes.size16,
              ),
            ),
            subtitle: const Text(
              'Messages from followers will appear here',
              style: TextStyle(
                fontSize: Sizes.size14,
              ),
            ),
            trailing: const FaIcon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size14,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
