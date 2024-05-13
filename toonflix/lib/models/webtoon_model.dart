class WebtoonModel {
  final String id, title, thumb;

  WebtoonModel({
    required this.id,
    required this.title,
    required this.thumb,
  });

  // named constructor : 이름이 있는 클래스 생성자
  WebtoonModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        thumb = json['thumb'];
}
