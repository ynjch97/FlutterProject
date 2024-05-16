import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/screens/detail_screen.dart';

class Webtoon extends StatelessWidget {
  final WebtoonModel webtoon;

  // 생성자에 WebtoonModel 파라미터 넣어주기
  const Webtoon({
    super.key,
    required this.webtoon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(webtoon: webtoon),
            // builder : route 를 만드는 함수
            fullscreenDialog: true,
          ),
          // StatelessWidget 을 애니메이션 효과로 감싸, 스크린처럼 보이도록 함
        );
      },
      child: Column(
        children: [
          Container(
            width: 250,
            clipBehavior: Clip.hardEdge,
            // BorderRadius.circular 적용이 되지 않는 이유 : clipBehavior 때문
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  blurRadius: 7,
                  offset: const Offset(3, 3),
                  color: Colors.black.withOpacity(0.5),
                )
              ],
            ),
            child: Image.network(
              webtoon.thumb,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            webtoon.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
