class WebtoonEpisodeModel {
  final String id, title, rating, date;

  // Json Map 으로 초기화하기
  WebtoonEpisodeModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        rating = json['rating'],
        date = json['date'];
}
