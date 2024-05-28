import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class PostVideoButton extends StatelessWidget {
  final bool isTapDown;

  const PostVideoButton({super.key, required this.isTapDown});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        /**Positioned : Stack 내부의 element 를 이동시킬 수 있게 해줌
         * 사용 조건 : Positioned 는 Stack 안에서 정해진 크기가 있어야 함 + 움직이기 위한 기준점이 있어야 함
         * Container => Stack 이 Container 크기와 맞춰짐 (그 외 overflow 되는 것은 전부 숨기게 됨)
         * clipBehavior: Clip.none => clipping(잘라내어진) 요소들도 보여지도록 함
         */
        Positioned(
          right: Sizes.size18,
          child: Container(
            height: Sizes.size30,
            width: Sizes.size24,
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size10),
            decoration: BoxDecoration(
              color: isTapDown
                  ? Theme.of(context).primaryColor
                  : const Color(0xff61D4F0),
              borderRadius: BorderRadius.circular(Sizes.size8),
            ),
          ),
        ),
        Positioned(
          left: Sizes.size18,
          child: Container(
            height: Sizes.size30,
            width: Sizes.size24,
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size10),
            decoration: BoxDecoration(
              color: isTapDown
                  ? const Color(0xff61D4F0)
                  : Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(Sizes.size8),
            ),
          ),
        ),
        Container(
          height: Sizes.size30,
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Sizes.size8),
          ),
          child: const Center(
            child: FaIcon(
              FontAwesomeIcons.plus,
              color: Colors.black,
              size: Sizes.size18,
            ),
          ),
        )
      ],
    );
  }
}
