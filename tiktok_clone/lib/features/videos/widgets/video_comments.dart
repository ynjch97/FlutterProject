import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({super.key});

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  // 사용자가 댓글을 쓰고 있으면 전송할 화살표 아이콘을 넣어야 하기 때문에 flag 값 필요
  bool _isWriting = false;

  void _onClosePressed() {
    Navigator.of(context).pop();
  }

  // body 클릭 시, 키보드에 대한 포커스를 해제
  void _stopWriting() {
    FocusScope.of(context).unfocus();
    setState(() {
      _isWriting = false;
    });
  }

  void _onStartWriting() {
    setState(() {
      _isWriting = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // MediaQuery : 폰의 정보를 전달
    final size = MediaQuery.of(context).size;

    return Container(
      clipBehavior: Clip.hardEdge,
      height: size.height * 0.75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size14),
      ),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade50,
          // 자동으로 생긴 back button 을 없애줌 (새창의 개념으로 열린 창이지만, 현재는 뒤로가기 개념이 아님)
          automaticallyImplyLeading: false,
          title: const Text("22796 comments"),
          actions: [
            IconButton(
              onPressed: _onClosePressed,
              icon: const FaIcon(FontAwesomeIcons.xmark),
            ),
          ],
        ),
        body: GestureDetector(
          onTap: _stopWriting,
          child: Stack(
            children: [
              ListView.separated(
                itemCount: 10,
                padding: const EdgeInsets.symmetric(
                  vertical: Sizes.size10,
                  horizontal: Sizes.size16,
                ),
                separatorBuilder: (context, index) => Gaps.v20,
                itemBuilder: (context, index) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 18,
                      child: Text(
                        "YNJCH",
                        style: TextStyle(fontSize: Sizes.size10),
                      ),
                    ),
                    Gaps.h10,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'YNJCH',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: Sizes.size14,
                                color: Colors.grey.shade500),
                          ),
                          Gaps.v3,
                          const Text(
                              "That's not it l've seen the same thing but also in a cave,That's not it l've seen the same thing but also in a cave,")
                        ],
                      ),
                    ),
                    Gaps.h10,
                    Column(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.heart,
                          size: Sizes.size20,
                          color: Colors.grey.shade500,
                        ),
                        Gaps.v2,
                        Text(
                          '52.2K',
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: Sizes.size12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                width: size.width,
                child: BottomAppBar(
                  color: Colors.white,
                  surfaceTintColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.size1,
                      vertical: Sizes.size5,
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          foregroundImage: NetworkImage(
                            "https://avatars.githubusercontent.com/u/69029517",
                          ),
                          child: Text(
                            "YNJCH",
                            style: TextStyle(fontSize: Sizes.size8),
                          ),
                        ),
                        Gaps.h10,
                        // TextField 를 Expanded 로 감싸주지 않으면 오류 발생
                        Expanded(
                          /**TextField 탭 -> 키보드 등장 시 백그라운드 영상이 세로로 찌그러짐
                       * - main 화면은 키보드가 등장했다는 것을 인지함 (main_navigation_screen.dart)
                       * - resizeToAvoidBottomInset: false => 키보드가 화면을 가리지 않도록 default true 세팅되기 때문에 영상이 찌그러지므로 false
                       * TextField 탭 -> 입력 필드가 키보드에 가려짐
                       * - bottomNavigationBar 는 키보드가 올라오면 숨겨짐
                       * - body 영역을 Stack 으로 감싸고 BottomAppBar 를 이곳에 붙임
                       */
                          child: SizedBox(
                            height: Sizes.size44,
                            child: TextField(
                              onTap: _onStartWriting,
                              // expands: true => minLines, maxLines 를 null 로 설정해야만 함
                              expands: true,
                              minLines: null,
                              maxLines: null,
                              textInputAction:
                                  TextInputAction.newline, // 줄바꿈으로 설정
                              cursorColor: Theme.of(context).primaryColor,
                              decoration: InputDecoration(
                                hintText: "Add comment...",
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(Sizes.size10),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: Sizes.size12,
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                      right: Sizes.size10),
                                  child: Row(
                                    // 전체 공간을 차지하지 않도록 MainAxisSize.min 설정
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.at,
                                        color: Colors.grey.shade800,
                                        size: Sizes.size20,
                                      ),
                                      Gaps.h10,
                                      FaIcon(
                                        FontAwesomeIcons.gift,
                                        color: Colors.grey.shade800,
                                        size: Sizes.size20,
                                      ),
                                      Gaps.h10,
                                      FaIcon(
                                        FontAwesomeIcons.faceSmile,
                                        color: Colors.grey.shade800,
                                        size: Sizes.size20,
                                      ),
                                      if (_isWriting) Gaps.h10,
                                      if (_isWriting)
                                        GestureDetector(
                                          onTap: _stopWriting,
                                          child: FaIcon(
                                            FontAwesomeIcons.circleArrowUp,
                                            color:
                                                Theme.of(context).primaryColor,
                                            size: Sizes.size20,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
