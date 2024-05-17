// ignore_for_file: slash_for_doc_comments

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:toonflix/models/webtoon_model.dart';

/**API 조회 클래스
 * - Widget 이 아닌 하나의 클래스
 * - HTTP 관련 패키지 설치 -> as ALIAS 로 이름을 지정하여 사용 가능
 */
class ApiService {
  // state 가 없는 클래스이므로 static 사용
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  static Future<List<WebtoonModel>> getTodaysToons() async {
    // 테스트를 위한 딜레이
    await Future.delayed(const Duration(seconds: 1));

    /**Future
     * - 미래에 받을 값의 타입
     * - http.get() 의 return 값 : Future<Response>
     * - 나중에 완료될 값이지만, 완료되면 Response 를 반환한다는 뜻
     * 
     * await
     * - getTodaysToons() 내에서 http.get() 함수가 실행 완료될 때까지 기다려야 함
     * - API 요청이 처리되고 응답이 반환될 때까지 async(비동기) programming 처리
     * - 비동기 함수(asynchronous function) 내에서만 사용 가능
     */
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url); // JSON 형식의 데이터

    if (response.statusCode == 200) {
      // response.body : String 형식
      // jsonDecode() : return 값이 `dynamic` 타입이므로 어떤 타입이든 수용할 수 있게 됨
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        // named constructor(이름이 있는 클래스 생성자) WebtoonModel 로 초기화
        webtoonInstances.add(WebtoonModel.fromJson(webtoon));
      }
      return webtoonInstances;
    }
    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.get(url); // JSON 형식의 데이터

    if (response.statusCode == 200) {
      // `dynamic` 타입으로 받고, class 생성하여 값 전달
      final dynamic webtoon = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(webtoon);
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(
      String id) async {
    List<WebtoonEpisodeModel> episopdeInstances = [];
    final url = Uri.parse('$baseUrl/$id/episodes');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        episopdeInstances.add(WebtoonEpisodeModel.fromJson(episode));
      }
      return episopdeInstances;
    }
    throw Error();
  }
}
