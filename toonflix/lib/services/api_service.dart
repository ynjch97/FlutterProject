// ignore_for_file: slash_for_doc_comments

import 'package:http/http.dart' as http;

/**API 조회 클래스
 * - Widget 이 아닌 하나의 클래스
 * - HTTP 관련 패키지 설치 -> as ALIAS 로 이름을 지정하여 사용 가능
 */
class ApiService {
  final String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  final String today = "today";

  void getTodaysToons() async {
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
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print(response.body);
      return;
    }
    throw Error();
  }
}
