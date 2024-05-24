import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/onboarding/tutorial_screen.dart';

import 'widgets/interest_button.dart';

const interests = [
  "Daily Life",
  "Comedy",
  "Entertainment",
  "Animals",
  "Food",
  "Beauty & Style",
  "Drama",
  "Learning",
  "Talent",
  "Sports",
  "Auto",
  "Family",
  "Fitness & Health",
  "DIY & Life Hacks",
  "Arts & Crafts",
  "Dance",
  "Outdoors",
  "Oddly Satisfying",
  "Home & Garden",
  "Daily Life",
  "Comedy",
  "Entertainment",
  "Animals",
  "Food",
  "Beauty & Style",
  "Drama",
  "Learning",
  "Talent",
  "Sports",
  "Auto",
  "Family",
  "Fitness & Health",
  "DIY & Life Hacks",
  "Arts & Crafts",
  "Dance",
  "Outdoors",
  "Oddly Satisfying",
  "Home & Garden",
];

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  final ScrollController _scrollController = ScrollController();

  bool _showTitle = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll); // 스크롤 동작 listener
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // offset : 위에서부터 얼마나 스크롤 됐는지 알 수 있음 (0에서 시작해 아래로 스크롤 할수록 커짐)
    if (_scrollController.offset > 100) {
      if (_showTitle) return; // 최초 한 번 제외하고는 setState 실행 X
      setState(() {
        _showTitle = true;
      });
    } else {
      setState(() {
        _showTitle = false;
      });
    }
  }

  // StatefulWidget > BuildContext context 받지 않아도 됨
  void _onNextTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const TutorialScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // AnimatedOpacity : 움직임에 따라 투명도 조절
        title: AnimatedOpacity(
          opacity: _showTitle ? 1 : 0,
          duration: const Duration(milliseconds: 300),
          child: const Text("Choose your interests"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            left: Sizes.size24, right: Sizes.size24, bottom: Sizes.size16),
        child: Scrollbar(
          controller: _scrollController,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v32,
                const Text(
                  "Choose your interests",
                  style: TextStyle(
                    fontSize: Sizes.size40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v20,
                const Text(
                  "Get better video recommendations",
                  style: TextStyle(
                    fontSize: Sizes.size20,
                  ),
                ),
                Gaps.v48,
                // chilren 을 가로로 배치하며, overflow 시 하단으로 내려감
                Wrap(
                  runSpacing: 15, // 세로
                  spacing: 15, // 가로
                  children: [
                    /**Collection for 방식
                     * - ListViewBuilder 이용, 사용자가 보는 부분만 render 하는 것이 최적화 방법
                     * - 개수가 많지 않고 Widget 도 가벼워서 현재는 Collection for 를 사용
                     */
                    for (var interest in interests)
                      InterestButton(interest: interest),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 2,
        height: 120,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size24,
            vertical: Sizes.size16,
          ),
          child: GestureDetector(
            onTap: _onNextTap,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size16,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: const Text(
                'Next',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: Sizes.size16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
