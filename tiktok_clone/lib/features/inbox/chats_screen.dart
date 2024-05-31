import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text("Direct Messages"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const FaIcon(FontAwesomeIcons.plus),
          ),
        ],
      ),
      /**
       * - ListView.builder 와 동일한 기능 + 애니메이션을 포함
       * 
       */
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: Sizes.size10),
        children: [
          ListTile(
            leading: const CircleAvatar(
              radius: 30,
              foregroundImage: NetworkImage(
                "https://avatars.githubusercontent.com/u/69029517",
              ),
              child: Text(
                "YNJCH",
                style: TextStyle(fontSize: Sizes.size10),
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  "YNJCH",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "2:54 PM",
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: Sizes.size12,
                  ),
                ),
              ],
            ),
            subtitle: const Text("Don't forget to make video 🎞️"),
          ),
        ],
      ),
    );
  }
}
