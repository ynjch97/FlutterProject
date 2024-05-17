// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/services/api_service.dart';

import '../widgets/episode_widget.dart';

/**상세 페이지
 * - 단순히 Widget 의 개념임
 * - 더 중요한 것은 - 위젯 전환 애니메이션 효과, 내비게이션 바
 */
class DetailScreen extends StatefulWidget {
  /**DetailScreen > webtoon 데이터를 _DetailScreenState 클래스에서 사용하는 경우
   * widget 을 붙여주면 됨 (widget.webtoon.thumb)
  */
  final WebtoonModel webtoon;

  // 생성자에 WebtoonModel 파라미터 넣어주기 : 웹툰 상세 정보 조회를 위함
  const DetailScreen({
    super.key,
    required this.webtoon,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  /**The instance member 'webtoon' can's be accessed in an initializer. Try replacing the reference to the instance member with a different expression
   * - final Future<WebtoonDetailModel> webtoonDetail = ApiService.getToonById(widget.webtoon.id);
   * - getToonById 는 파라미터로 id 를 받음
   * - Future webtoonDetail 프로퍼티를 초기화할 때 webtoon 프로퍼티에 접근 불가
   * - late 변수 선언, initState() 에서 define (이때 widget.~ 으로 데이터 사용)
   */
  late Future<WebtoonDetailModel> webtoonDetail;
  late Future<List<WebtoonEpisodeModel>> webtoonEpisodes;
  /**초기화하고 싶은 값이 있지만, constructor 에서 불가능한 경우 late 사용
   * initState() 는 항상 build() 보다 먼저, 단 한 번만 실행된다는 특징
   */

  @override
  void initState() {
    super.initState();
    webtoonDetail = ApiService.getToonById(widget.webtoon.id);
    webtoonEpisodes = ApiService.getLatestEpisodesById(widget.webtoon.id);
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold : screen 을 위한 기본적인 레이아웃, 설정을 제공
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.black,
        elevation: 2, // 음영을 주기 위해 surfaceTintColor, shadowColor 와 함께 사용
        centerTitle: true,
        title: Text(
          widget.webtoon.title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: widget.webtoon.id,
                  child: Container(
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
                      widget.webtoon.thumb,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: webtoonDetail,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data!.about,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${snapshot.data!.genre} / ${snapshot.data!.age}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF03C75A),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 25,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: FutureBuilder(
                  future: webtoonEpisodes,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      // 간단하게 구현할 때는 ListView 대신 Column 을 사용하는 것이 낫다
                      // ListView, ListViewBuilder => 리스트가 길고 최적화가 중요할 때 사용
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var episode in snapshot.data!)
                            Episode(
                              episode: episode,
                              webtoonId: widget.webtoon.id,
                            ),
                        ],
                      );
                    }

                    return Container();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
