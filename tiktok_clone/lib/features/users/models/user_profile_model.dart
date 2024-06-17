// ignore_for_file: slash_for_doc_comments

/** User? get user => _firebaseAuth.currentUser;
 *  => User 의 속성값 확인하여 필요한 값들을 확인
 */
class UserProfileModel {
  final String uid; // 유저의 고유 번호
  final String email;
  final String name;
  final String bio;
  final String link;

  UserProfileModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.bio,
    required this.link,
  });

  UserProfileModel.empty()
      : uid = "",
        email = "",
        name = "",
        bio = "",
        link = "";
}
