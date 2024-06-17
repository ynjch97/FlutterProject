import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/routes.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/settings/settings_screen.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';
import 'package:tiktok_clone/features/users/widgets/avatar.dart';
import 'package:tiktok_clone/features/users/widgets/persistent_tab_bar.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  static String routeURL = Routes.userProfileScreen;

  final String username;
  final String tab;

  const UserProfileScreen({
    super.key,
    required this.username,
    required this.tab,
  });

  @override
  UserProfileScreenState createState() => UserProfileScreenState();
}

class UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  void _onGearPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(userProvider).when(
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          error: (error, stackTrace) => Center(
            child: Text(
              error.toString(),
            ),
          ),
          data: (data) => SafeArea(
            child: DefaultTabController(
              length: 2,
              initialIndex: widget.tab == "likes" ? 1 : 0,
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      title: Text(data.name),
                      actions: [
                        IconButton(
                          onPressed: _onGearPressed,
                          icon: const FaIcon(
                            FontAwesomeIcons.gear,
                            size: Sizes.size20,
                          ),
                        )
                      ],
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Avatar(
                            name: data.name,
                            hasAvatar: data.hasAvatar,
                            uid: data.uid,
                          ),
                          Gaps.v20,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "@${data.name}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: Sizes.size18,
                                ),
                              ),
                              Gaps.h5,
                              FaIcon(
                                FontAwesomeIcons.solidCircleCheck,
                                size: Sizes.size16,
                                color: Colors.blue.shade500,
                              ),
                            ],
                          ),
                          Gaps.v24,
                          SizedBox(
                            height: Sizes.size50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    const Text(
                                      "97",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: Sizes.size18,
                                      ),
                                    ),
                                    Gaps.v3,
                                    Text(
                                      "Following",
                                      style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: Sizes.size14,
                                      ),
                                    )
                                  ],
                                ),
                                // VerticalDivider : SizedBox 로 감싸서 높이 지정을 해줘야 화면에서 볼 수 있음
                                VerticalDivider(
                                  width: Sizes.size32,
                                  thickness: Sizes.size1,
                                  color: Colors.grey.shade400,
                                  indent: Sizes.size14,
                                  endIndent: Sizes.size14,
                                ),
                                Column(
                                  children: [
                                    const Text(
                                      "10M",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: Sizes.size18,
                                      ),
                                    ),
                                    Gaps.v3,
                                    Text(
                                      "Followers",
                                      style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: Sizes.size14,
                                      ),
                                    ),
                                  ],
                                ),
                                VerticalDivider(
                                  width: Sizes.size32,
                                  thickness: Sizes.size1,
                                  color: Colors.grey.shade400,
                                  indent: Sizes.size14,
                                  endIndent: Sizes.size14,
                                ),
                                Column(
                                  children: [
                                    const Text(
                                      "194.3M",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: Sizes.size18,
                                      ),
                                    ),
                                    Gaps.v3,
                                    Text(
                                      "Likes",
                                      style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: Sizes.size14,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Gaps.v14,
                          FractionallySizedBox(
                            widthFactor: 0.33,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: Sizes.size12,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(Sizes.size4),
                                ),
                              ),
                              child: const Text(
                                'Follow',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: Sizes.size14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Gaps.v14,
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Sizes.size32,
                            ),
                            child: Text(
                              "All highlights and where to watch live matches on FIFA+ I wonder how it would loook",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: Sizes.size14,
                              ),
                            ),
                          ),
                          Gaps.v12,
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.link,
                                size: Sizes.size12,
                              ),
                              Gaps.h4,
                              Text(
                                "https://nomadcoders.co",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: Sizes.size14,
                                ),
                              ),
                            ],
                          ),
                          Gaps.v20,
                        ],
                      ),
                    ),
                    SliverPersistentHeader(
                      // TabBar 사용을 위해 DefaultTabController 로 감싸줘야 함
                      delegate: PersistentTabBar(),
                      pinned: true,
                    ),
                  ];
                },
                body: TabBarView(
                  children: [
                    GridView.builder(
                      // GridView.builder 의 스크롤을 막음
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 20,
                      padding: EdgeInsets.zero,
                      // gridDelegate : GridView 를 구성하는데 도움을 주는 역할
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: Sizes.size2,
                        mainAxisSpacing: Sizes.size2,
                        // 가로/세로 비율
                        childAspectRatio: 9 / 14,
                      ),
                      itemBuilder: (context, index) => Column(
                        // Todo : wrap Stack -> 조회수 표시 code challenge
                        children: [
                          // 특정한 비율을 따르도록 설정할 수 있음
                          AspectRatio(
                            aspectRatio: 9 / 14,
                            // FadeInImage.assetNetwork : 네트워크에서 이미지를 로딩하는 동안에는 assets 폴더 내의 이미지를 보여줌
                            child: FadeInImage.assetNetwork(
                              fit: BoxFit.cover, // 부모 요소에 어떻게 fit 시킬건지
                              placeholder: "assets/images/kota.jpg",
                              image:
                                  "https://images.unsplash.com/photo-1673844969019-c99b0c933e90?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80",
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Center(
                      child: Text('Page two'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
  }
}
