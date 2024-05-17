import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/services/api_service.dart';
import 'package:toonflix/widgets/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  // const HomeScreen({super.key});
  // 클래스 안에 Future 가 있기 때문에, const 는 제거해야 함
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

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
        title: const Text(
          'Today Webtoon',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // snapshot 이 데이터를 가지고 있는 경우
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: makeList(snapshot),
                )
                // The following assertion was thrown during performResize
                // ListView 에 설정된 높이가 없음 -> 제한 없는 높이값이 넘어옴 -> Expanded() 로 해결
              ],
            );
          }

          // 아직 값이 안넘어온 상태 = 로딩 중
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF03C75A),
            ),
          );
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal, // 스크롤 방향
      itemCount: snapshot.data!.length, // 몇 개의 아이템을 build 할지
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      itemBuilder: (context, index) {
        // 데이터가 있다고 확신하기 위해 ! 기호 사용하여 오류 제거
        var webtoon = snapshot.data![index];
        return Webtoon(webtoon: webtoon);
      },
      separatorBuilder: (context, index) {
        // 아이템 사이 렌더링 될 Widget 설정
        return const SizedBox(
          width: 40,
        );
      },
    );
  }
}
