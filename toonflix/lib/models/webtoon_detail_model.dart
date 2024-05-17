class WebtoonDetailModel {
  final String title, about, genre, age;

  const WebtoonDetailModel({
    required this.title,
    required this.about,
    required this.genre,
    required this.age,
  });

  WebtoonDetailModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        about = json['about'],
        genre = json['genre'],
        age = json['age'];
}
